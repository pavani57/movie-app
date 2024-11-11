import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'details_screen.dart';

// Function to clean up HTML tags from the summary
String cleanHtmlTags(String htmlString) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  // Fetch search results from the API
  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) return;
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        searchResults = data;
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Search Movies',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for a movie...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _searchMovies(value);
              },
            ),
          ),
          searchResults.isEmpty
              ? const Center(child: Text('No results found'))
              : Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index]['show'];
                String summary = movie['summary'] ?? 'No summary available';
                // Clean the summary by removing HTML tags
                String cleanedSummary = cleanHtmlTags(summary);

                return ListTile(
                  leading: movie['image'] != null
                      ? Image.network(movie['image']['medium'] ?? '')
                      : const Icon(Icons.movie),
                  title: Text(movie['name'] ?? 'No title'),
                  subtitle: Text(
                    cleanedSummary,
                    maxLines: 3, // Limiting the text to 3 lines
                    overflow: TextOverflow.ellipsis, // Adding ellipsis for longer text
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
