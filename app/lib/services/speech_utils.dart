/// Speech helpers: sentence split, pronunciation, sanitization for clear TTS.
library;

final _sentenceSplit = RegExp(r'(?<=[.!?])\s+');

/// Expand uncommon shortforms that are not on the resume.
const expandShortforms = <String, String>{
  'PAT': 'protocol with associated type',
  'PATs': 'protocols with associated types',
  'COW': 'copy on write',
  'DTO': 'data transfer object',
  'DTOs': 'data transfer objects',
  'ARC': 'automatic reference counting',
  'WWDC': 'Apple developer conference',
  'UUID': 'unique id',
  'CPU': 'processor',
  'GPU': 'graphics chip',
  'URI': 'web address',
  'HTTPS': 'secure H T T P',
  'HTTP': 'H T T P',
  'JSON': 'Jason',
  'NSObject': 'N S object',
  'AppKit': 'App kit',
};

/// Resume-safe shortforms: spell letter-by-letter for TTS.
const pronunciationMap = <String, String>{
  'UI': 'U I',
  'AI': 'A I',
  'POP': 'P O P',
  'API': 'A P I',
  'GCD': 'G C D',
  'MVVM': 'M V V M',
  'MVC': 'M V C',
  'SDK': 'S D K',
  'SDUI': 'S D U I',
  'URL': 'U R L',
  'iOS': 'i O S',
  'STAR': 'star',
  'ID': 'I D',
  'RAM': 'ram',
  'Xcode': 'X code',
  'UIKit': 'U I kit',
  'SwiftUI': 'Swift U I',
};

List<String> splitSentences(String text) {
  final cleaned = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (cleaned.isEmpty) return const [];
  final parts = cleaned
      .split(_sentenceSplit)
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
  if (parts.isEmpty) return [cleaned];
  final merged = <String>[];
  for (final part in parts) {
    final words = part.split(' ').where((w) => w.isNotEmpty).length;
    // Only glue tiny abbreviation leftovers (e.g. "I.") onto the previous sentence.
    if (merged.isNotEmpty && words == 1 && part.length <= 3) {
      merged[merged.length - 1] = '${merged.last} $part';
    } else {
      merged.add(part);
    }
  }
  return merged;
}

String applyPronunciation(String text) {
  var out = text;
  final expandKeys = expandShortforms.keys.toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  for (final key in expandKeys) {
    final value = expandShortforms[key]!;
    out = out.replaceAllMapped(
      RegExp('\\b${RegExp.escape(key)}\\b'),
      (_) => value,
    );
  }
  final keys = pronunciationMap.keys.toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  for (final key in keys) {
    final value = pronunciationMap[key]!;
    out = out.replaceAllMapped(
      RegExp('\\b${RegExp.escape(key)}\\b'),
      (_) => value,
    );
  }
  // Remaining ALL-CAPS 2–4 letter tokens: expand as words if unknown, else spell.
  out = out.replaceAllMapped(RegExp(r'\b([A-Z]{2,4})\b'), (m) {
    final token = m.group(1)!;
    if (expandShortforms.containsKey(token)) {
      return expandShortforms[token]!;
    }
    if (pronunciationMap.containsKey(token)) {
      return pronunciationMap[token]!;
    }
    // Prefer not inventing letter-spelled jargon; leave as-is for known words.
    return token.split('').join(' ');
  });
  return out;
}

String sanitizeForSpeech(String body) {
  var text = body
      .replaceAll(
        RegExp(r'```[\s\S]*?```'),
        ' Here is a code example explained in the audio script. ',
      )
      .replaceAllMapped(RegExp(r'`([^`]+)`'), (m) {
        final inner = m.group(1)!;
        if (RegExp(r'^[A-Z]{2,4}$').hasMatch(inner)) {
          return applyPronunciation(inner);
        }
        return inner;
      })
      .replaceAll(RegExp(r'\[([^\]]+)\]\([^)]+\)'), r'$1')
      .replaceAll(RegExp(r'[#>*_|-]{2,}'), ' ')
      .replaceAll('§', 'section ')
      .replaceAll('→', ' leads to ')
      .replaceAll('—', ', ')
      .replaceAll('·', ', ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return applyPronunciation(text);
}

int wordsForDuration({required double seconds, required double speed}) {
  final wps = 2.2 * speed.clamp(0.5, 16.0);
  return (seconds * wps).round().clamp(1, 400);
}

int sentenceIndexAfterWordJump({
  required List<String> sentences,
  required int fromIndex,
  required int wordDelta,
}) {
  if (sentences.isEmpty) return 0;
  var i = fromIndex.clamp(0, sentences.length - 1);
  if (wordDelta == 0) return i;

  if (wordDelta > 0) {
    var remaining = wordDelta;
    while (i < sentences.length - 1 && remaining > 0) {
      final words = sentences[i].split(RegExp(r'\s+')).length;
      if (remaining < words && i > fromIndex) break;
      remaining -= words;
      i++;
    }
    return i.clamp(0, sentences.length - 1);
  }

  var remaining = -wordDelta;
  while (i > 0 && remaining > 0) {
    i--;
    final words = sentences[i].split(RegExp(r'\s+')).length;
    remaining -= words;
  }
  return i.clamp(0, sentences.length - 1);
}
