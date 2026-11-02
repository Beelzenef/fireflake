import 'dart:convert';
import 'dart:io';

import 'package:fireflake/models/project.dart';
import 'package:fireflake/models/protagonist.dart';
import 'package:fireflake/state/app_cubit.dart';
import 'package:fireflake/step_views/step3.dart';
import 'package:fireflake/widgets/save_project_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('saves and restores every field after reopening from disk',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final documents = (await tester
        .runAsync(() => Directory.systemTemp.createTemp('fireflake-step3-')))!;
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (call) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return documents.path;
      }
      throw MissingPluginException('Unexpected path request: ${call.method}');
    });
    addTearDown(() async {
      tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
      await tester.runAsync(() => documents.delete(recursive: true));
    });

    final project = Project(title: 'atp', expectedWordCount: 50000);
    final cubit = AppCubit()..loadInitial([project]);
    cubit.selectProject(project);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: StepThreePage()),
      ),
    );

    const values = [
      'Backstory element',
      'Motivation',
      'Goal',
      'Conflict',
      'Epiphany',
      'Final backstory element',
    ];
    final fields = find.byType(TextFormField);
    for (var index = 0; index < values.length; index++) {
      await tester.ensureVisible(fields.at(index));
      await tester.enterText(fields.at(index), values[index]);
    }
    await tester.runAsync(() => tester
        .widget<SaveProjectButton>(find.byType(SaveProjectButton))
        .onPressed()
        .timeout(const Duration(seconds: 10)));
    await tester.pump();

    final file = File(
        '${documents.path}${Platform.pathSeparator}fireflake${Platform.pathSeparator}projects${Platform.pathSeparator}atp.json');
    final json = await tester.runAsync(() async =>
        jsonDecode(await file.readAsString()) as Map<String, dynamic>);
    expect((json!['protagonist'] as Map<String, dynamic>)['goal'], 'Goal');

    await tester.pumpWidget(const SizedBox());
    final reopened = AppCubit();
    addTearDown(reopened.close);
    await tester.runAsync(() => reopened.loadAndSelectProject('atp'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: reopened,
        child: const MaterialApp(home: StepThreePage()),
      ),
    );

    expect(
      tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .map((field) => field.controller!.text),
      values,
    );
    expect(reopened.state.characters, isEmpty);
  });

  testWidgets('restores protagonist worksheet fields from the project',
      (tester) async {
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
    final cubit = AppCubit()..loadInitial([project]);
    cubit.selectProject(project);
    addTearDown(cubit.close);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: StepThreePage()),
      ),
    );

    final fieldValues = tester
        .widgetList<TextFormField>(find.byType(TextFormField))
        .map((field) => field.controller?.text);
    expect(
      fieldValues,
      containsAll([
        'A story element',
        'Protect their family',
        'Find the lost city',
        'The journey is dangerous',
        'They must trust their friends',
        'A final story element',
      ]),
    );
  });
}
