import 'package:flutter/material.dart';
import 'package:library_management/IssueBook.dart';
import 'package:library_management/book_list.dart';
import 'package:library_management/profile_screen.dart';
import 'Book_upload_UI.dart';
import 'return_book.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Library(),
    ReturnBookScreen(),
    IssueBookScreen(),
    BookUploadScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 132, 31),
        title: Text(
          'Librarian Pro App',
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 209, 132, 31),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Return Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Issue Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            label: 'Upload Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.library_books,
//             size: 60,
//             color: Color.fromARGB(255, 209, 132, 31),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Welcome to Your App!',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Explore and manage your books.',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
