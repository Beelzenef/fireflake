class Protagonist {
  final List<String> storyElements;
  final String motivations;
  final String goal;
  final String conflict;
  final String epiphany;
  final List<String> finalStoryElements;

  const Protagonist({
    this.storyElements = const [],
    this.motivations = '',
    this.goal = '',
    this.conflict = '',
    this.epiphany = '',
    this.finalStoryElements = const [],
  });

  Map<String, dynamic> toJson() => {
        'storyElements': storyElements,
        'motivations': motivations,
        'goal': goal,
        'conflict': conflict,
        'epiphany': epiphany,
        'finalStoryElements': finalStoryElements,
      };

  factory Protagonist.fromJson(Map<String, dynamic> json) => Protagonist(
        storyElements: (json['storyElements'] as List<dynamic>? ?? [])
            .map((element) => element as String)
            .toList(),
        motivations: json['motivations'] as String? ?? '',
        goal: json['goal'] as String? ?? '',
        conflict: json['conflict'] as String? ?? '',
        epiphany: json['epiphany'] as String? ?? '',
        finalStoryElements: (json['finalStoryElements'] as List<dynamic>? ?? [])
            .map((element) => element as String)
            .toList(),
      );
}
