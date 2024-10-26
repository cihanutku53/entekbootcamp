import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entekbootcamp/core/components/custom_appbar.dart';
import 'package:entekbootcamp/core/register/models/user_model.dart';
import 'package:entekbootcamp/core/succesfuly_view.dart';
import 'package:entekbootcamp/value/colors.dart';
import 'package:entekbootcamp/value/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool isLoading = false;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

TextEditingController controllerUsername = TextEditingController(text: "");
TextEditingController controllerPassword = TextEditingController(text: "");

TextEditingController controllerEmail = TextEditingController(text: "");
TextEditingController controllerCity = TextEditingController(text: "");
TextEditingController controllerJob = TextEditingController(text: "");
TextEditingController controllerName = TextEditingController(text: "");
TextEditingController controllerSurname = TextEditingController(text: "");

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
    controllerUsername.addListener(() => setState(() {}));
    controllerName.addListener(() => setState(() {}));
    controllerSurname.addListener(() => setState(() {}));
    controllerJob.addListener(() => setState(() {}));
    controllerCity.addListener(() => setState(() {}));
    controllerPassword.addListener(() => setState(() {}));
    controllerEmail.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MyAppbars().loginAppBar(),
        body: loginBody(context),
      ),
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
                controller: controllerUsername,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),
              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  hintText: "E-Posta",
                ),
              ),
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
              TextField(
                controller: controllerSurname,
                decoration: InputDecoration(
                  hintText: "Surname",
                ),
              ),
              TextField(
                controller: controllerCity,
                decoration: InputDecoration(
                  hintText: "Şehir",
                ),
              ),
              TextField(
                controller: controllerJob,
                decoration: InputDecoration(
                  hintText: "Meslek",
                ),
              ),
              TextField(
                controller: controllerPassword,
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
                      inspect(
                        controllerEmail.text,
                      );
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: controllerEmail.text.toString().trim(),
                              password:
                                  controllerPassword.text.toString().trim());

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(controllerUsername.text.trim())
                          .set(UserModel(
                              username:
                                  controllerUsername.text.toString().trim(),
                              name: controllerName.text.toString().trim(),
                              surname: controllerSurname.text.toString().trim(),
                              job: controllerJob.text.toString().trim(),
                              birthday: "1998-02-23",
                              bio:
                                  "Home he forget hospital question war whatever.",
                              follows: []).toJson())
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessfulyView()),
                        );
                      });
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
