import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final notofications;

  const NotificationScreen({super.key, this.notofications});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Replace with your dynamic notification list
          itemBuilder: (context, index) {
            return _buildNotificationTile(
              'Notification Title $index', 
              'This is the notification description for item $index.',
              'Dec 26, 2024',
            );
          },
        ),
      ),
    );
  }

  // Helper method to build each notification tile
  Widget _buildNotificationTile(String title, String description, String date) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}
