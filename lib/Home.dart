import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:right_app/AboutUs.dart';
import 'package:right_app/Grievance.dart';
import 'package:right_app/Profile.dart';
import 'package:right_app/Status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Right',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home),
              SizedBox(width: 8),
              Text('The Right'),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GrievancePage()),
                    );
                  },
                  child: MenuButton(
                    icon: Icons.message,
                    text: 'Grievances',
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatusPage()),
                    );
                  },
                  child: MenuButton(
                    icon: Icons.check_circle,
                    text: 'Status',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: MenuButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  },
                  child: MenuButton(
                    icon: Icons.info,
                    text: 'About Us',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;

  MenuButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon),
        ),
        SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}
