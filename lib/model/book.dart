import 'package:flutter/material.dart';

class Book {
  String title;
  String author;
  String description;
  String coverImageUrl;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author_name'] != null ? json['author_name'].join(', ') : '',
      description: json['description'] ?? '',
      coverImageUrl: json['cover_i'] != null ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg' : '',
    );
  }
}
