import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/user/feedback.dart';
import 'package:expense_tracker/user/notification.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // You can implement the notification logic here.
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade700,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackComplaintForm()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                // Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text("Logout tapped!")),
                // );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bar Graph Section
              Text(
                'Spend Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                            return Text(days[value.toInt()]);
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5)]),
                      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3)]),
                      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7)]),
                      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 2)]),
                      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 6)]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Total Spend and Balance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard('Total Spend', '\$1200'),
                  _buildInfoCard('Spend Balance', '\$800'),
                ],
              ),
              SizedBox(height: 20),

              // Transaction History
              Text(
                'Transaction History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTransactionTile('Groceries', 'Dec 25, 2024', '12:30 PM', '\$50'),
                    _buildTransactionTile('Restaurant', 'Dec 24, 2024', '7:45 PM', '\$80'),
                    _buildTransactionTile('Electric Bill', 'Dec 23, 2024', '9:15 AM', '\$120'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the Spend and Balance cards
  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build transaction tiles
  Widget _buildTransactionTile(String title, String date, String time, String amount) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.attach_money, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$date, $time'),
      trailing: Text(
        amount,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}
