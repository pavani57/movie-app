import 'dart:convert';
import 'package:assessment_project_1/screens/search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_screen.dart';

String cleanHtmlTags(String htmlString) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  // Fetch movies from the API
  Future<void> _fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        movies = data;
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Movies',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to the Search Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index]['show'];
          String summary = movie['summary'] ?? 'No summary available';

          String cleanedSummary = cleanHtmlTags(summary);
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: movie['image'] != null
                  ? Image.network(movie['image']['medium'] ?? '')
                  : const Icon(Icons.movie),
              title: Text(movie['name'] ?? 'No title'),
              subtitle: Text(
                cleanedSummary,
                maxLines: 3,  // Limiting to 3 lines
                overflow: TextOverflow.ellipsis,  // Show ellipsis for longer text
              ),

              onTap: () {
                // Navigate to Details Screen when a movie is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
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