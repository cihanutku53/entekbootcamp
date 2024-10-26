import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../value/colors.dart';

class MyAppbars {
  AppBar loginAppBar() {
    return AppBar(
      title: Text("LinkEntek",
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.bold,
          )),
      backgroundColor: MyColors().blue,
      elevation: 0,
    );
  }

  AppBar customAppbarWithActions(
      BuildContext context, IconData icon, Widget page) {
    return AppBar(
      title: Text("LinkEntek",
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.bold,
          )),
      backgroundColor: MyColors().blue,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            icon: Icon(icon))
      ],
      elevation: 0,
    );
  }
}
