class Anime {
  final int malId;
  final String title;
  final String imageUrl;
  final String? synopsis;
  final double? score;
  final int? episodes;
  final String? aired;
  final String? trailerUrl;

  Anime({
    required this.malId,
    required this.title,
    required this.imageUrl,
    this.synopsis,
    this.score,
    this.episodes,
    this.aired,
    this.trailerUrl,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
      synopsis: json['synopsis'],
      score: (json['score'] as num?)?.toDouble(),
      episodes: json['episodes'],
      aired: json['aired'] != null ? json['aired']['string'] : 'Unknown',
      trailerUrl: json['trailer']?['embed_url'], // <- ini penting!
    );
  }
}
