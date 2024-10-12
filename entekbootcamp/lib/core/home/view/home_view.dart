import 'dart:developer';

import 'package:entekbootcamp/core/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username;

  ///get fonksyionu
  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = null;
    });

    inspect(username);
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Ana Sayfa"),
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Ana Sayfa"),
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Ana Sayfa")
      ]),
      appBar: AppBar(
        title: const Text(
          "ENTEK UYGULAMA",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.greenAccent),
        ),
        actions: [
          IconButton(
              onPressed: () {
                getData();
              },
              icon: Icon(Icons.message_rounded))
        ],
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.black26,
            child: Row(
              children: [
                Image.asset(
                  "assets/photos/pp2.png",
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Hoşgledin"),
                //     Text("Ahmet"),
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileView(
                                name: "Ahmete",
                              )),
                    );
                  },
                  child: Text(
                    "Hoşgeldin \n${username}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          mylistView(context, "Eğitimler", Colors.black45),
          mylistView(context, "Kitaplar", Colors.amber),
        ],
      ),
    );
  }

  Container mylistView(BuildContext context, String listTitle, Color color3) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      color: color3,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                listTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(index.toString()),
                      ),
                    ),
                  );
                },
                itemCount: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
