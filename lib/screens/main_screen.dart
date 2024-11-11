import 'package:flutter/material.dart';
import 'home.dart';  // Import the HomeScreen widget
import 'search_screen.dart'; // Import the SearchScreen widget

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens corresponding to each tab
  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
  ];

  // Update the selected index based on the tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: _screens[_selectedIndex], // Show the screen corresponding to selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,  // Maintain current index
        onTap: _onItemTapped,         // Update the selected index
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
