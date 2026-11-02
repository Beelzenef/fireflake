class Character {
  String name;
  String storygoal;

  Character({required this.name, required this.storygoal});

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        name: json['name'] as String,
        storygoal: json['storygoal'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'storygoal': storygoal,
      };
}
