import 'package:fireflake/projects_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state/app_cubit.dart';
import 'state/author_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (_) => AppCubit()),
        BlocProvider<AuthorCubit>(create: (_) => AuthorCubit()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fireflake',
      theme: ThemeData(brightness: Brightness.light),
      home: HomePage(title: 'Fireflake'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: ProjectsPage(),
    );
  }
}
