import 'dart:io';

import 'package:fireflake/models/character.dart';
import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:fireflake/models/scene.dart';
import 'package:fireflake/state/app_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  late Directory documents;
  late AppCubit cubit;

  setUp(() async {
    documents = await Directory.systemTemp.createTemp('fireflake-persistence-');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return documents.path;
      }
      throw MissingPluginException('Unexpected path request: ${call.method}');
    });
    final project = Project(title: 'Novel', expectedWordCount: 50000);
    cubit = AppCubit()..loadInitial([project]);
    cubit.selectProject(project);
  });

  tearDown(() async {
    await cubit.close();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    await documents.delete(recursive: true);
  });

  test('overlapping saves preserve all steps in memory and on disk', () async {
    cubit.updateProjectSummary(
      summary: 'One sentence',
      act1: 'Act one',
      act2: 'Act two',
      act3: 'Act three',
      finale: 'Finale',
    );
    final firstSave = cubit.saveCurrentProjectToDisk();
    cubit.updateProtagonist(const Protagonist(
      storyElements: ['First', 'Second'],
      motivations: 'Motivation',
      goal: 'Goal',
      conflict: 'Conflict',
      epiphany: 'Epiphany',
      finalStoryElements: ['Ending'],
    ));
    final secondSave = cubit.saveCurrentProjectToDisk();
    cubit.updateExpandedParagraphs(
      expandedAct1: 'Expanded one',
      expandedAct2: 'Expanded two',
      expandedAct3: 'Expanded three',
      expandedFinale: 'Expanded finale',
    );
    cubit.setCharacters([Character(name: 'Hero', storygoal: 'Description')]);
    cubit.updateExtendedArgument('Extended argument');
    cubit.updatePendingScenes(['Scene']);
    cubit.updateScene(
      0,
      Scene(id: 'Scene', chapter: 'Chapter', summary: 'Narrative summary'),
    );
    final expected = cubit.state.selectedProject!
        .copyWith(
          characters: cubit.state.characters,
          scenes: cubit.state.scenes,
        )
        .toJson();
    final thirdSave = cubit.saveCurrentProjectToDisk();
    await firstSave;
    expect(cubit.state.selectedProject!.toJson(), expected);
    await Future.wait([firstSave, secondSave, thirdSave]);

    expect(cubit.state.selectedProject!.toJson(), expected);
    final reopened = AppCubit();
    addTearDown(reopened.close);
    await reopened.loadProjectsFromDisk();
    await reopened.loadAndSelectProject('Novel');
    expect(reopened.state.selectedProject!.toJson(), expected);
    expect(reopened.state.characters.single.name, 'Hero');
    expect(reopened.state.scenes.single.summary, 'Narrative summary');

    reopened.moveSceneUp(0);
    reopened.removeSceneAt(0);
    await reopened.saveCurrentProjectToDisk();
    await reopened.loadAndSelectProject('Novel');
    expect(reopened.state.scenes, isEmpty);
    expect(reopened.state.selectedProject!.pendingScenes, isEmpty);
    expect(reopened.state.selectedProject!.act1, 'Act one');
  });

  test('Step 8 plans carry through Step 9 edits and reopening', () async {
    final project = Project(
      title: 'Novel',
      expectedWordCount: 50000,
      pendingScenes: ['Planned opening'],
      scenes: [
        Scene(
          id: 'Planned opening',
          chapter: 'Chapter 4',
          summary: 'An existing scene summary that should survive a rename.',
        ),
      ],
    );
    await cubit.close();
    cubit = AppCubit()..loadInitial([project]);
    cubit.selectProject(project);
    cubit.updatePendingScenes(['Updated opening']);
    expect(cubit.state.scenes.single.id, 'Updated opening');
    expect(cubit.state.scenes.single.chapter, 'Chapter 4');
    expect(cubit.state.scenes.single.summary,
        'An existing scene summary that should survive a rename.');
    await cubit.saveCurrentProjectToDisk();

    const updatedSummary =
        'The revised narrative summary is long enough to satisfy editing validation.';
    cubit.updateScene(
      0,
      Scene(
        id: 'Updated opening',
        chapter: 'Chapter 4',
        summary: updatedSummary,
      ),
    );
    await cubit.saveCurrentProjectToDisk();

    final reopened = AppCubit();
    addTearDown(reopened.close);
    await reopened.loadProjectsFromDisk();
    await reopened.loadAndSelectProject('Novel');
    expect(reopened.state.selectedProject!.pendingScenes, ['Updated opening']);
    expect(reopened.state.scenes.single.id, 'Updated opening');
    expect(reopened.state.scenes.single.chapter, 'Chapter 4');
    expect(reopened.state.scenes.single.summary, updatedSummary);
  });

  test('opening a legacy project merges its planned and detailed scenes',
      () async {
    final project = Project(
      title: 'Legacy',
      expectedWordCount: 50000,
      pendingScenes: ['Planned scene'],
      scenes: [
        Scene(
          id: 'Planned scene',
          chapter: 'Chapter 3',
          summary: 'A planned scene with an existing narrative summary.',
        ),
        Scene(
          id: 'Detailed-only scene',
          chapter: 'Chapter 5',
          summary: 'A detailed scene not present in the old plan.',
        ),
      ],
    );
    cubit.loadInitial([project]);
    cubit.selectProject(project);

    expect(
      cubit.state.scenes.map((scene) => scene.id),
      ['Planned scene', 'Detailed-only scene'],
    );
    expect(cubit.state.scenes.map((scene) => scene.summary), [
      'A planned scene with an existing narrative summary.',
      'A detailed scene not present in the old plan.',
    ]);
    expect(cubit.state.selectedProject!.pendingScenes,
        ['Planned scene', 'Detailed-only scene']);

    cubit.addScene(Scene(
      id: 'Added in Step 9',
      chapter: 'Chapter 6',
      summary: 'A new scene entered directly in the detailed scene editor.',
    ));
    expect(cubit.state.selectedProject!.pendingScenes,
        ['Planned scene', 'Detailed-only scene', 'Added in Step 9']);
    cubit.moveSceneDown(0);
    expect(cubit.state.selectedProject!.pendingScenes,
        ['Detailed-only scene', 'Planned scene', 'Added in Step 9']);
    cubit.removeSceneAt(1);
    expect(cubit.state.selectedProject!.pendingScenes,
        ['Detailed-only scene', 'Added in Step 9']);
    await cubit.saveCurrentProjectToDisk();
    await cubit.loadAndSelectProject('Legacy');
    expect(cubit.state.scenes.map((scene) => scene.id),
        ['Detailed-only scene', 'Added in Step 9']);
    expect(cubit.state.selectedProject!.pendingScenes,
        ['Detailed-only scene', 'Added in Step 9']);
  });

  test('editing and renaming project information preserves writing', () async {
    cubit.updateProjectSummary(
        summary: 'Summary', act1: 'Act', finale: 'Ending');
    cubit.updateProtagonist(const Protagonist(goal: 'Goal'));
    await cubit.saveCurrentProjectToDisk();
    cubit.updateProjectInfo(
      title: 'Renamed novel',
      subtitle: 'Subtitle',
      expectedWordCount: 60000,
    );
    await cubit.saveCurrentProjectToDisk();
    final reopened = AppCubit();
    addTearDown(reopened.close);
    await reopened.loadProjectsFromDisk();
    expect(reopened.state.projects, hasLength(1));
    await reopened.loadAndSelectProject('Renamed novel');
    expect(reopened.state.selectedProject!.summary, 'Summary');
    expect(reopened.state.selectedProject!.act1, 'Act');
    expect(reopened.state.selectedProject!.finale, 'Ending');
    expect(reopened.state.selectedProject!.protagonist.goal, 'Goal');
    expect(reopened.state.selectedProject!.expectedWordCount, 60000);
  });

  test('saving without a selected project reports an error', () async {
    final empty = AppCubit();
    addTearDown(empty.close);
    await expectLater(empty.saveCurrentProjectToDisk(), throwsStateError);
  });

  test('deleting waits for pending writes and clears the selected project',
      () async {
    cubit.updateProjectSummary(summary: 'Summary');
    final save = cubit.saveCurrentProjectToDisk();
    await cubit.deleteProject('Novel');
    await save;
    expect(cubit.state.selectedProject, isNull);
    await expectLater(cubit.saveCurrentProjectToDisk(), throwsStateError);
    await cubit.loadProjectsFromDisk();
    expect(cubit.state.projects, isEmpty);
  });
}
