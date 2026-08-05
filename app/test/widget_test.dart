import 'package:flutter_test/flutter_test.dart';

import 'package:ios_prep_audiobook/data/content_catalog.dart';

void main() {
  test('parses script sections from § headings', () {
    const raw = '''
# Audio script — Demo
> Listen while reading

## §0 Intro
Hello world.

## §1 Next
More teaching.
''';
    final sections = ContentCatalog.parseScriptSections(raw);
    expect(sections.length, 2);
    expect(sections[0].id, '§0');
    expect(sections[0].title, 'Intro');
    expect(sections[0].body, contains('Hello world'));
    expect(sections[1].id, '§1');
  });
}
