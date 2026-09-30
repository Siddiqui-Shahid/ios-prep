import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ios_prep_audiobook/data/content_catalog.dart';
import 'package:ios_prep_audiobook/data/progress_store.dart';
import 'package:ios_prep_audiobook/widgets/manual_complete.dart';

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

  test('handbook is the primary spine in the bundled manifest', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final catalog = await ContentCatalog.load();
    expect(catalog.handbook, isNotNull);
    expect(catalog.handbook!.id, 'handbook');
    expect(catalog.spine.length, 49);
    expect(catalog.spine.first.chapter.id, 'how-this-handbook-works');
    final feed = catalog.manifest.findChapter(
      'handbook',
      'part-05-samples',
      '01-social-feed',
    );
    expect(feed, isNotNull);
    expect(
      await catalog.loadMarkdown(feed!.chapter),
      contains('stale-while-revalidate'),
    );
    expect(catalog.guideWeeks, isNotEmpty);
    expect(catalog.guideWeeks.first.id, 'trips-mumbai-pune');
    expect(catalog.topicWeeks, isNotEmpty);
    expect(catalog.topicWeeks.first.id, 'study-topics');
    expect(catalog.weakPointWeeks, isNotEmpty);
    expect(catalog.weakPointWeeks.first.id, 'interview-weak-points');
    expect(catalog.questionWeeks, isNotEmpty);
    expect(catalog.questionWeeks.first.id, 'machine-design-30');
    expect(catalog.systemDesignWeeks, isNotEmpty);
    expect(catalog.systemDesignWeeks.first.id, 'system-design-library');
    expect(
      catalog.systemDesignWeeks.first.days.length,
      greaterThanOrEqualTo(33),
    );
    final imageDesign = catalog.manifest.findChapter(
      'system-design-library',
      'image-loading-library',
      'image-loading-library',
    );
    expect(imageDesign, isNotNull);
    expect(
      await catalog.loadMarkdown(imageDesign!.chapter),
      contains('3-tier caching mechanism'),
    );
    expect(catalog.weeks.length, 4);
    final trip1 = catalog.manifest.findChapter(
      'trips-mumbai-pune',
      'trip-01',
      'trip-01',
    );
    expect(trip1, isNotNull);
    expect(await catalog.loadMarkdown(trip1!.chapter), contains('75 min'));
    final weak = catalog.manifest.findChapter(
      'interview-weak-points',
      '00-overview',
      '00-overview',
    );
    expect(weak, isNotNull);
    expect(
      await catalog.loadMarkdown(weak!.chapter),
      contains('think out loud'),
    );
    final start = catalog.manifest.findChapter(
      'travel-mumbai-pune',
      'start',
      '01-how-this-guide-works',
    );
    expect(start, isNotNull);
    final md = await catalog.loadMarkdown(start!.chapter);
    expect(md, contains('ARC'));
    expect(md, contains('Automatic Reference Counting'));
    expect(md.toLowerCase(), isNot(contains('keyword (plain')));
    final lld = catalog.manifest.findChapter(
      'travel-mumbai-pune',
      'lld',
      '01-lld-framework',
    );
    expect(await catalog.loadMarkdown(lld!.chapter), contains('URLSession'));
    final hld = catalog.manifest.findChapter(
      'travel-mumbai-pune',
      'hld',
      '01-hld-framework',
    );
    expect(await catalog.loadMarkdown(hld!.chapter), contains('DAU'));
    final trip = catalog.manifest.findChapter(
      'travel-mumbai-pune',
      'trip-a',
      '01-mumbai-to-pune',
    );
    final tripMd = await catalog.loadMarkdown(trip!.chapter);
    expect(tripMd, contains('75'));
    expect(tripMd.toLowerCase(), isNot(contains('8-hour train')));
    final q = catalog.manifest.findChapter(
      'machine-design-30',
      'q-01-10',
      '01-questions-01-10',
    );
    expect(q, isNotNull);
    expect(
      await catalog.loadMarkdown(q!.chapter),
      contains('infinite social feed'),
    );
  });

  test(
    'manual complete persists independently of auto chapter progress',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final store = ProgressStore(prefs);
      const id = 'day:trips-mumbai-pune/trip-01';
      expect(store.isManualComplete(id), isFalse);
      await store.toggleManualComplete(id);
      expect(store.isManualComplete(id), isTrue);
      expect(ProgressStore(prefs).isManualComplete(id), isTrue);
    },
  );

  testWidgets('manual complete button toggles label', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressStore(await SharedPreferences.getInstance());
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ManualCompleteButton(
            progress: store,
            id: ProgressStore.dayCompleteId('trips-mumbai-pune', 'trip-01'),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Mark complete'), findsOneWidget);
    await tester.tap(find.text('Mark complete'));
    await tester.pump();
    expect(find.text('Completed'), findsOneWidget);
    expect(
      store.isManualComplete(
        ProgressStore.dayCompleteId('trips-mumbai-pune', 'trip-01'),
      ),
      isTrue,
    );
  });
}
