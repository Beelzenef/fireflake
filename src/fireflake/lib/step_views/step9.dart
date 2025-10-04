import 'package:flutter/material.dart';

class Scene {
  String id;
  String chapter;
  String summary;

  Scene({
    required this.id,
    required this.chapter,
    required this.summary,
  });
}

class StepNinePage extends StatefulWidget {
  const StepNinePage({super.key});

  @override
  State<StepNinePage> createState() => _StepNinePageState();
}

class _StepNinePageState extends State<StepNinePage> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    headingRowColor: MaterialStateProperty.all(
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
    );
  }

  void _editScene(Scene scene) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Editando: ${scene.escena}')),
    // );
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
    setState(() {
      scenes.add(Scene(
        id: 'Escena ${scenes.length + 1}',
        chapter: 'Capítulo ${(scenes.length ~/ 2) + 1}',
        summary: 'Nueva escena agregada. Aquí se describe lo que sucede en esta escena, con suficiente detalle para proporcionar contexto sobre los eventos, personajes y desarrollo de la trama que tiene lugar.',
      ));
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Nueva escena agregada')),
    // );
  }
}
