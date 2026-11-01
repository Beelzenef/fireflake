import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:fireflake/state/app_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppCubit protagonist worksheet', () {
    test('updates the selected project without changing the cast', () async {
      final project = Project(
        title: 'Test Project',
        expectedWordCount: 50000,
      );
      final cubit = AppCubit()..loadInitial([project]);
      cubit.selectProject(project);

      const worksheet = Protagonist(
        storyElements: ['A story element'],
        motivations: 'Protect their family',
        goal: 'Find the lost city',
        conflict: 'The journey is dangerous',
        epiphany: 'They must trust their friends',
        finalStoryElements: ['A final story element'],
      );
      cubit.updateProtagonist(worksheet);

      expect(cubit.state.selectedProject?.protagonist.goal, worksheet.goal);
      expect(cubit.state.projects.single.protagonist.goal, worksheet.goal);
      expect(cubit.state.characters, isEmpty);

      await cubit.close();
    });
  });
}
