import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/updateapi.dart';
import 'package:expense_tracker/user/password.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameControll=TextEditingController();

   TextEditingController emailControll=TextEditingController();

    TextEditingController addressControll=TextEditingController();

     TextEditingController phoneControll=TextEditingController();

      TextEditingController totalControll=TextEditingController();


      @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     nameControll.text=profiledata['Name'];
     emailControll .text=profiledata['Email'];
      phoneControll.text=profiledata['PhoneNumber'].toString();
       addressControll.text=profiledata['Address'];
        totalControll.text=profiledata['Totalincome'];
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
                 controller:nameControll ,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Address Field
              TextField(
                controller:addressControll ,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Phone Number Field
              TextField(
                controller:phoneControll,

               decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),

              // Email ID Field
              TextField(
                controller:emailControll,
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Total Income Field
              TextField(
                controller:totalControll,
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
                    onPressed: ()async {
                    await  updateProfile(
                        data: {
                          'Name':nameControll.text,
                          'Email':emailControll.text,
                          'PhoneNumber':phoneControll.text,
                          'Address':addressControll.text,
                          'Totalincome':totalControll.text,

                        },context: context
                      );
                      setState(() {
                        
                      });
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
