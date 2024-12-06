import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/tmdb_service.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDbService tmdbService = TMDbService();
  late Future<List<dynamic>> popularMovies;
  late Future<List<dynamic>> popularTVShows;
  late Future<List<dynamic>> topRatedMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = tmdbService.fetchPopularMovies();
    popularTVShows = tmdbService.fetchPopularTVShows();
    topRatedMovies = tmdbService.fetchTopRatedMovies();
  }

  Widget buildCarousel(Future<List<dynamic>> movies) {
    return FutureBuilder<List<dynamic>>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final moviesList = snapshot.data!;
          return CarouselSlider(
            options: CarouselOptions(
              height: 210.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 0.9,
            ),
            items: moviesList.map((movie) {
              final imageUrl =
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        movie['title'] ?? movie['name'] ?? 'Başlık',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(child: Text('Veri bulunamadı.'));
        }
      },
    );
  }

  Widget buildHorizontalList(String title, Future<List<dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<dynamic>>(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 150,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final movies = snapshot.data!;
              return Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final imageUrl =
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movie: movie),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie['title'] ?? movie['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('Veri bulunamadı.'));
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/disney.png',
          height: 50,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff142850),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarousel(popularMovies),
            buildHorizontalList('Disney+’ta Yeni', popularMovies),
            buildHorizontalList('Popüler Diziler', popularTVShows),
            buildHorizontalList('En Çok Oy Alan Filmler', topRatedMovies),
          ],
        ),
      ),
    );
  }
}
