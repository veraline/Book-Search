import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/book.dart';
import 'book_detail_screen.dart';

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];
  bool isLoading = false;

  Future<void> _searchBooks(String query) async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://openlibrary.org/search.json?q=$query'));

    try {
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> docs = jsonBody['docs'];
        setState(() {
          _searchResults = docs.map((json) => Book.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Book Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: 'Search books...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            BookDetailsScreen(book: _searchResults[index])));
                          },
                          child: Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _searchResults[index].coverImageUrl.isNotEmpty
                                        ? ClipRRect(
                                               borderRadius:BorderRadius.circular(10),
                                          child: Image.network(
                                              _searchResults[index].coverImageUrl,
                                              height: 150,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                        )
                                        : const Icon(Icons.book, size: 150),
                                    Text(
                                      _searchResults[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(_searchResults[index].author),
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
