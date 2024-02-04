import 'package:flutter/material.dart';
import '../widgets/menuItem.dart';
import '../widgets/profileItem.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Center(
          child: Column(
        children: [
          MenuItem(
              title: "nazl.sln16@gmail.com",
              icon: Icon(Icons.mail),
              onTap: () {}),
          Divider(),
          MenuItem(title: "05464178065", icon: Icon(Icons.phone), onTap: () {}),
        ],
      )),
    );
  }
}
