import 'package:fireflake/models/project.dart';
import 'package:fireflake/projectwrapper.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> projectsToLoad = [Project(title: 'Project 1')];

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
              width: 200,
              height: 300,
              color: Colors.grey,
              child: buildProjectList()),
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
                        print('Creating new project...');
                      },
                      child: const Text('New')),
                )
              ],
            ),
          )
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

  ListView buildProjectList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projectsToLoad.length,
      itemBuilder: (context, index) {
        return Text(
          projectsToLoad[index].title,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
