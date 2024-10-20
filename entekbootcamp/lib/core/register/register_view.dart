import 'dart:developer';
import 'package:entekbootcamp/core/home/view/home_view.dart';
import 'package:entekbootcamp/core/login/viewmodel/login_viewmodel.dart';
import 'package:entekbootcamp/value/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _controllerUsername = TextEditingController(text: "");
TextEditingController _controllerPassword = TextEditingController(text: "");

bool isLoading = false;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              Text("Uygulamamıza Kayıt Olabilirsiniz",
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
              registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox registerButton(BuildContext context) {
    return SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors().awesome)),
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: "deneme@entek.com", password: "deneme");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    // bool state = await LoginViewModel().login(
                    //     _controllerUsername.text, _controllerPassword.text);

                    // if (state) {
                    //   Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => HomeView()),
                    //       (route) => false);
                    // } else {}

                    setState(() {
                      isLoading = false;
                    });
                    // if (_controllerUsername.text == "cihan." &&
                    //     _controllerPassword.text == "12345") {
                    //   saveData();
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => HomeView()),
                    //   );
                    // } else {
                    //   print("Hatalı giriş");
                    // }
                  },
            child: isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text("Kayıt Ol")));
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
