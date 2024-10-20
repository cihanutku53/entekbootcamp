import 'package:entekbootcamp/core/home/viewmodel/home_viewmodel.dart';
import 'package:entekbootcamp/core/login/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/register/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirstPage());
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}


// bool swicthState = false;

// class FirstPage extends StatefulWidget {
//   const FirstPage({super.key});

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   void myPlay() {
//     setState(() {
//       swicthState = !swicthState;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           floatingActionButton:
//               ElevatedButton(onPressed: () {}, child: Text("dsfsd")),
//           appBar: AppBar(
//             title: Text(MyTexts.name),
//             backgroundColor: Colors.amber,
//             elevation: 0,
//             leading: Icon(Icons.access_time_outlined),
//             actions: [
//               Container(
//                 color: Colors.black,
//                 child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(Icons.access_time_outlined)),
//               ),
//               Icon(Icons.access_time_outlined),
//               Icon(Icons.access_time_outlined)
//             ],
//           ),
//           body: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   myPlay();
//                 },
//                 child: Text("Buton 1"),
//               ),
//               TextButton(onPressed: () {}, child: Text("Buton 2")),
//               IconButton(
//                   onPressed: () {}, icon: Icon(Icons.access_alarm_outlined)),
//               GestureDetector(
//                 child: Text("Ali mehmet veli"),
//               ),
//               InkWell(child: Text("Ali mehmet veli")),
//               TextField(),
//               Switch(
//                   value: swicthState,
//                   onChanged: (val) {
//                     setState(() {
//                       swicthState = val;
//                     });
//                   }),
//               Text(swicthState == false ? "Durum Yanlış" : "Durum Doğrı")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
