import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/project_storage.dart';
import '../models/project.dart';
import '../models/scene.dart';
import '../models/character.dart';

class AppState extends Equatable {
  final List<Project> projects;
  final Project? selectedProject;
  final List<Scene> scenes;
  final List<Character> characters;
  final String? currentProjectFilename;

  const AppState({
    this.projects = const [],
    this.selectedProject,
    this.scenes = const [],
    this.characters = const [],
    this.currentProjectFilename,
  });

  AppState copyWith({
    List<Project>? projects,
    Project? selectedProject,
    List<Scene>? scenes,
    List<Character>? characters,
    String? currentProjectFilename,
  }) =>
      AppState(
        projects: projects ?? this.projects,
        selectedProject: selectedProject ?? this.selectedProject,
        scenes: scenes ?? this.scenes,
        characters: characters ?? this.characters,
        currentProjectFilename: currentProjectFilename ?? this.currentProjectFilename,
      );

  @override
  List<Object?> get props => [projects, selectedProject, scenes, characters, currentProjectFilename];
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  Future<void> loadProjectsFromDisk() async {
    final projects = await ProjectStorage.loadProjects();
    emit(state.copyWith(projects: projects));
  }

  void loadInitial(List<Project> projects) {
    emit(state.copyWith(projects: projects));
  }

  void selectProject(Project project) {
    final filename = _generateFilename(project.title);
    emit(state.copyWith(
      selectedProject: project,
      scenes: project.scenes,
      characters: project.characters,
      currentProjectFilename: filename,
    ));
  }

  String _generateFilename(String title) {
    final slug = title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'-+'), '-').trim();
    final safe = slug.isEmpty ? 'project' : slug;
    return '$safe.json';
  }

  Future<void> loadAndSelectProject(String title) async {
    final project = await ProjectStorage.loadProjectByTitle(title);
    if (project != null) {
      selectProject(project);
    }
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
    final updated = List<Project>.from(state.projects);
    final idx = updated.indexWhere((p) => p.title == title);
    Project base = idx >= 0
        ? updated[idx]
        : Project(
            title: title,
            subtitle: subtitle,
            expectedWordCount: expectedWordCount,
          );

    final project = base.copyWith(
      title: title,
      subtitle: subtitle,
      expectedWordCount: expectedWordCount,
      summary: summary,
      act1: act1,
      act2: act2,
      act3: act3,
      finale: finale,
      scenes: scenes ?? state.scenes,
      characters: characters ?? state.characters,
    );

    if (idx >= 0) {
      updated[idx] = project;
    } else {
      updated.add(project);
    }
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
        .map((p) => p.title == selected.title ? updatedProject : p)
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
        .map((p) => p.title == selected.title ? updatedProject : p)
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
        .map((p) => p.title == selected.title ? updatedProject : p)
        .toList();
    emit(state.copyWith(
        projects: updatedProjects, selectedProject: updatedProject));
  }

  void updatePendingScenes(List<String> pendingScenes) {
    final selected = state.selectedProject;
    if (selected == null) return;
    final updatedProject = selected.copyWith(pendingScenes: pendingScenes);
    final updatedProjects = state.projects
        .map((p) => p.title == selected.title ? updatedProject : p)
        .toList();
    emit(state.copyWith(
        projects: updatedProjects, selectedProject: updatedProject));
  }

  void addScene(Scene scene) {
    final updated = List<Scene>.from(state.scenes)..add(scene);
    emit(state.copyWith(scenes: updated));
  }

  void updateScene(int index, Scene scene) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length) {
      updated[index] = scene;
      emit(state.copyWith(scenes: updated));
    }
  }

  void removeSceneAt(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length) {
      updated.removeAt(index);
      emit(state.copyWith(scenes: updated));
    }
  }

  void moveSceneUp(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index > 0 && index < updated.length) {
      final scene = updated.removeAt(index);
      updated.insert(index - 1, scene);
      emit(state.copyWith(scenes: updated));
    }
  }

  void moveSceneDown(int index) {
    final updated = List<Scene>.from(state.scenes);
    if (index >= 0 && index < updated.length - 1) {
      final scene = updated.removeAt(index);
      updated.insert(index + 1, scene);
      emit(state.copyWith(scenes: updated));
    }
  }

  void addCharacter(Character character) {
    final updated = List<Character>.from(state.characters)..add(character);
    emit(state.copyWith(characters: updated));
  }

  void setCharacters(List<Character> characters) {
    emit(state.copyWith(characters: List<Character>.from(characters)));
  }

  void removeCharacter(Character character) {
    final updated = List<Character>.from(state.characters)..remove(character);
    emit(state.copyWith(characters: updated));
  }

  Future<void> saveCurrentProjectToDisk() async {
    final project = state.selectedProject;
    if (project == null) return;
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
    await ProjectStorage.saveProject(merged, state.currentProjectFilename);
    final projects = state.projects
        .map((p) => p.title == merged.title ? merged : p)
        .toList();
    emit(state.copyWith(projects: projects, selectedProject: merged));
  }

  Future<void> deleteProject(String title) async {
    await ProjectStorage.deleteProject(title);
    final updated = state.projects.where((p) => p.title != title).toList();
    emit(state.copyWith(projects: updated));
  }
}
