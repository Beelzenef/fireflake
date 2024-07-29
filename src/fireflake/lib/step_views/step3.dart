import 'package:fireflake/models/character.dart';
import 'package:flutter/material.dart';

class StepThreePage extends StatefulWidget {
  const StepThreePage({super.key});

  @override
  State<StepThreePage> createState() => _StepThreePageState();
}

class _StepThreePageState extends State<StepThreePage> {
  List<Character> characters = [
    Character(name: 'Name 1', storygoal: 'Be happy'),
    Character(name: 'Name 2', storygoal: 'Be emperor'),
    Character(name: 'Name 3', storygoal: 'Conquer the world'),
    Character(name: 'Name 4', storygoal: 'Fly around the world')
  ];

  int selectedCharacter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Center(child: buildCharacterList())),
      const Expanded(
          child: Column(
        children: [
          Text('Story goal'),
        ],
      ))
    ]);
  }

  ListView buildCharacterList() {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              selectedCharacter = index;
            },
            child: Text(characters[index].name));
      },
    );
  }
}
