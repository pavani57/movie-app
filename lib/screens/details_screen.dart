import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String cleanHtmlTags(String htmlString) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

class DetailsScreen extends StatelessWidget {
  final dynamic movie;  // Movie data passed from HomeScreen

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String summary = movie['summary'] ?? 'No summary available';

    String cleanedSummary = cleanHtmlTags(summary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(movie['name'] ?? 'Movie Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie['image'] != null
                  ? Image.network(movie['image']['original'] ?? '')
                  : const Icon(Icons.movie, size: 100),
              const SizedBox(height: 16),
              Text(
                movie['name'] ?? 'No title',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                cleanedSummary,
                style: const TextStyle(fontSize: 16),
              ),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}