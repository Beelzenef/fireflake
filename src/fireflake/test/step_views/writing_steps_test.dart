import 'dart:io';

import 'package:fireflake/models/character.dart';
import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:fireflake/models/scene.dart';
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
  Future<void> saveCurrentProjectToDisk() async {
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
    const StepEightPage(): ['Scene plan'],
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
    await tester.tap(find.byTooltip('Edit scene'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      ['Scene title', 'Chapter one', project.scenes.single.summary],
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
