
import 'package:flutter/material.dart';
import 'step_views/step3.dart';
import 'step_views/step4.dart';
import 'step_views/step5.dart';

class ProjectWrapper extends StatefulWidget {
  const ProjectWrapper({super.key});

  @override
  State<ProjectWrapper> createState() => _ProjectWrapperState();
}

class _ProjectWrapperState extends State<ProjectWrapper> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Project'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Step 4'),
              Tab(text: 'Step 3'),
              Tab(text: 'Step 5'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            StepFourPage(),
            StepThreePage(),
            StepFivePage(),
          ],
        ),
      ),
    );
  }
}