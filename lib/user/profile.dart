import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/user/password.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextField(
                 controller:TextEditingController(text: profiledata['Name']) ,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Address Field
              TextField(
                controller:TextEditingController(text: profiledata['Address']) ,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Phone Number Field
              TextField(
                controller:TextEditingController(text: profiledata['PhoneNumber'].toString()),

               decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),

              // Email ID Field
              TextField(
                controller:TextEditingController(text: profiledata['Email']),
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Total Income Field
              TextField(
                controller:TextEditingController(text: profiledata['Totalincome'].toString()),
                decoration: InputDecoration(
                  labelText: 'Total Income',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 32),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Change Password Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
                      );
                    },
                    child: Text('Change Password'),
                  ),

                  // Update Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Update Action
                    },
                    child: Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
