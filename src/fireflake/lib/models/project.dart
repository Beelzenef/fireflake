import 'scene.dart';
import 'character.dart';

class Project {
  // TODO: consider making these fields final with copyWith returning new instance; current mutable for simplicity.
  String title;
  String subtitle;
  int expectedWordCount;
  String summary;
  String act1;
  String act2;
  String act3;
  String finale;
  // Step 4: Expanded paragraphs from step 2
  String expandedAct1;
  String expandedAct2;
  String expandedAct3;
  String expandedFinale;
  // Step 6: Further expanded argument
  String extendedArgument;
  // Step 8: List of pending scenes
  List<String> pendingScenes;
  List<Scene> scenes;
  List<Character> characters;

  Project({
    required this.title,
    this.subtitle = '',
    required this.expectedWordCount,
    this.summary = '',
    this.act1 = '',
    this.act2 = '',
    this.act3 = '',
    this.finale = '',
    this.expandedAct1 = '',
    this.expandedAct2 = '',
    this.expandedAct3 = '',
    this.expandedFinale = '',
    this.extendedArgument = '',
    this.pendingScenes = const [],
    this.scenes = const [],
    this.characters = const [],
  });

  Project copyWith({
    String? title,
    String? subtitle,
    int? expectedWordCount,
    String? summary,
    String? act1,
    String? act2,
    String? act3,
    String? finale,
    String? expandedAct1,
    String? expandedAct2,
    String? expandedAct3,
    String? expandedFinale,
    String? extendedArgument,
    List<String>? pendingScenes,
    List<Scene>? scenes,
    List<Character>? characters,
  }) {
    return Project(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      expectedWordCount: expectedWordCount ?? this.expectedWordCount,
      summary: summary ?? this.summary,
      act1: act1 ?? this.act1,
      act2: act2 ?? this.act2,
      act3: act3 ?? this.act3,
      finale: finale ?? this.finale,
      expandedAct1: expandedAct1 ?? this.expandedAct1,
      expandedAct2: expandedAct2 ?? this.expandedAct2,
      expandedAct3: expandedAct3 ?? this.expandedAct3,
      expandedFinale: expandedFinale ?? this.expandedFinale,
      extendedArgument: extendedArgument ?? this.extendedArgument,
      pendingScenes: pendingScenes ?? this.pendingScenes,
      scenes: scenes ?? this.scenes,
      characters: characters ?? this.characters,
    );
  }

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        title: json['title'] as String,
        subtitle: json['subtitle'] as String? ?? '',
        expectedWordCount: json['expectedWordCount'] as int,
        summary: json['summary'] as String? ?? '',
        act1: json['act1'] as String? ?? '',
        act2: json['act2'] as String? ?? '',
        act3: json['act3'] as String? ?? '',
        finale: json['finale'] as String? ?? '',
        expandedAct1: json['expandedAct1'] as String? ?? '',
        expandedAct2: json['expandedAct2'] as String? ?? '',
        expandedAct3: json['expandedAct3'] as String? ?? '',
        expandedFinale: json['expandedFinale'] as String? ?? '',
        extendedArgument: json['extendedArgument'] as String? ?? '',
        pendingScenes: (json['pendingScenes'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
        scenes: (json['scenes'] as List<dynamic>? ?? [])
            .map((e) => Scene.fromJson(e as Map<String, dynamic>))
            .toList(),
        characters: (json['characters'] as List<dynamic>? ?? [])
            .map((e) => Character.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'expectedWordCount': expectedWordCount,
        'summary': summary,
        'act1': act1,
        'act2': act2,
        'act3': act3,
        'finale': finale,
        'expandedAct1': expandedAct1,
        'expandedAct2': expandedAct2,
        'expandedAct3': expandedAct3,
        'expandedFinale': expandedFinale,
        'extendedArgument': extendedArgument,
        'pendingScenes': pendingScenes,
        'scenes': scenes.map((s) => s.toJson()).toList(),
        'characters': characters.map((c) => c.toJson()).toList(),
      };
}
