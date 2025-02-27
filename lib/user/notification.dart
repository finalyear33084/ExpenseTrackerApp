import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final notofications;

  const NotificationScreen({super.key, this.notofications});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: notofications.isEmpty
            ? const Center(
                child: Text('No notifications yet!'),
              )
            : ListView.builder(
                itemCount: notofications
                    .length, // Replace with your dynamic notification list
                itemBuilder: (context, index) {
                  return _buildNotificationTile(
                    '${notofications[index]['notification']}',
                    '${notofications[index]['notification_date'].toString().substring(0, 10)}',
                  );
                },
              ),
      ),
    );
  }

  // Helper method to build each notification tile
  Widget _buildNotificationTile(String title, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        // subtitle: Text(description),
        trailing: Text(date,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}
