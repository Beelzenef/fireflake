import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/project.dart';

class ProjectStorage {
  static const String _folderName = 'projects';

  static Future<Directory> _baseDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final target = Directory(p.join(dir.path, 'fireflake', _folderName));
    if (!await target.exists()) {
      await target.create(recursive: true);
    }
    return target;
  }

  static String _fileName(String title) {
    final slug = title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'-+'), '-').trim();
    final safe = slug.isEmpty ? 'project' : slug;
    return '$safe.json';
  }

  static Future<List<Project>> loadProjects() async {
    final dir = await _baseDir();
    final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.json'));
    final projects = <Project>[];
    for (final file in files) {
      try {
        final jsonStr = await file.readAsString();
        final map = json.decode(jsonStr) as Map<String, dynamic>;
        projects.add(Project.fromJson(map));
      } catch (_) {
        // ignore malformed files
      }
    }
    return projects;
  }

  static Future<Project?> loadProjectByTitle(String title) async {
    final dir = await _baseDir();
    final file = File(p.join(dir.path, _fileName(title)));
    if (!await file.exists()) return null;
    final jsonStr = await file.readAsString();
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return Project.fromJson(map);
  }

  static Future<void> saveProject(Project project, [String? filename]) async {
    final dir = await _baseDir();
    final actualFilename = filename ?? _fileName(project.title);
    final file = File(p.join(dir.path, actualFilename));
    final jsonStr = json.encode(project.toJson());
    await file.writeAsString(jsonStr);
  }
}
