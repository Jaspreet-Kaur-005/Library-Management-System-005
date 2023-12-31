import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IssueBookScreen extends StatefulWidget {
  @override
  _IssueBookScreenState createState() => _IssueBookScreenState();
}

class _IssueBookScreenState extends State<IssueBookScreen> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _borrowByController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Issue Book'),
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
                _issueBook();
              },
              child: Text('Issue Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _issueBook() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Check if the book exists and is available
    QuerySnapshot querySnapshot = await firestore
        .collection('books')
        .where('book_name', isEqualTo: _bookNameController.text)
        .where('isAvailable', isEqualTo: true)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Book exists can be issued
      DocumentSnapshot bookDocument = querySnapshot.docs.first;

      firestore.collection('books').doc(bookDocument.id).update({
        'isAvailable': false,
        'borrowBy': _borrowByController.text,
      }).then((_) {
        print('Book issued successfully.');
      }).catchError((error) {
        print('Error issuing book: $error');
      });
    } else {
      print(
          'Cannot issue the book. Please check book name, or the book is not available for issuing.');
    }
  }
}
