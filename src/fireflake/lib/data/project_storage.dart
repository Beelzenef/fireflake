import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/project.dart';

class ProjectLoadIssue {
  final String filename;
  final String message;

  const ProjectLoadIssue({required this.filename, required this.message});
}

class ProjectLoadResult {
  final List<Project> projects;
  final List<ProjectLoadIssue> issues;

  const ProjectLoadResult({required this.projects, required this.issues});
}

class ProjectStorage {
  static const String _folderName = 'projects';
  static final RegExp _validId = RegExp(r'^[a-fA-F0-9_-]+$');

  static Future<Directory> _baseDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final target = Directory(p.join(dir.path, 'fireflake', _folderName));
    if (!await target.exists()) {
      await target.create(recursive: true);
    }
    return target;
  }

  static String _fileNameForId(String id) {
    if (!_validId.hasMatch(id)) {
      throw FormatException('Invalid project ID.');
    }
    return 'project-$id.json';
  }

  static Future<void> _recoverInterruptedWrites(Directory dir) async {
    await for (final entity in dir.list()) {
      if (entity is! File || !entity.path.endsWith('.json.bak')) continue;
      final target = File(entity.path.substring(0, entity.path.length - 4));
      if (!await target.exists()) {
        await entity.rename(target.path);
      } else {
        await entity.delete();
      }
    }

    await for (final entity in dir.list()) {
      if (entity is File && entity.path.endsWith('.json.tmp')) {
        await entity.delete();
      }
    }
  }

  static Future<ProjectLoadResult> loadProjects() async {
    final dir = await _baseDir();
    await _recoverInterruptedWrites(dir);
    final files = dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));
    final projects = <Project>[];
    final issues = <ProjectLoadIssue>[];
    final seenIds = <String>{};

    for (final file in files) {
      try {
        final jsonStr = await file.readAsString();
        final decoded = json.decode(jsonStr);
        if (decoded is! Map<String, dynamic>) {
          throw const FormatException('Project data must be a JSON object.');
        }
        final project = Project.fromJson(decoded);
        if (!_validId.hasMatch(project.id)) {
          throw const FormatException('Project has an invalid ID.');
        }
        if (!seenIds.add(project.id)) {
          throw FormatException('Duplicate project ID "${project.id}".');
        }

        final expectedFilename = _fileNameForId(project.id);
        final needsMigration = decoded['formatVersion'] !=
                Project.currentFormatVersion ||
            decoded['id'] == null ||
            p.basename(file.path) != expectedFilename;
        if (needsMigration) {
          try {
            await _writeProject(project, expectedFilename);
            if (p.basename(file.path) != expectedFilename) {
              await file.delete();
            }
          } catch (error) {
            issues.add(ProjectLoadIssue(
              filename: p.basename(file.path),
              message: 'Migration could not be saved: $error',
            ));
          }
        }
        projects.add(project);
      } catch (error) {
        issues.add(ProjectLoadIssue(
          filename: p.basename(file.path),
          message: error.toString(),
        ));
      }
    }

    return ProjectLoadResult(projects: projects, issues: issues);
  }

  static Future<Project?> loadProjectById(String id) async {
    final dir = await _baseDir();
    final file = File(p.join(dir.path, _fileNameForId(id)));
    if (!await file.exists()) return null;
    final jsonStr = await file.readAsString();
    final decoded = json.decode(jsonStr);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Project data must be a JSON object.');
    }
    final project = Project.fromJson(decoded);
    if (project.id != id) {
      throw const FormatException('Project ID does not match its filename.');
    }
    return project;
  }

  static Future<void> saveProject(Project project) async {
    final targetFilename = _fileNameForId(project.id);
    await _writeProject(project, targetFilename);
    final dir = await _baseDir();
    await for (final entity in dir.list()) {
      if (entity is! File ||
          !entity.path.endsWith('.json') ||
          p.basename(entity.path) == targetFilename) {
        continue;
      }
      try {
        final decoded = json.decode(await entity.readAsString());
        if (decoded is Map<String, dynamic> && decoded['id'] == project.id) {
          await entity.delete();
        }
      } on FormatException {
        continue;
      }
    }
  }

  static Future<void> _writeProject(Project project, String filename) async {
    final dir = await _baseDir();
    await _recoverInterruptedWrites(dir);
    final file = File(p.join(dir.path, filename));
    final temp = File('${file.path}.tmp');
    final backup = File('${file.path}.bak');

    if (await file.exists()) {
      try {
        final existing = json.decode(await file.readAsString());
        if (existing is! Map<String, dynamic> ||
            existing['id'] != project.id) {
          throw const FileSystemException(
              'Refusing to overwrite a different project file.');
        }
      } on FormatException {
        rethrow;
      } on FileSystemException {
        rethrow;
      } catch (error) {
        throw FileSystemException(
            'Could not verify the existing project file: $error', file.path);
      }
    }

    await temp.writeAsString(json.encode(project.toJson()), flush: true);
    var movedOriginal = false;
    try {
      if (await backup.exists()) {
        await backup.delete();
      }
      if (await file.exists()) {
        await file.rename(backup.path);
        movedOriginal = true;
      }
      await temp.rename(file.path);
      if (movedOriginal && await backup.exists()) {
        await backup.delete();
      }
    } catch (error) {
      if (movedOriginal && !await file.exists() && await backup.exists()) {
        await backup.rename(file.path);
      }
      if (await temp.exists()) {
        await temp.delete();
      }
      rethrow;
    }
  }

  static Future<void> deleteProject(String id) async {
    final dir = await _baseDir();
    final file = File(p.join(dir.path, _fileNameForId(id)));
    if (await file.exists()) {
      await file.delete();
    }
  }
}
