import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReturnBookScreen extends StatefulWidget {
  @override
  _ReturnBookScreenState createState() => _ReturnBookScreenState();
}

class _ReturnBookScreenState extends State<ReturnBookScreen> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _borrowByController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Return Book'),
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
              controller: _borrowByController,
              decoration: InputDecoration(labelText: 'Your UID (borrowBy)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 209, 132, 31),
              ),
              onPressed: () {
                _returnBook();
              },
              child: Text('Return Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _returnBook() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Check if the book exists, is borrowed
    QuerySnapshot querySnapshot = await firestore
        .collection('books')
        .where('book_name', isEqualTo: _bookNameController.text)
        .where('isAvailable', isEqualTo: false)
        .where('borrowBy', isEqualTo: _borrowByController.text)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Book exists, is borrowed, and user borrowed it, can be returned
      DocumentSnapshot bookDocument = querySnapshot.docs.first;

      firestore.collection('books').doc(bookDocument.id).update({
        'isAvailable': true,
        'borrowBy': '',
      }).then((_) {
        print('Book returned successfully.');
      }).catchError((error) {
        print('Error returning book: $error');
      });
    } else {
      print(
          'Cannot return the book. Please check book name, or the book is not currently borrowed by the provided UID.');
    }
  }
}
