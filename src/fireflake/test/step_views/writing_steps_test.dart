import 'dart:io';

import 'package:fireflake/models/character.dart';
import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:fireflake/models/scene.dart';
import 'package:fireflake/projectwrapper.dart';
import 'package:fireflake/state/app_cubit.dart';
import 'package:fireflake/widgets/save_project_button.dart';
import 'package:fireflake/step_views/step1.dart';
import 'package:fireflake/step_views/step2.dart';
import 'package:fireflake/step_views/step3.dart';
import 'package:fireflake/step_views/step4.dart';
import 'package:fireflake/step_views/step5.dart';
import 'package:fireflake/step_views/step6.dart';
import 'package:fireflake/step_views/step7.dart';
import 'package:fireflake/step_views/step8.dart';
import 'package:fireflake/step_views/step9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Project savedProject() => Project.fromJson(Project(
      title: 'Novel',
      expectedWordCount: 50000,
      summary: 'Summary',
      act1: 'Act one',
      act2: 'Act two',
      act3: 'Act three',
      finale: 'Finale',
      expandedAct1: 'Expanded one',
      expandedAct2: 'Expanded two',
      expandedAct3: 'Expanded three',
      expandedFinale: 'Expanded finale',
      extendedArgument: 'Extended argument',
      pendingScenes: ['Scene plan'],
      characters: [Character(name: 'Hero', storygoal: 'Description')],
      scenes: [
        Scene(
          id: 'Scene title',
          chapter: 'Chapter one',
          summary:
              'Scene narrative with more than fifty characters for editing.',
        ),
      ],
      protagonist: const Protagonist(
        storyElements: ['Backstory'],
        motivations: 'Motivation',
        goal: 'Goal',
        conflict: 'Conflict',
        epiphany: 'Epiphany',
        finalStoryElements: ['Ending'],
      ),
    ).toJson());

class FailingSaveCubit extends AppCubit {
  @override
  Future<void> saveCurrentProjectToDisk({String? dirtySection}) async {
    throw const FileSystemException('Disk write failed');
  }
}

void main() {
  final formSteps = <Widget, List<String>>{
    const StepOnePage(): ['Summary'],
    const StepTwoPage(): [
      'Summary',
      'Act one',
      'Act two',
      'Act three',
      'Finale'
    ],
    const StepThreePage(): [
      'Backstory',
      'Motivation',
      'Goal',
      'Conflict',
      'Epiphany',
      'Ending',
    ],
    const StepFourPage(): [
      'Expanded one',
      'Expanded two',
      'Expanded three',
      'Expanded finale',
    ],
    const StepFivePage(): ['Hero', 'Description'],
    const StepSixPage(): ['Extended argument'],
    const StepEightPage(): ['Scene plan', 'Scene title'],
  };

  for (final entry in formSteps.entries) {
    testWidgets('${entry.key.runtimeType} restores all saved fields',
        (tester) async {
      final project = savedProject();
      final cubit = AppCubit()..loadInitial([project]);
      cubit.selectProject(project);
      addTearDown(cubit.close);
      await tester.pumpWidget(BlocProvider.value(
        value: cubit,
        child: MaterialApp(home: entry.key),
      ));

      expect(
        tester
            .widgetList<TextFormField>(find.byType(TextFormField))
            .map((field) => field.controller!.text),
        entry.value,
      );
    });
  }

  testWidgets('Step 7 shows protagonist and cast from the saved project',
      (tester) async {
    final project = savedProject();
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: StepSevenPage()),
    ));
    for (final text in [
      'Backstory',
      'Motivation',
      'Goal',
      'Conflict',
      'Epiphany',
      'Ending',
      'Hero',
      'Description',
    ]) {
      expect(find.text(text), findsWidgets);
    }
  });

  testWidgets('Step 9 shows saved scenes and restores the scene editor',
      (tester) async {
    final project = savedProject();
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: StepNinePage()),
    ));
    expect(find.text('Scene title'), findsOneWidget);
    await tester.tap(find.byTooltip('Edit scene').last);
    await tester.pumpAndSettle();
    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      ['Scene title', 'Chapter one', project.scenes.single.summary],
    );
  });

  testWidgets('Step 9 creates entries for scenes planned in Step 8',
      (tester) async {
    final project = Project(
      title: 'Novel',
      expectedWordCount: 50000,
      pendingScenes: ['Planned opening'],
    );
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: StepNinePage()),
    ));

    expect(find.text('Planned opening'), findsOneWidget);
    expect(cubit.state.scenes.single.chapter, 'Chapter 1');
    await tester.tap(find.byTooltip('Edit scene'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      ['Planned opening', 'Chapter 1', ''],
    );
  });

  testWidgets('Step 8 refreshes when scenes change in Step 9', (tester) async {
    final project = Project(
      title: 'Novel',
      expectedWordCount: 50000,
      pendingScenes: ['Planned opening'],
    );
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: StepEightPage()),
    ));

    cubit.addScene(Scene(
      id: 'Added in Step 9',
      chapter: 'Chapter 2',
      summary: 'A new scene entered from the detailed scene list.',
    ));
    await tester.pump();

    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      ['Planned opening', 'Added in Step 9'],
    );
  });

  testWidgets('a failed Step 2 write reports failure instead of success',
      (tester) async {
    final project = savedProject();
    final cubit = FailingSaveCubit()..loadInitial([project]);
    cubit.selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider<AppCubit>.value(
      value: cubit,
      child: const MaterialApp(home: StepTwoPage()),
    ));
    await tester
        .widget<SaveProjectButton>(find.byType(SaveProjectButton))
        .onPressed();
    await tester.pump();
    expect(find.text('Expanded summary saved'), findsNothing);
    expect(
      find.textContaining('Could not save project:'),
      findsOneWidget,
    );
  });

  testWidgets('prompts before leaving a project with unsaved edits',
      (tester) async {
    final project = savedProject();
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ProjectWrapper(),
                ),
              ),
              child: const Text('Open project'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('Open project'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectWrapper), findsOneWidget);
    expect(
      BlocProvider.of<AppCubit>(tester.element(find.byType(ProjectWrapper))),
      same(cubit),
    );
    cubit.markProjectDirty('step1');
    await tester.pumpAndSettle();
    expect(cubit.state.dirtySections, {'step1'});
    expect(cubit.state.saveStatus, ProjectSaveStatus.unsaved);
    expect(
      tester.widgetList<Text>(find.byType(Text)).map((widget) => widget.data),
      contains('Unsaved changes'),
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectWrapper), findsOneWidget);
    expect(find.text('Unsaved changes'), findsNWidgets(2));

    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectWrapper), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard and leave'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectWrapper), findsNothing);
    expect(find.text('Open project'), findsOneWidget);
  });

  testWidgets('Step 4 restores paragraphs even if earlier acts are empty',
      (tester) async {
    final project = savedProject().copyWith(
      act1: '',
      act2: '',
      act3: '',
      finale: '',
    );
    final cubit = AppCubit()..selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(BlocProvider.value(
      value: cubit,
      child: const MaterialApp(home: StepFourPage()),
    ));
    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      ['Expanded one', 'Expanded two', 'Expanded three', 'Expanded finale'],
    );
  });
}
