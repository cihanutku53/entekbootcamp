import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key, required this.name});

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
    );
  }
}
