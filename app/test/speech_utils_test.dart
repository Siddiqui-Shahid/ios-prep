import 'package:flutter_test/flutter_test.dart';
import 'package:ios_prep_audiobook/services/speech_utils.dart';

void main() {
  test('pronounces UI as letters', () {
    expect(sanitizeForSpeech('The UI layer'), contains('U I'));
  });

  test('pronounces COW as copy on write', () {
    expect(sanitizeForSpeech('Array uses COW'), contains('copy on write'));
  });

  test('expands PAT instead of letter spelling', () {
    final spoken = sanitizeForSpeech('Avoid unexplained PAT jargon');
    expect(spoken, contains('protocol with associated type'));
    expect(spoken.contains('P A T'), isFalse);
  });

  test('splits sentences', () {
    final parts = splitSentences('Hello world. Next idea. Third one!');
    expect(parts.length, 3);
  });

  test('seek word jump moves forward', () {
    final sentences = ['One two three.', 'Four five.', 'Six.'];
    final i = sentenceIndexAfterWordJump(
      sentences: sentences,
      fromIndex: 0,
      wordDelta: 4,
    );
    expect(i, greaterThan(0));
  });
}
