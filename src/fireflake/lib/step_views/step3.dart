import 'package:fireflake/models/character.dart';
import 'package:flutter/material.dart';

class StepThreePage extends StatefulWidget {
  const StepThreePage({super.key});

  @override
  State<StepThreePage> createState() => _StepThreePageState();
}

class _StepThreePageState extends State<StepThreePage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _historyControllers = [];
  final TextEditingController _motivationsController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _conflictController = TextEditingController();
  final TextEditingController _epiphanyController = TextEditingController();
  final List<TextEditingController> _finalHistoryControllers = [];

  @override
  void initState() {
    super.initState();
    _addHistoryField();
    _addFinalHistoryField();
  }

  @override
  void dispose() {
    for (var controller in _historyControllers) {
      controller.dispose();
    }
    for (var controller in _finalHistoryControllers) {
      controller.dispose();
    }
    _motivationsController.dispose();
    _objectiveController.dispose();
    _conflictController.dispose();
    _epiphanyController.dispose();
    super.dispose();
  }

  void _addHistoryField() {
    setState(() {
      _historyControllers.add(TextEditingController());
    });
  }

  void _removeHistoryField(int index) {
    if (_historyControllers.length > 1) {
      setState(() {
        _historyControllers[index].dispose();
        _historyControllers.removeAt(index);
      });
    }
  }

  void _addFinalHistoryField() {
    setState(() {
      _finalHistoryControllers.add(TextEditingController());
    });
  }

  void _removeFinalHistoryField(int index) {
    if (_finalHistoryControllers.length > 1) {
      setState(() {
        _finalHistoryControllers[index].dispose();
        _finalHistoryControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Información del Personaje',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                const Text(
                  'Su historia (elementos con una sola frase)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ..._historyControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Elemento de historia ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es requerido';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeHistoryField(index),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: _addHistoryField,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar elemento de historia'),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _motivationsController,
                  decoration: const InputDecoration(
                    labelText: 'Sus motivaciones',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _objectiveController,
                  decoration: const InputDecoration(
                    labelText: 'Su objetivo',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _conflictController,
                  decoration: const InputDecoration(
                    labelText: 'Su conflicto',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _epiphanyController,
                  decoration: const InputDecoration(
                    labelText: 'Epifanía',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  'Su historia final (elementos con una sola frase)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ..._finalHistoryControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Elemento de historia final ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es requerido';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeFinalHistoryField(index),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: _addFinalHistoryField,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar elemento de historia final'),
                ),
                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Información del personaje guardada'),
                          ),
                        );
                      }
                    },
                    child: const Text('Guardar Información'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


