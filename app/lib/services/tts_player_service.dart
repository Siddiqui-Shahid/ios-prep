import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/models.dart';
import 'speech_utils.dart';

enum VoiceAccent { us, gb }

/// Background-capable TTS with clear US/GB voices, sentence pacing, ±5s seek.
class TtsPlayerService extends BaseAudioHandler with ChangeNotifier {
  TtsPlayerService() {
    _init();
  }

  final FlutterTts _tts = FlutterTts();
  List<ScriptSection> _sections = const [];
  List<String> _sentences = const [];
  int _sectionIndex = 0;
  int _sentenceIndex = 0;
  double _speed = 1.0;
  bool _playing = false;
  bool _initialized = false;
  Future<void>? _initFuture;
  bool _advancing = false;
  String _title = 'iOS Prep';
  String _subtitle = '';
  VoiceAccent _accent = VoiceAccent.us;
  String _currentWord = '';
  String _currentSentence = '';

  VoidCallback? onSectionChanged;
  VoidCallback? onChapterCompleted;

  int get sectionIndex => _sectionIndex;
  int get sentenceIndex => _sentenceIndex;
  double get speed => _speed;
  bool get isPlaying => _playing;
  VoiceAccent get accent => _accent;
  String get currentWord => _currentWord;
  String get currentSentence => _currentSentence;
  List<ScriptSection> get sections => _sections;
  List<String> get sentences => _sentences;
  ScriptSection? get currentSection => _sections.isEmpty
      ? null
      : _sections[_sectionIndex.clamp(0, _sections.length - 1)];

  Future<void> _init() async {
    if (_initialized) return;
    _initFuture ??= _doInit();
    try {
      await _initFuture!.timeout(const Duration(seconds: 10));
    } catch (_) {
      // Allow a later retry if TTS was slow/hung on first launch.
      if (!_initialized) _initFuture = null;
    }
  }

  Future<void> _doInit() async {
    try {
      final session = await AudioSession.instance
          .timeout(const Duration(seconds: 3));
      await session
          .configure(const AudioSessionConfiguration.speech())
          .timeout(const Duration(seconds: 3));
    } catch (_) {}
    try {
      await _tts.setSharedInstance(true).timeout(const Duration(seconds: 3));
      await _tts
          .awaitSpeakCompletion(true)
          .timeout(const Duration(seconds: 2));
      await _tts.setVolume(1.0).timeout(const Duration(seconds: 2));
      await _tts.setPitch(1.0).timeout(const Duration(seconds: 2));
      try {
        await _tts.setSilence(0).timeout(const Duration(seconds: 1));
      } catch (_) {}
      await _tts
          .setIosAudioCategory(
            IosTextToSpeechAudioCategory.playback,
            [
              IosTextToSpeechAudioCategoryOptions.allowBluetooth,
              IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
              IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            ],
            IosTextToSpeechAudioMode.spokenAudio,
          )
          .timeout(const Duration(seconds: 3));
    } catch (_) {}
    _tts.setProgressHandler((text, start, end, word) {
      _currentWord = word;
      notifyListeners();
    });
    _tts.setCompletionHandler(() async {
      if (!_playing || _advancing) return;
      await _advanceAfterSentence();
    });
    // Language only on the critical path — voice enumeration can hang on Android.
    try {
      await _tts
          .setLanguage(_accent == VoiceAccent.us ? 'en-US' : 'en-GB')
          .timeout(const Duration(seconds: 3));
      await _applyRate();
    } catch (_) {}
    _initialized = true;
    // Prefer a nicer voice in the background.
    // ignore: unawaited_futures
    _pickPreferredVoice();
  }

  Future<void> configurePreferences({
    required double speed,
    required VoiceAccent accent,
  }) async {
    await _init();
    _speed = speed.clamp(0.5, 16.0);
    _accent = accent;
    try {
      await _tts.setLanguage(
        _accent == VoiceAccent.us ? 'en-US' : 'en-GB',
      );
      await _applyRate();
    } catch (_) {}
    notifyListeners();
    // ignore: unawaited_futures
    _pickPreferredVoice();
  }

  Future<void> setAccent(VoiceAccent accent) async {
    _accent = accent;
    try {
      await _tts.setLanguage(
        _accent == VoiceAccent.us ? 'en-US' : 'en-GB',
      );
    } catch (_) {}
    // ignore: unawaited_futures
    _pickPreferredVoice();
    notifyListeners();
    if (_playing) {
      await _tts.stop();
      await _speakCurrentSentence();
    }
  }

