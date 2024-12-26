import 'package:expense_tracker/user/profile.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatelessWidget {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Password Field
            Text(
              'New Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your new password',
              ),
            ),
            SizedBox(height: 16),

            // Confirm Password Field
            Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Confirm your new password',
              ),
            ),
            SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _updatePassword(context); // Call _updatePassword on submit
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to validate and update the password
  void _updatePassword(BuildContext context) {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Check if fields are empty
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showMessage(context, 'Please fill in all fields.');
      return;
    }

    // Check if the passwords match
    if (newPassword != confirmPassword) {
      _showMessage(context, 'Passwords do not match.');
      return;
    }

    // You can add additional password validation logic here (e.g., length, complexity)

    // Simulate password update logic
    _showMessage(context, 'Password updated successfully!');

    // Navigate to Profile Screen after successful update
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProfileScreen()), // Redirect to Profile Screen
    // );
    Navigator.pop(context);
  }

  // Method to show messages (snack bar)
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
