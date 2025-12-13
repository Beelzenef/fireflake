import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state/author_cubit.dart';
import 'models/author_settings.dart';

class AuthorInfoPage extends StatefulWidget {
  const AuthorInfoPage({super.key});

  @override
  State<AuthorInfoPage> createState() => _AuthorInfoPageState();
}

class _AuthorInfoPageState extends State<AuthorInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthorCubit>().updateAll(
            name: _nameController.text,
            bio: _bioController.text,
            email: _emailController.text,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Información del autor guardada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Información del Autor')),
      body: BlocBuilder<AuthorCubit, AuthorSettings>(
        builder: (context, settings) {
          // Actualizar controladores cuando cambie el estado
          if (_nameController.text != settings.name) {
            _nameController.text = settings.name;
          }
          if (_bioController.text != settings.bio) {
            _bioController.text = settings.bio;
          }
          if (_emailController.text != settings.email) {
            _emailController.text = settings.email;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'Esta configuración se guarda de forma global y será usada en todos los proyectos.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ingresa tu nombre' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'Biografía',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa tu email';
                      }
                      if (!value.contains('@')) {
                        return 'Ingresa un email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}