  Future<void> _pickPreferredVoice() async {
    try {
      await _applyAccent().timeout(const Duration(seconds: 2));
    } catch (_) {}
  }

  Future<void> _applyAccent() async {
    final locale = _accent == VoiceAccent.us ? 'en-US' : 'en-GB';
    await _tts.setLanguage(locale);
    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return;
      final preferred = <Map<String, dynamic>>[];
      for (final raw in voices) {
        if (raw is! Map) continue;
        final map = Map<String, dynamic>.from(raw);
        final name = '${map['name'] ?? ''}'.toLowerCase();
        final loc = '${map['locale'] ?? map['localeId'] ?? ''}'.toLowerCase();
        final isUs = loc.contains('en-us') || loc.contains('en_us');
        final isGb = loc.contains('en-gb') ||
            loc.contains('en_gb') ||
            loc.contains('en-uk') ||
            loc.contains('en_uk');
        if (_accent == VoiceAccent.us && !isUs && loc.isNotEmpty) continue;
        if (_accent == VoiceAccent.gb && !isGb && loc.isNotEmpty) continue;
        preferred.add(map);
        if (name.contains('enhanced') ||
            name.contains('premium') ||
            name.contains('neural') ||
            name.contains('siri') ||
            name.contains('quality')) {
          preferred.insert(0, map);
        }
      }
      if (preferred.isEmpty) return;
      final best = preferred.first;
      await _tts.setVoice({
        'name': '${best['name']}',
        'locale': '${best['locale'] ?? best['localeId'] ?? locale}',
      });
    } catch (_) {}
  }

  Future<void> loadChapter({
    required String title,
    required String subtitle,
    required List<ScriptSection> sections,
    int startSection = 0,
    double speed = 1.0,
  }) async {
    // Enable play immediately — never gate UI on TTS init (can hang on first install).
    _playing = false;
    _title = title;
    _subtitle = subtitle;
    _sections = sections;
    _sectionIndex =
        startSection.clamp(0, (sections.length - 1).clamp(0, 9999));
    _speed = speed.clamp(0.5, 16.0);
    _reloadSentences(resetSentence: true);
    _updateMediaItem();
    _emitReady(playing: false);
    notifyListeners();

    await _init();
    try {
      await _tts.stop().timeout(const Duration(seconds: 2));
    } catch (_) {}
    try {
      await _applyRate();
    } catch (_) {}
    _updateMediaItem();
    notifyListeners();
  }

  void _reloadSentences({required bool resetSentence}) {
    final section = currentSection;
    if (section == null) {
      _sentences = const [];
      _sentenceIndex = 0;
      _currentSentence = '';
      _currentWord = '';
      return;
    }
    _sentences = speechUnitsForSection(section.body);
    if (resetSentence) _sentenceIndex = 0;
    _sentenceIndex = _sentenceIndex.clamp(
      0,
      (_sentences.length - 1).clamp(0, 9999),
    );
    _currentSentence = _sentences.isEmpty
        ? ''
        : _sentences
            .skip(_sentenceIndex)
            .firstWhere((s) => !isSpeechPauseCue(s), orElse: () => '');
    _currentWord = '';
  }

  int _speakingUntil = 0;

  /// Breath after main answer (before Follow-ups) / after follow-up questions.
  int _structuralPauseMs({required bool longPause}) {
    final base = longPause ? 950.0 : 700.0;
    // Keep pauses audible even at high speed, but shorten a bit.
    final scaled = base / _speed.clamp(0.75, 3.5);
    return scaled.round().clamp(longPause ? 280 : 220, longPause ? 1100 : 850);
  }

  Future<void> _applyRate() async {
    // iOS: 0.5 ≈ 1x normal, 1.0 ≈ 4x. Android flutter_tts: ~0.5 normal, 1.0 fast.
    // UI speed above 4x stays at max engine rate; we go faster via chunking + less pause.
    await _tts.setSpeechRate(_engineRateForUiSpeed(_speed));
  }

  double _engineRateForUiSpeed(double speed) {
    final capped = speed.clamp(0.5, 4.0);
    final bool ios = defaultTargetPlatform == TargetPlatform.iOS;
    if (ios) {
      if (capped <= 1.0) {
        // 0.5x → ~0.38, 1.0x → 0.5
        return 0.38 + (capped - 0.5) * (0.12 / 0.5);
      }
      // 1x → 0.5, 4x → 1.0
      return (0.5 + (capped - 1.0) * (0.5 / 3.0)).clamp(0.5, 1.0);
    }
    // Android
    if (capped <= 1.0) {
      return 0.45 + (capped - 0.5) * (0.1 / 0.5);
    }
    return (0.55 + (capped - 1.0) * (0.45 / 3.0)).clamp(0.5, 1.0);
  }

  /// How many sentences to speak in one utterance (fewer TTS restarts = less pause).
  int _chunkSize() {
    if (_speed < 1.5) return 1;
    if (_speed < 2.5) return 2;
    if (_speed < 4.0) return 3;
    if (_speed < 8.0) return 5;
    if (_speed < 12.0) return 7;
    return 10;
  }

  /// Soften punctuation so the engine spends less time pausing on , and .
  String _prepareSpeech(String text) {
    var t = text;
    if (_speed >= 1.5) {
      t = t.replaceAll(',', ' ');
      t = t.replaceAll(';', ' ');
      t = t.replaceAll(':', ' ');
      t = t.replaceAll('—', ' ');
      t = t.replaceAll('–', ' ');
      t = t.replaceAll('…', ' ');
    }
    if (_speed >= 3.0) {
      // Inside a chunk, turn sentence ends into brief spaces (less dwell).
      t = t.replaceAll('. ', ' ');
      t = t.replaceAll('? ', ' ');
      t = t.replaceAll('! ', ' ');
      t = t.replaceAllMapped(RegExp(r'[.?!]+$'), (_) => '');
    }
    return t.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  Future<void> setPlaybackRate(
    double speed, {
    bool restartSpeech = true,
  }) async {
    _speed = speed.clamp(0.5, 16.0);
    await _applyRate();
    notifyListeners();
    if (restartSpeech && _playing) {
      await _tts.stop();
      await _speakCurrentSentence();
    }
  }

  @override
  Future<void> setSpeed(double speed) => setPlaybackRate(speed);

  void _updateMediaItem() {
    final section = currentSection;
    mediaItem.add(
      MediaItem(
        id: '${_title}_${_sectionIndex}_$_sentenceIndex',
        title: section?.title ?? _title,
        album: _title,
        artist: _subtitle,
        duration: const Duration(minutes: 5),
      ),
    );
  }

  void _emitReady({required bool playing}) {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.rewind,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.fastForward,
          MediaControl.skipToPrevious,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.skipToNext,
          MediaAction.skipToPrevious,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: AudioProcessingState.ready,
        playing: playing,
      ),
    );
  }

  Future<void> _speakCurrentSentence() async {
    if (_sentences.isEmpty) {
      _reloadSentences(resetSentence: true);
    }
    if (_sentences.isEmpty) return;

    _sentenceIndex = _sentenceIndex.clamp(0, _sentences.length - 1);

    // Honour structural breaths (never spoken aloud).
    while (_sentenceIndex < _sentences.length &&
        isSpeechPauseCue(_sentences[_sentenceIndex])) {
      final long = isSpeechPauseLongCue(_sentences[_sentenceIndex]);
      await Future<void>.delayed(
        Duration(milliseconds: _structuralPauseMs(longPause: long)),
      );
      if (!_playing) return;
      _sentenceIndex++;
    }
    if (_sentenceIndex >= _sentences.length) {
      await _finishSectionOrChapter();
      return;
    }

    // Do not chunk across a pause cue — keeps answer / follow-up breaths intact.
    var end = _sentenceIndex + 1;
    final maxEnd = (_sentenceIndex + _chunkSize()).clamp(0, _sentences.length);
    while (end < maxEnd) {
      if (isSpeechPauseCue(_sentences[end])) break;
      end++;
    }

    _speakingUntil = (end - 1).clamp(0, _sentences.length - 1);
    final joined = _sentences.sublist(_sentenceIndex, end).join(' ');
    _currentSentence = joined;
    _currentWord = '';
    _updateMediaItem();
    _emitReady(playing: true);
    notifyListeners();
    await _tts.speak(_prepareSpeech(joined));
  }

  Future<void> _advanceAfterSentence() async {
    if (!_playing) return;
    _advancing = true;
    try {
      // Tiny gap between ordinary sentences; structural pauses are separate cues.
      final gapMs = _speed >= 2.0
          ? 0
          : _speed >= 1.25
              ? 15
              : (80 / _speed).round().clamp(20, 120);
      if (gapMs > 0) {
        await Future<void>.delayed(Duration(milliseconds: gapMs));
      }
      if (!_playing) return;

      _sentenceIndex = _speakingUntil + 1;
      if (_sentenceIndex < _sentences.length) {
        await _speakCurrentSentence();
        return;
      }

      await _finishSectionOrChapter();
    } finally {
      _advancing = false;
    }
  }

  Future<void> _finishSectionOrChapter() async {
    if (!_playing) return;
    if (_sectionIndex < _sections.length - 1) {
      // Brief beat between Q&A sections (next question).
      await Future<void>.delayed(
        Duration(milliseconds: _structuralPauseMs(longPause: false)),
      );
      if (!_playing) return;
      _sectionIndex++;
      _reloadSentences(resetSentence: true);
      _updateMediaItem();
      onSectionChanged?.call();
      notifyListeners();
      await _speakCurrentSentence();
      return;
    }

    _playing = false;
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.completed,
      ),
    );
    onChapterCompleted?.call();
    notifyListeners();
  }

  Future<void> seekBySeconds(double seconds) async {
    if (_sections.isEmpty) return;
    final wasPlaying = _playing;
    await _tts.stop();
    final deltaWords =
        wordsForDuration(seconds: seconds.abs(), speed: _speed) *
            (seconds < 0 ? -1 : 1);

    if (_sentences.isEmpty) _reloadSentences(resetSentence: false);

    var target = sentenceIndexAfterWordJump(
      sentences: _sentences,
      fromIndex: _sentenceIndex,
      wordDelta: deltaWords,
    );

    if (seconds < 0 && target == 0 && _sentenceIndex == 0 && _sectionIndex > 0) {
      _sectionIndex--;
      _reloadSentences(resetSentence: false);
      _sentenceIndex = (_sentences.length - 1).clamp(0, 9999);
      target = sentenceIndexAfterWordJump(
        sentences: _sentences,
        fromIndex: _sentenceIndex,
        wordDelta: deltaWords,
      );
      onSectionChanged?.call();
    } else if (seconds > 0 &&
        target >= _sentences.length - 1 &&
        _sentenceIndex >= _sentences.length - 1 &&
        _sectionIndex < _sections.length - 1) {
      _sectionIndex++;
      _reloadSentences(resetSentence: true);
      target = sentenceIndexAfterWordJump(
        sentences: _sentences,
        fromIndex: 0,
        wordDelta: deltaWords,
      );
      onSectionChanged?.call();
    }

    _sentenceIndex = target;
    _currentSentence = _sentences.isEmpty ? '' : _sentences[_sentenceIndex];
    _currentWord = '';
    _updateMediaItem();
    notifyListeners();
    if (wasPlaying) {
      _playing = true;
      await _speakCurrentSentence();
    }
  }

  @override
  Future<void> rewind() => seekBySeconds(-5);

  @override
  Future<void> fastForward() => seekBySeconds(5);

  @override
  Future<void> play() async {
    if (_sections.isEmpty) return;
    await _init();
    _playing = true;
    notifyListeners();
    await _speakCurrentSentence();
  }

  @override
  Future<void> pause() async {
    _playing = false;
    await _tts.stop();
    _emitReady(playing: false);
    notifyListeners();
  }

  @override
  Future<void> stop() async {
    _playing = false;
    await _tts.stop();
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.idle,
      ),
    );
    notifyListeners();
  }

  @override
  Future<void> skipToNext() async {
    if (_sectionIndex >= _sections.length - 1) return;
    final wasPlaying = _playing;
    await _tts.stop();
    _sectionIndex++;
    _reloadSentences(resetSentence: true);
    _updateMediaItem();
    onSectionChanged?.call();
    notifyListeners();
    if (wasPlaying) {
      _playing = true;
      await _speakCurrentSentence();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_sectionIndex <= 0) return;
    final wasPlaying = _playing;
    await _tts.stop();
    _sectionIndex--;
    _reloadSentences(resetSentence: true);
    _updateMediaItem();
    onSectionChanged?.call();
    notifyListeners();
    if (wasPlaying) {
      _playing = true;
      await _speakCurrentSentence();
    }
  }

  Future<void> jumpToSection(int index) async {
    if (_sections.isEmpty) return;
    final wasPlaying = _playing;
    await _tts.stop();
    _sectionIndex = index.clamp(0, _sections.length - 1);
    _reloadSentences(resetSentence: true);
    _updateMediaItem();
    onSectionChanged?.call();
    notifyListeners();
    if (wasPlaying) {
      _playing = true;
      await _speakCurrentSentence();
    }
  }

  Future<void> toggle() async {
    if (_playing) {
      await pause();
    } else {
      await play();
    }
  }
}
