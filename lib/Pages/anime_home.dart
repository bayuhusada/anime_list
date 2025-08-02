import 'package:flutter/material.dart';
import 'package:latihan_http_req/constant/colors.dart';
import '../models/anime_model.dart';
import '../services/anime_service.dart';
import 'anime_detail.dart';

class AnimeHome extends StatefulWidget {
  const AnimeHome({super.key});

  @override
  State<AnimeHome> createState() => _AnimeHomeState();
}

class _AnimeHomeState extends State<AnimeHome> {
  List<Anime> animeList = [];
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAnime(); // default ambil semua anime
  }

  Future<void> fetchAnime([String? query]) async {
    setState(() => isLoading = true);

    try {
      if (query == null || query.isEmpty) {
        animeList = await AnimeService.fetchAnimeList(); // default
      } else {
        animeList = await AnimeService.searchAnime(query); // search
      }
    } catch (e) {
      animeList = [];
    }

    setState(() => isLoading = false);
  }

  void _onSearch() {
    final query = searchController.text.trim();
    fetchAnime(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime List", style: TextStyle(color: primColor),),
        backgroundColor: seconColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onSubmitted: (_) => _onSearch(),
              decoration: InputDecoration(
                hintText: "Search anime...",
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _onSearch,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : animeList.isEmpty
              ? Center(child: Text("Tidak ada hasil."))
              : ListView.builder(
                  itemCount: animeList.length,
                  itemBuilder: (context, index) {
                    final anime = animeList[index];
                    return Card(
                      elevation: 5,
                      
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          anime.imageUrl,
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        title: Text(anime.title),
                        subtitle: Text('Total Eps ${anime.episodes}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnimeDetailPage(anime: anime),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
