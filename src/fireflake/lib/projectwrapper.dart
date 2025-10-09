
import 'package:flutter/material.dart';
import 'info_views/projectinfo.dart';
import 'step_views/step1.dart';
import 'step_views/step2.dart';
import 'step_views/step3.dart';
import 'step_views/step4.dart';
import 'step_views/step5.dart';
import 'step_views/step9.dart';

class ProjectWrapper extends StatefulWidget {
  const ProjectWrapper({super.key});

  @override
  State<ProjectWrapper> createState() => _ProjectWrapperState();
}

class _ProjectWrapperState extends State<ProjectWrapper> {
  @override
  Widget build(BuildContext context) {

    const steps = [
            ProjectInfoPage(),
            StepOnePage(),
            StepTwoPage(),
            StepThreePage(),
            StepFourPage(),
            StepFivePage(),
            StepNinePage()
          ];

    return DefaultTabController(
      length: steps.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Project'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Project Info'),
              Tab(text: 'Step 1'),
              Tab(text: 'Step 2'),
              Tab(text: 'Step 3'),
              Tab(text: 'Step 4'),
              Tab(text: 'Step 5'),
              Tab(text: 'Step 9'),
            ],
          ),
        ),
        body: const TabBarView(
          children: steps,
        ),
      ),
    );
  }
}