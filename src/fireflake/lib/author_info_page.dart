import 'package:flutter/material.dart';

class AuthorInfoPage extends StatefulWidget {
    const AuthorInfoPage({super.key});

  @override
  State<AuthorInfoPage> createState() => _AuthorInfoPageState();
}

class _AuthorInfoPageState extends State<AuthorInfoPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _bio = '';
  String _email = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Author info saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Author Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
                onSaved: (value) => _name = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bio'),
                maxLines: 3,
                onSaved: (value) => _bio = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter email' : null,
                onSaved: (value) => _email = value ?? '',
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}