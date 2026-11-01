import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project protagonist serialization', () {
    test('round-trips the complete protagonist worksheet', () {
      final project = Project(
        title: 'Test Project',
        expectedWordCount: 50000,
        protagonist: const Protagonist(
          storyElements: ['A story element'],
          motivations: 'Protect their family',
          goal: 'Find the lost city',
          conflict: 'The journey is dangerous',
          epiphany: 'They must trust their friends',
          finalStoryElements: ['A final story element'],
        ),
      );

      final restored = Project.fromJson(project.toJson());

      expect(restored.protagonist.storyElements, ['A story element']);
      expect(restored.protagonist.motivations, 'Protect their family');
      expect(restored.protagonist.goal, 'Find the lost city');
      expect(restored.protagonist.conflict, 'The journey is dangerous');
      expect(restored.protagonist.epiphany, 'They must trust their friends');
      expect(
          restored.protagonist.finalStoryElements, ['A final story element']);
    });

    test('loads older project files without a protagonist worksheet', () {
      final project = Project.fromJson({
        'title': 'Legacy Project',
        'expectedWordCount': 50000,
      });

      expect(project.protagonist.storyElements, isEmpty);
      expect(project.protagonist.motivations, isEmpty);
      expect(project.protagonist.goal, isEmpty);
      expect(project.protagonist.conflict, isEmpty);
      expect(project.protagonist.epiphany, isEmpty);
      expect(project.protagonist.finalStoryElements, isEmpty);
    });
  });
}
