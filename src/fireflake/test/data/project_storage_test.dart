import 'dart:convert';
import 'dart:io';

import 'package:fireflake/data/project_storage.dart';
import 'package:fireflake/models/project.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  late Directory documents;
  late Directory projectDirectory;

  setUp(() async {
    documents = await Directory.systemTemp.createTemp('fireflake-storage-');
    projectDirectory =
        Directory('${documents.path}${Platform.pathSeparator}fireflake'
            '${Platform.pathSeparator}projects');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return documents.path;
      }
      throw MissingPluginException('Unexpected path request: ${call.method}');
    });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    await documents.delete(recursive: true);
  });

  test('round-trips distinct projects with colliding title-derived names',
      () async {
    final first = Project(title: 'A/B', expectedWordCount: 50000);
    final second = Project(title: 'A:B', expectedWordCount: 60000);

    await ProjectStorage.saveProject(first);
    await ProjectStorage.saveProject(second);
    final result = await ProjectStorage.loadProjects();

    expect(result.issues, isEmpty);
    expect(result.projects.map((project) => project.id).toSet(),
        {first.id, second.id});
    expect(await projectDirectory.list().length, 2);
  });

  test('migrates a legacy title-named file and preserves its content',
      () async {
    await projectDirectory.create(recursive: true);
    final legacyFile = File(
        '${projectDirectory.path}${Platform.pathSeparator}legacy-novel.json');
    await legacyFile.writeAsString(json.encode({
      'title': 'Legacy Novel',
      'expectedWordCount': 75000,
      'summary': 'A summary to preserve',
    }));

    final result = await ProjectStorage.loadProjects();

    expect(result.issues, isEmpty);
    expect(result.projects, hasLength(1));
    expect(result.projects.single.summary, 'A summary to preserve');
    expect(result.projects.single.id, isNotEmpty);
    expect(await legacyFile.exists(), isFalse);
    final migratedFile = File(
        '${projectDirectory.path}${Platform.pathSeparator}'
        'project-${result.projects.single.id}.json');
    final migratedJson =
        json.decode(await migratedFile.readAsString()) as Map<String, dynamic>;
    expect(migratedJson['formatVersion'], Project.currentFormatVersion);
    expect(migratedJson['id'], result.projects.single.id);
  });

  test('loads valid files and reports malformed files without deleting them',
      () async {
    final validProject = Project(title: 'Valid', expectedWordCount: 50000);
    await ProjectStorage.saveProject(validProject);
    await projectDirectory.create(recursive: true);
    final malformedFile = File(
        '${projectDirectory.path}${Platform.pathSeparator}malformed.json');
    await malformedFile.writeAsString('{invalid json');

    final result = await ProjectStorage.loadProjects();

    expect(result.projects.map((project) => project.id), [validProject.id]);
    expect(result.issues, hasLength(1));
    expect(result.issues.single.filename, 'malformed.json');
    expect(await malformedFile.readAsString(), '{invalid json');
  });

  test('refuses to overwrite an unreadable project file', () async {
    final project = Project(title: 'Protected', expectedWordCount: 50000);
    await projectDirectory.create(recursive: true);
    final file = File(
        '${projectDirectory.path}${Platform.pathSeparator}'
        'project-${project.id}.json');
    await file.writeAsString('{broken');

    await expectLater(
      ProjectStorage.saveProject(project),
      throwsA(isA<FormatException>()),
    );
    expect(await file.readAsString(), '{broken');
  });
}
