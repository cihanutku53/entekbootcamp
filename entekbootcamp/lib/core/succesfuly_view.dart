import 'package:entekbootcamp/core/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../value/colors.dart';
import '../value/lotties.dart';

class SuccessfulyView extends StatelessWidget {
  const SuccessfulyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbars().loginAppBar(),
      body: Padding(
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
                        MyLotties().completeLottie,
                        height: 200,
                        width: MediaQuery.of(context).size.width - 32,
                      )),
                  Text("Kayıt Başarılı",
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Text(
                      "Tebrikler başarıyla kayıt oldun. Şimdi giriş yapma zamanı",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 14)),
                  SizedBox(
                    height: 16,
                  ),
                  backButton(context)
                ]),
          ),
        ),
      ),
    );
  }

  SizedBox backButton(BuildContext context) {
    return SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors().awesome)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
            child: Text("Geri Dön")));
  }
}
