import 'package:fireflake/author_info_page.dart';
import 'package:fireflake/models/project.dart';
import 'package:fireflake/projectwrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state/app_cubit.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> projectsToLoad = [Project(title: 'Project 1', expectedWordCount: 1000)];

  @override
  void initState() {
    super.initState();
    // Load projects from disk on startup
    context.read<AppCubit>().loadProjectsFromDisk();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              width: 220,
              height: 320,
              color: Colors.grey,
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  final projects = state.projects.isEmpty ? projectsToLoad : state.projects;
                  return buildProjectList(projects);
                },
              )),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: mainButtonStyle(),
                      onPressed: () {
                        final cubit = context.read<AppCubit>();
                        cubit.loadInitial(projectsToLoad);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProjectWrapper(),
                          ),
                        );
                      },
                      child: const Text('Open')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: mainButtonStyle(),
                      onPressed: () {
                        final cubit = context.read<AppCubit>();
                        final newProject = Project(title: 'New Project', expectedWordCount: 2000);
                        final updated = List<Project>.from(cubit.state.projects)..add(newProject);
                        cubit.loadInitial(updated);
                        cubit.selectProject(newProject);
                      },
                      child: const Text('New')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: mainButtonStyle(),
                    onPressed: () async {
                      await context.read<AppCubit>().saveCurrentProjectToDisk();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Proyecto guardado en disco')),
                      );
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: mainButtonStyle(),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AuthorInfoPage(),
                    ),
                  );
                },
                child: const Text('Author info')),
          ),
        ],
      ),
    );
  }

  ButtonStyle mainButtonStyle() {
    return ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(const Size(100, 50)),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white));
  }

  ListView buildProjectList(List<Project> projects) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            await context.read<AppCubit>().loadAndSelectProject(projects[index].title);
            if (!context.mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProjectWrapper(),
              ),
            );
          },
          child: Text(
            projects[index].title,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
