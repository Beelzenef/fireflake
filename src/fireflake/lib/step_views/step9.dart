import 'package:flutter/material.dart';

import '../models/scene.dart';

class StepNinePage extends StatefulWidget {
  const StepNinePage({super.key});

  @override
  State<StepNinePage> createState() => _StepNinePageState();
}

class _StepNinePageState extends State<StepNinePage> with TickerProviderStateMixin {
  bool _isPanelOpen = false;
  Scene? _editingScene;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _chapterController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Scene> scenes = [
    Scene(
      id: 'Escena 1',
      chapter: 'Capítulo 1',
      summary: 'El protagonista despierta en un mundo desconocido, rodeado de una extraña niebla que parece tener vida propia. Debe encontrar una manera de orientarse mientras descubre que sus recuerdos están fragmentados y confusos.',
    ),
    Scene(
      id: 'Escena 2',
      chapter: 'Capítulo 1',
      summary: 'Durante su exploración, encuentra a un misterioso personaje encapuchado que le ofrece ayuda a cambio de un favor que no revela. La tensión aumenta cuando aparecen criaturas hostiles en la distancia.',
    ),
    Scene(
      id: 'Escena 3',
      chapter: 'Capítulo 2',
      summary: 'El protagonista debe tomar una decisión crucial: confiar en el extraño o aventurarse solo. Su elección determinará no solo su supervivencia, sino también el destino de otros personajes que aún no conoce.',
    ),
    Scene(
      id: 'Escena 4',
      chapter: 'Capítulo 2',
      summary: 'Una revelación inesperada cambia todo lo que el protagonista creía saber sobre su situación. Los fragmentos de sus recuerdos comienzan a formar un patrón inquietante que sugiere una conspiración más grande.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _idController.dispose();
    _chapterController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lista de Escenas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _addNewScene,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar Nueva Escena'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    dataRowHeight: 80, 
                    headingRowColor: WidgetStateProperty.all(
                      Theme.of(context).primaryColor.withOpacity(0.15),
                    ),
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Escena',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Capítulo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Resumen',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Acciones',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                    rows: scenes.map((scene) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                scene.id,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(scene.chapter),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                scene.summary,
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_up, size: 20),
                                    onPressed: scenes.indexOf(scene) > 0 
                                        ? () => _moveSceneUp(scene)
                                        : null,
                                    tooltip: 'Mover arriba',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                                    onPressed: scenes.indexOf(scene) < scenes.length - 1 
                                        ? () => _moveSceneDown(scene)
                                        : null,
                                    tooltip: 'Mover abajo',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    onPressed: () => _editScene(scene),
                                    tooltip: 'Editar escena',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    onPressed: () => _deleteScene(scene),
                                    tooltip: 'Eliminar escena',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
          if (_isPanelOpen)
            GestureDetector(
              onTap: _closeSidePanel,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          if (_isPanelOpen)
            SlideTransition(
              position: _slideAnimation,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 400,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: _buildSidePanelContent(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _editScene(Scene scene) {
    _editingScene = scene;
    _idController.text = scene.id;
    _chapterController.text = scene.chapter;
    _summaryController.text = scene.summary;
    _openSidePanel();
  }

  void _deleteScene(Scene scene) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que quieres eliminar "${scene.id}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  scenes.remove(scene);
                });
                Navigator.of(context).pop();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('${scene.escena} eliminada')),
                // );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _moveSceneUp(Scene scene) {
    setState(() {
      int currentIndex = scenes.indexOf(scene);
      if (currentIndex > 0) {
        scenes.removeAt(currentIndex);
        scenes.insert(currentIndex - 1, scene);
        
        _updateSceneNames();
      }
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('${scene.escena} movida hacia arriba')),
    // );
  }

  void _moveSceneDown(Scene scene) {
    setState(() {
      int currentIndex = scenes.indexOf(scene);
      if (currentIndex < scenes.length - 1) {
        scenes.removeAt(currentIndex);
        scenes.insert(currentIndex + 1, scene);
        
        _updateSceneNames();
      }
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('${scene.escena} movida hacia abajo')),
    // );
  }

  void _updateSceneNames() {
    for (int i = 0; i < scenes.length; i++) {
      scenes[i].id = 'Escena ${i + 1}';
    }
  }

  void _addNewScene() {
    _editingScene = null;
    _idController.text = 'Escena ${scenes.length + 1}';
    _chapterController.text = 'Capítulo ${(scenes.length ~/ 2) + 1}';
    _summaryController.text = '';
    _openSidePanel();
  }

  void _openSidePanel() {
    setState(() {
      _isPanelOpen = true;
    });
    _animationController.forward();
  }

  void _closeSidePanel() {
    _animationController.reverse().then((_) {
      setState(() {
        _isPanelOpen = false;
        _editingScene = null;
      });
    });
  }

  void _saveScene() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_editingScene != null) {
          _editingScene!.id = _idController.text;
          _editingScene!.chapter = _chapterController.text;
          _editingScene!.summary = _summaryController.text;
        } else {
          scenes.add(Scene(
            id: _idController.text,
            chapter: _chapterController.text,
            summary: _summaryController.text,
          ));
        }
      });
      _closeSidePanel();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_editingScene != null ? 'Escena actualizada' : 'Nueva escena agregada'),
        ),
      );
    }
  }

  Widget _buildSidePanelContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _editingScene != null ? 'Editar Escena' : 'Nueva Escena',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _closeSidePanel,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la escena',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _chapterController,
                    decoration: const InputDecoration(
                      labelText: 'Capítulo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _summaryController,
                      decoration: const InputDecoration(
                        labelText: 'Resumen de la escena',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        if (value.length < 50) {
                          return 'El resumen debe tener al menos 50 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _closeSidePanel,
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveScene,
                          child: Text(_editingScene != null ? 'Actualizar' : 'Agregar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
