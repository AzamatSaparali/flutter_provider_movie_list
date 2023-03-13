class Movie {
  final String title;
  final String? duration;

  Movie({
    required this.title,
    this.duration,
  });

  toJson() {
    return {
      'title': title,
      'duration': duration,
    };
  }

  fromJson(jsonData) {
    return Movie(
      title: jsonData['title'],
      duration: jsonData['duration'],
    );
  }
}
