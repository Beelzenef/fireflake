class Scene {
  String id;
  String chapter;
  String summary;

  Scene({
    required this.id,
    required this.chapter,
    required this.summary,
  });

  factory Scene.fromJson(Map<String, dynamic> json) => Scene(
        id: json['id'] as String,
        chapter: json['chapter'] as String,
        summary: json['summary'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'chapter': chapter,
        'summary': summary,
      };
}
