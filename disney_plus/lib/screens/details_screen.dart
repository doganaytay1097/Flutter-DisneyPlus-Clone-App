import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TMDbService tmdbService = TMDbService();
  Map<String, dynamic>? details;
  bool isLoading = true;
  bool isMovie = true;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() async {
    try {
      final id = widget.movie['id'];
      isMovie = widget.movie.containsKey('release_date');
      details = isMovie
          ? await tmdbService.fetchMovieDetails(id)
          : await tmdbService.fetchTVDetails(id);
    } catch (e) {
      print('Detay çekme hatası: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getDetailsText() {
    if (details == null) return 'Bilgiler yüklenemedi';
    final year = details?['release_date']?.split('-').first ??
        details?['first_air_date']?.split('-').first ??
        'Bilinmiyor';
    final genres = (details?['genres'] as List<dynamic>?)
        ?.map((genre) => genre['name'])
        .join(', ') ??
        'Tür bilgisi yok';
    final seasons = details?['number_of_seasons'] != null
        ? '${details?['number_of_seasons']} Sezon'
        : '';
    return '$year · $seasons · $genres';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://image.tmdb.org/t/p/w500${widget.movie['backdrop_path']}';

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,size: 15,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: 16),
                      Icon(Icons.cast, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details?['title'] ??
                        details?['name'] ??
                        'Başlık bilgisi yok',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    getDetailsText(),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.play_arrow),
                    label: Text('Oynat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF113CCF),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.video_library, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'Fragman',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'İzleme Listem',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    details?['overview'] ??
                        'Bu içerik hakkında açıklama bulunamadı.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  DefaultTabController(
                    length: isMovie ? 3 : 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFF113CCF),
                          tabs: [
                            if (!isMovie) Tab(text: 'Bölümler'),
                            Tab(text: 'Öneriler'),
                            Tab(text: 'Ekstralar'),
                            Tab(text: 'Ayrıntılar',)
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: TabBarView(
                            children: [
                              if (!isMovie)
                                Center(
                                  child: Text(
                                    '1. Sezon Bölümleri',
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                              Center(
                                child: Text(
                                  'Önerilen İçerikler',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Ekstra Videolar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  isMovie ? 'Filmin Ayrıntıları' : 'Dizinin Ayrıntıları',

                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
