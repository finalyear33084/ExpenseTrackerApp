import 'package:expense_tracker/menu/ExpensePage.dart';
import 'package:expense_tracker/user/chatbot.dart';
import 'package:expense_tracker/user/homescreen.dart';
import 'package:expense_tracker/user/profile.dart';
import 'package:expense_tracker/user/scanpay.dart';
import 'package:flutter/material.dart';
 int currentIndex = 0;
class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  // Tracks the selected bottom navigation bar item

  // Function to handle bottom navigation bar taps
  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget>screens=[
    const HomeScreen(),
     const ExpensePage(),
     const ScanAndPayScreen(),
     const ChatbotScreen(),
    const ProfileScreen(),
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
     
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTabTapped,
        items: const [
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
    switch (currentIndex) {
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

