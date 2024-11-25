import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDbService {
  final String apiKey = 'd593f9873e5ad2cc530bb5e0c7febf41';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=tr-TR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Popüler filmleri getirirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchTopRatedMovies() async {
    final url = Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&language=tr-TR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('TopRated filmleri getirirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchPopularTVShows() async {
    final url = Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=tr-TR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Popüler dizileri getirirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=tr-TR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Film detaylarını getirirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchTVDetails(int tvId) async {
    final url = Uri.parse('$baseUrl/tv/$tvId?api_key=$apiKey&language=tr-TR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Dizi detaylarını getirirken hata oluştu: ${response.statusCode}');
    }
  }
}
