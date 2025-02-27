import 'package:expense_tracker/services/passwordapi.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool newpasswordvisibility = true;

  bool confirmvisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Password Field
            const Text(
              'New Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              obscureText: newpasswordvisibility,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      newpasswordvisibility = !newpasswordvisibility;
                      setState(() {});
                    },
                    icon: Icon(newpasswordvisibility
                        ? Icons.visibility_off
                        : Icons.visibility)),
                border: OutlineInputBorder(),
                hintText: 'Enter your new password',
              ),
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            const Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: confirmvisibility,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      confirmvisibility = !confirmvisibility;
                      setState(() {});
                    },
                    icon: Icon(confirmvisibility
                        ? Icons.visibility_off
                        : Icons.visibility)),
                border: OutlineInputBorder(),
                hintText: 'Confirm your new password',
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _updatePassword(context); // Call _updatePassword on submit
                },
                child: const Text('Submit'),
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
      showMessage(context, 'Please fill in all fields.');
      return;
    }

    // Check if the passwords match
    if (newPassword != confirmPassword) {
      showMessage(context, 'Passwords do not match.');
      return;
    }
    if (newPassword.length < 6) {
      showMessage(context, 'Passwords must contain 6 character.');
      return;
    }

    if (!RegExp(r'[A-Z]').hasMatch(newPassword)) {
      showMessage(
          context, 'Password must contain at least one uppercase letter.');
      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(newPassword)) {
      showMessage(context, 'Password must contain at least one number.');
      return;
    }

    changePassword(data: {'Password': newPassword}, context: context);
  }

  // Method to show messages (snack bar)
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
