import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Book List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: _fetchBooks(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No books available'),
            );
          }

          // Book data
          List<Map<String, dynamic>> books = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Book Name: ${books[index]['book_name']}'),
                subtitle: Text('Author: ${books[index]['author']}'),
                trailing:
                    _buildAvailabilityIndicator(books[index]['isAvailable']),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvailabilityIndicator(bool isAvailable) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isAvailable ? Colors.green : Colors.red,
      ),
    );
  }

  Stream<QuerySnapshot> _fetchBooks() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch books
    return firestore.collection('books').snapshots();
  }
}
