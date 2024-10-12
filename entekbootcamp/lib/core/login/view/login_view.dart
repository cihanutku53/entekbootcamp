import 'dart:developer';
import 'package:entekbootcamp/core/home/view/home_view.dart';
import 'package:entekbootcamp/value/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _controllerUsername = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controllerUsername.text);
    final String? username = prefs.getString('username');
    inspect(username);
    print("username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar(),
      body: loginBody(context),
    );
  }

  Padding loginBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LottieBuilder.asset(
                    "assets/lotties/complete.json",
                    repeat: false,
                    height: 200,
                    width: 200,
                  )),
              Text("Uygulamamıza Hoşgeldiniz!",
                  style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(
                  "Daha fazla hizmetlerimizden yararlanmak istiyorsanız kayıt olun giriş yapın.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 14)),
              TextField(
                controller: _controllerUsername,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),
              TextField(
                controller: _controllerPassword,
                decoration: InputDecoration(
                  hintText: "Şifre",
                ),
              ),
              const Expanded(child: SizedBox()),
              loginButton(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Hesabın yoksa ',
                    style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'kayıt ol!',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView()),
                              );
                            },
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors().awesome)),
            onPressed: () async {
              if (_controllerUsername.text == "cihan." &&
                  _controllerPassword.text == "12345") {
                saveData();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              } else {
                print("Hatalı giriş");
              }
            },
            child: const Text("Giriş Yap")));
  }

  AppBar loginAppBar() {
    return AppBar(
      title: Text("Entek Mobil",
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.bold,
          )),
      centerTitle: true,
      backgroundColor: MyColors().cetaceanBlue,
      elevation: 0,
    );
  }
}
