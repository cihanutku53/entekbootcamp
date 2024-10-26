import 'package:entekbootcamp/core/components/custom_appbar.dart';
import 'package:entekbootcamp/core/home/view/home_view.dart';
import 'package:entekbootcamp/core/login/viewmodel/login_viewmodel.dart';
import 'package:entekbootcamp/core/register/register_view.dart';
import 'package:entekbootcamp/value/colors.dart';
import 'package:entekbootcamp/value/lotties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

TextEditingController _controllerUsername =
    TextEditingController(text: "deneme3@gmail.com ");
TextEditingController _controllerPassword =
    TextEditingController(text: "deneme3");

bool isLoading = false;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbars().loginAppBar(),
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
                    MyLotties().loginLottie,
                    height: 200,
                    width: MediaQuery.of(context).size.width - 32,
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
              // ElevatedButton(
              //     onPressed: () {
              //       addFakeDataToFirestore();
              //     },
              //     child: Text("Verileri Ekle")),
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
                                    builder: (context) => RegisterView()),
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
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    // bool state = await LoginViewModel().login(
                    //     _controllerUsername.text, _controllerPassword.text);
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _controllerUsername.text.trim(),
                              password: _controllerPassword.text.trim());

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                          (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

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
                : Text("Giriş Yap")));
  }
}
