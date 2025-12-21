import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'info_views/projectinfo.dart';
import 'step_views/step1.dart';
import 'step_views/step2.dart';
import 'step_views/step3.dart';
import 'step_views/step4.dart';
import 'step_views/step5.dart';
import 'step_views/step6.dart';
import 'step_views/step7.dart';
import 'step_views/step8.dart';
import 'step_views/step9.dart';
import 'state/app_cubit.dart';

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
      StepSixPage(),
      StepSevenPage(),
      StepEightPage(),
      StepNinePage()
    ];

    return DefaultTabController(
      length: steps.length,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final title = state.selectedProject?.title ?? 'Project';
              return Text(title);
            },
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Step 1'),
              Tab(text: 'Step 2'),
              Tab(text: 'Step 3'),
              Tab(text: 'Step 4'),
              Tab(text: 'Step 5'),
              Tab(text: 'Step 6'),
              Tab(text: 'Step 7'),
              Tab(text: 'Step 8'),
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