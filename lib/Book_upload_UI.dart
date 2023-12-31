import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String bookName;
  String author;
  String isbn;
  bool isAvailable;
  String borrowBy;

  Book({
    required this.bookName,
    required this.author,
    required this.isbn,
    required this.isAvailable,
    required this.borrowBy,
  });
}

class BookUploadScreen extends StatefulWidget {
  @override
  _BookUploadScreenState createState() => _BookUploadScreenState();
}

class _BookUploadScreenState extends State<BookUploadScreen> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _borrowByController = TextEditingController();

  bool _isAvailable = true;

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _bookNameController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _borrowByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _bookNameController,
              decoration: InputDecoration(labelText: 'Book Name'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _isbnController,
              decoration: InputDecoration(labelText: 'ISBN'),
            ),
            TextField(
              controller: _borrowByController,
              decoration: InputDecoration(labelText: 'Borrowed By'),
            ),
            CheckboxListTile(
              title: Text('Is Available'),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 209, 132, 31),
              ),
              onPressed: () {
                _uploadBookInfo();
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadBookInfo() {
    // Create a Book instance
    Book newBook = Book(
      bookName: _bookNameController.text,
      author: _authorController.text,
      isbn: _isbnController.text,
      isAvailable: _isAvailable,
      borrowBy: _borrowByController.text,
    );

    // Set up Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add the book data to Firestore
    firestore.collection('books').add({
      'book_name': newBook.bookName,
      'author': newBook.author,
      'isbn': newBook.isbn,
      'isAvailable': newBook.isAvailable,
      'borrowBy': newBook.borrowBy,
    }).then((value) {
      print('Book information uploaded successfully with ID: ${value.id}');
      // Optionally, you can navigate to another screen or show a success message.
    }).catchError((error) {
      print('Error uploading book information: $error');
      // Handle the error, show an error message, etc.
    });
  }
}
