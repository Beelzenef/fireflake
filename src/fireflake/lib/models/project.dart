class Project {
  String title;
  String subtitle;
  int expectedWordCount;

  Project({
    required this.title,
    this.subtitle = '',
    required this.expectedWordCount,
  });
}
