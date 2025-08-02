import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class AnimeService {
  static Future<List<Anime>> fetchAnimeList() async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime?page=1'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      return data.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Gagal mengambil data anime');
    }
  }
  
  static Future<List<Anime>> searchAnime(String query) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime?q=$query'));

  if (response.statusCode == 200) {
    final List data = json.decode(response.body)['data'];
    return data.map((anime) => Anime.fromJson(anime)).toList();
  } else {
    throw Exception('Gagal mencari anime');
  }
}

}
