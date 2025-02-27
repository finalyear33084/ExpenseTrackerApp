import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/updateapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:expense_tracker/user/password.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameControll = TextEditingController();
  TextEditingController emailControll = TextEditingController();
  TextEditingController addressControll = TextEditingController();
  TextEditingController phoneControll = TextEditingController();
  TextEditingController totalControll = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Assuming profiledata is available
    nameControll.text = profiledata['Name'];
    emailControll.text = profiledata['Email'];
    phoneControll.text = profiledata['PhoneNumber'].toString();
    addressControll.text = profiledata['Address'];
    totalControll.text = profiledata['Totalincome'];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 135, 102, 194),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Field
                  TextFormField(
                    controller: nameControll,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Address Field
                  TextFormField(
                    controller: addressControll,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone Number Field
                  TextFormField(
                    controller: phoneControll,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      final phoneRegExp = RegExp(r'^[0-9]+$');
                      if (!phoneRegExp.hasMatch(value.trim())) {
                        return 'Please enter a valid phone number';
                      }
                      // 10 numbers
                      if (value.trim().length != 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email ID Field
                  TextFormField(
                    controller: emailControll,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegExp.hasMatch(value.trim())) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Total Income Field
                  TextFormField(
                    controller: totalControll,
                    decoration: const InputDecoration(
                      labelText: 'Total Income',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your total income';
                      }
                      if (double.tryParse(value.trim()) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),

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
                        child: const Text('Change Password'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 161, 116, 239),
                        ),
                      ),

                      // Update Button
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await updateProfile(
                              data: {
                                'Name': nameControll.text,
                                'Email': emailControll.text,
                                'PhoneNumber': phoneControll.text,
                                'Address': addressControll.text,
                                'Totalincome': totalControll.text,
                              },
                              context: context,
                            );
                            setState(() {});
                          }
                        },
                        child: const Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
