import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/menu/ExpensePage.dart';
import 'package:expense_tracker/user/chatbot.dart';
import 'package:expense_tracker/user/feedback.dart';
import 'package:expense_tracker/user/homescreen.dart';
import 'package:expense_tracker/user/profile.dart';
import 'package:expense_tracker/user/scanpay.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0; // Tracks the selected bottom navigation bar item

  // Function to handle bottom navigation bar taps
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget>screens=[
    HomeScreen(),
     ExpensePage(),
     ScanAndPayScreen(),
     ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Page"),
      //   backgroundColor: Colors.green,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {
      //         // Handle button press
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(content: Text("Notification button tapped!")),
      //         );
      //       },
      //     ),
      //   ],
      // ),
     
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Expense Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan & Pay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
      ),
    );
  }

  // Helper method to get the tab name
  String _getTabName() {
    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Expense Tracker';
      case 2:
        return 'Scan & Pay';
      case 3:
        return 'Chatbot';
      case 4:
        return 'Profile';
      default:
        return 'Unknown';
    }
  }
}

