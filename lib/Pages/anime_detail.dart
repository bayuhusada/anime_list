import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetailPage extends StatefulWidget {
  final Anime anime;

  const AnimeDetailPage({super.key, required this.anime});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.anime.trailerUrl ?? '');
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.anime.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Anime di Atas
            Image.network(
              widget.anime.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            // Informasi Anime
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.anime.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Score: ${widget.anime.score ?? 'N/A'}"),
                  Text("Episodes: ${widget.anime.episodes ?? 'N/A'}"),
                  Text("Aired: ${widget.anime.aired ?? 'N/A'}"),
                  SizedBox(height: 16),
                  Text(
                    widget.anime.synopsis ?? 'No synopsis available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Trailer di Bawah
            if (_controller != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
