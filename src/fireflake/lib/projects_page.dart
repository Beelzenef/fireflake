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
              height: 360,
              color: Colors.grey.shade800,
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  final projects = state.projects;
                  if (projects.isEmpty) {
                    return const Center(
                      child: Text(
                        'No projects yet.\nTap "New" to create one.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }
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
                      onPressed: () async {
                        await context.read<AppCubit>().loadProjectsFromDisk();
                      },
                      child: const Text('Refresh')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: mainButtonStyle(),
                      onPressed: () {
                        _createNewProject(context);
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
                        const SnackBar(content: Text('Project saved to disk')),
                      );
                    },
                    child: const Text('Save'),
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
            await context
                .read<AppCubit>()
                .loadAndSelectProject(projects[index].title);
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

  Future<void> _createNewProject(BuildContext context) async {
    final titleController = TextEditingController(text: 'New project');
    final wordsController = TextEditingController(text: '50000');
    final cubit = context.read<AppCubit>();
    final navigator = Navigator.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: wordsController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Expected word count'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

    if (result != true) return;
    if (!mounted) return;
    final title = titleController.text.trim().isEmpty
        ? 'New project'
        : titleController.text.trim();
    final expected = int.tryParse(wordsController.text.trim()) ?? 50000;
    cubit.saveProject(title: title, expectedWordCount: expected);
    final created = cubit.state.projects.firstWhere((p) => p.title == title);
    cubit.selectProject(created);
    await cubit.saveCurrentProjectToDisk();

    if (!mounted) return;
    navigator.push(
      MaterialPageRoute(
        builder: (context) => ProjectWrapper(),
      ),
    );
  }
}
