import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/project_storage.dart';
import '../models/project.dart';
import '../models/scene.dart';
import '../models/character.dart';
import '../models/protagonist.dart';

class AppState extends Equatable {
  final List<Project> projects;
  final Project? selectedProject;
  final List<Scene> scenes;
  final List<Character> characters;
  final List<ProjectLoadIssue> projectLoadIssues;

  const AppState({
    this.projects = const [],
    this.selectedProject,
    this.scenes = const [],
    this.characters = const [],
    this.projectLoadIssues = const [],
  });

  AppState copyWith({
    List<Project>? projects,
    Project? selectedProject,
    List<Scene>? scenes,
    List<Character>? characters,
    List<ProjectLoadIssue>? projectLoadIssues,
  }) =>
      AppState(
        projects: projects ?? this.projects,
        selectedProject: selectedProject ?? this.selectedProject,
        scenes: scenes ?? this.scenes,
        characters: characters ?? this.characters,
        projectLoadIssues: projectLoadIssues ?? this.projectLoadIssues,
      );

  @override
  List<Object?> get props =>
      [projects, selectedProject, scenes, characters, projectLoadIssues];
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());
  Future<void> _pendingSave = Future<void>.value();

  Future<void> loadProjectsFromDisk() async {
    await _pendingSave;
    final result = await ProjectStorage.loadProjects();
    emit(state.copyWith(
      projects: result.projects,
      projectLoadIssues: result.issues,
    ));
  }

  void loadInitial(List<Project> projects) {
    emit(state.copyWith(projects: projects));
  }

  void selectProject(Project project) {
    final scenes = _mergeLegacyScenes(project.pendingScenes, project.scenes);
    final synchronizedProject = project.copyWith(
      pendingScenes: scenes.map((scene) => scene.id).toList(),
      scenes: scenes,
    );
    final projects = state.projects
        .map((item) => item.id == project.id ? synchronizedProject : item)
        .toList();
    emit(state.copyWith(
      projects: projects,
      selectedProject: synchronizedProject,
      scenes: scenes,
      characters: synchronizedProject.characters,
    ));
  }

  List<Scene> _mergeLegacyScenes(
      List<String> pendingScenes, List<Scene> existingScenes) {
    final unmatchedScenes = List<Scene>.from(existingScenes);
    final mergedScenes = <Scene>[];

    for (var index = 0; index < pendingScenes.length; index++) {
      final name = pendingScenes[index];
      final existingIndex =
          unmatchedScenes.indexWhere((scene) => scene.id == name);
      if (existingIndex >= 0) {
        mergedScenes.add(unmatchedScenes.removeAt(existingIndex));
      } else {
        mergedScenes.add(Scene(
          id: name,
          chapter: 'Chapter ${(index ~/ 2) + 1}',
          summary: '',
        ));
      }
    }

    mergedScenes.addAll(unmatchedScenes);
    return mergedScenes;
  }

  String? projectTitleValidationError(
    String title, {
    String? excludingProjectId,
  }) {
    final normalizedTitle = title.trim().toLowerCase();
    if (normalizedTitle.isEmpty) return 'Title is required.';
    if (state.projects.any((project) =>
        project.id != excludingProjectId &&
        project.title.trim().toLowerCase() == normalizedTitle)) {
      return 'A project with this title already exists.';
    }
    return null;
  }

  Future<void> loadAndSelectProject(String id) async {
    await _pendingSave;
    Project? project;
    for (final candidate in state.projects) {
      if (candidate.id == id) {
        project = candidate;
        break;
      }
    }
    project ??= await ProjectStorage.loadProjectById(id);
    if (project == null) {
      throw StateError('Project "$id" could not be found on disk.');
    }
    selectProject(project);
  }

  void updateProjectInfo({
    required String title,
    required String subtitle,
    required int expectedWordCount,
  }) {
    final selected = state.selectedProject;
    if (selected == null) {
      throw StateError('Select a project before updating its information.');
    }
    final normalizedTitle = title.trim();
    final titleError = projectTitleValidationError(
      normalizedTitle,
      excludingProjectId: selected.id,
    );
    if (titleError != null) {
      throw StateError(titleError);
    }
    if (expectedWordCount <= 0) {
      throw StateError('Expected word count must be greater than zero.');
    }
    final updated = selected.copyWith(
      title: normalizedTitle,
      subtitle: subtitle,
      expectedWordCount: expectedWordCount,
      scenes: state.scenes,
      characters: state.characters,
    );
    emit(state.copyWith(
      selectedProject: updated,
      projects: state.projects
          .map((project) => project.id == selected.id ? updated : project)
          .toList(),
    ));
  }

  void saveProject({
    required String title,
    String subtitle = '',
    required int expectedWordCount,
    String? summary,
    String? act1,
    String? act2,
    String? act3,
    String? finale,
    List<Scene>? scenes,
    List<Character>? characters,
  }) {
    final normalizedTitle = title.trim();
    final titleError = projectTitleValidationError(normalizedTitle);
    if (titleError != null) {
      throw StateError(titleError);
    }
    if (expectedWordCount <= 0) {
      throw StateError('Expected word count must be greater than zero.');
    }
    final updated = List<Project>.from(state.projects);
    final project = Project(
      title: normalizedTitle,
      subtitle: subtitle,
      expectedWordCount: expectedWordCount,
      summary: summary ?? '',
      act1: act1 ?? '',
      act2: act2 ?? '',
      act3: act3 ?? '',
      finale: finale ?? '',
      scenes: scenes ?? const [],
      characters: characters ?? const [],
    );

    updated.add(project);
    emit(state.copyWith(projects: updated, selectedProject: project));
  }

  void updateProjectSummary({
    String? summary,
    String? act1,
    String? act2,
    String? act3,
    String? finale,
    List<Scene>? scenes,
    List<Character>? characters,
  }) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final updatedProject = selected.copyWith(
      summary: summary ?? selected.summary,
      act1: act1 ?? selected.act1,
      act2: act2 ?? selected.act2,
      act3: act3 ?? selected.act3,
      finale: finale ?? selected.finale,
      scenes: scenes ?? state.scenes,
      characters: characters ?? state.characters,
    );
    final updatedProjects = state.projects
        .map((p) => p.id == selected.id ? updatedProject : p)
        .toList();
    emit(state.copyWith(
        projects: updatedProjects, selectedProject: updatedProject));
  }

  void updateExpandedParagraphs({
    String? expandedAct1,
    String? expandedAct2,
    String? expandedAct3,
    String? expandedFinale,
  }) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final updatedProject = selected.copyWith(
      expandedAct1: expandedAct1 ?? selected.expandedAct1,
      expandedAct2: expandedAct2 ?? selected.expandedAct2,
      expandedAct3: expandedAct3 ?? selected.expandedAct3,
      expandedFinale: expandedFinale ?? selected.expandedFinale,
    );
    final updatedProjects = state.projects
        .map((p) => p.id == selected.id ? updatedProject : p)
        .toList();
    emit(state.copyWith(
        projects: updatedProjects, selectedProject: updatedProject));
  }

  void updateExtendedArgument(String extendedArgument) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final updatedProject =
        selected.copyWith(extendedArgument: extendedArgument);
    final updatedProjects = state.projects
        .map((p) => p.id == selected.id ? updatedProject : p)
        .toList();
    emit(state.copyWith(
        projects: updatedProjects, selectedProject: updatedProject));
  }

  void updatePendingScenes(List<String> pendingScenes) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final scenes = _scenesForPendingNames(pendingScenes, state.scenes);
    final updatedProject = selected.copyWith(
      pendingScenes: scenes.map((scene) => scene.id).toList(),
      scenes: scenes,
    );
    final updatedProjects = state.projects
        .map((p) => p.id == selected.id ? updatedProject : p)
        .toList();
    emit(state.copyWith(
      projects: updatedProjects,
      selectedProject: updatedProject,
      scenes: scenes,
    ));
  }

  List<Scene> _scenesForPendingNames(
      List<String> pendingScenes, List<Scene> existingScenes) {
    final unmatchedScenes = List<Scene>.from(existingScenes);
    final scenes = List<Scene?>.filled(pendingScenes.length, null);

    for (var index = 0; index < pendingScenes.length; index++) {
      final existingIndex = unmatchedScenes
          .indexWhere((scene) => scene.id == pendingScenes[index]);
      if (existingIndex >= 0) {
        scenes[index] = unmatchedScenes.removeAt(existingIndex);
      }
    }

    for (var index = 0; index < pendingScenes.length; index++) {
      if (scenes[index] != null) continue;

      final oldScene =
          index < existingScenes.length ? existingScenes[index] : null;
      final oldSceneIndex =
          oldScene == null ? -1 : unmatchedScenes.indexOf(oldScene);
      if (oldSceneIndex >= 0) {
        final scene = unmatchedScenes.removeAt(oldSceneIndex);
        scenes[index] = Scene(
          id: pendingScenes[index],
          chapter: scene.chapter,
          summary: scene.summary,
        );
      } else {
        scenes[index] = Scene(
          id: pendingScenes[index],
          chapter: 'Chapter ${(index ~/ 2) + 1}',
          summary: '',
        );
      }
    }

    return scenes.whereType<Scene>().toList();
  }

  void _setScenes(List<Scene> scenes) {
    final selected = state.selectedProject;
    if (selected == null) {
      emit(state.copyWith(scenes: scenes));
      return;
    }
    final updatedProject = selected.copyWith(
      scenes: scenes,
      pendingScenes: scenes.map((scene) => scene.id).toList(),
    );
    final updatedProjects = state.projects
        .map((project) =>
            project.id == selected.id ? updatedProject : project)
        .toList();
    emit(state.copyWith(
      projects: updatedProjects,
      selectedProject: updatedProject,
      scenes: scenes,
    ));
  }

  void addScene(Scene scene) {
    final updated = List<Scene>.from(state.scenes)..add(scene);
    _setScenes(updated);
  }

  void updateScene(int index, Scene scene) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length) {
      updated[index] = scene;
      _setScenes(updated);
    }
  }

  void removeSceneAt(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length) {
      updated.removeAt(index);
      _setScenes(updated);
    }
  }

  void moveSceneUp(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index > 0 && index < updated.length) {
      final scene = updated.removeAt(index);
      updated.insert(index - 1, scene);
      _setScenes(updated);
    }
  }

  void moveSceneDown(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length - 1) {
      final scene = updated.removeAt(index);
      updated.insert(index + 1, scene);
      _setScenes(updated);
    }
  }

  void addCharacter(Character character) {
    final updated = List<Character>.from(state.characters)..add(character);
    emit(state.copyWith(characters: updated));
  }

  void setCharacters(List<Character> characters) {
    emit(state.copyWith(characters: List<Character>.from(characters)));
  }

  void updateProtagonist(Protagonist protagonist) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final updatedProject = selected.copyWith(protagonist: protagonist);
    final updatedProjects = state.projects
        .map((project) =>
            project.id == selected.id ? updatedProject : project)
        .toList();
    emit(state.copyWith(
      projects: updatedProjects,
      selectedProject: updatedProject,
    ));
  }

  void removeCharacter(Character character) {
    final updated = List<Character>.from(state.characters)..remove(character);
    emit(state.copyWith(characters: updated));
  }

  Future<void> saveCurrentProjectToDisk() async {
    final project = state.selectedProject;
    if (project == null) {
      throw StateError('Select a project before saving.');
    }
    final merged = project.copyWith(
      title: project.title,
      subtitle: project.subtitle,
      expectedWordCount: project.expectedWordCount,
      summary: project.summary,
      act1: project.act1,
      act2: project.act2,
      act3: project.act3,
      finale: project.finale,
      expandedAct1: project.expandedAct1,
      expandedAct2: project.expandedAct2,
      expandedAct3: project.expandedAct3,
      expandedFinale: project.expandedFinale,
      extendedArgument: project.extendedArgument,
      pendingScenes: project.pendingScenes,
      scenes: state.scenes,
      characters: state.characters,
    );
    final projects = state.projects
        .map((p) => p.id == merged.id ? merged : p)
        .toList();
    emit(state.copyWith(
      projects: projects,
      selectedProject: merged,
    ));

    final previousSave = _pendingSave;
    final finished = Completer<void>();
    _pendingSave = finished.future;
    try {
      await previousSave;
      await ProjectStorage.saveProject(merged);
    } finally {
      finished.complete();
    }
  }

  Future<void> deleteProject(String id) async {
    await _pendingSave;
    await ProjectStorage.deleteProject(id);
    final updated = state.projects.where((p) => p.id != id).toList();
    emit(state.selectedProject?.id == id
        ? AppState(projects: updated)
        : state.copyWith(projects: updated));
  }
}
