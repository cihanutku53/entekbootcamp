import 'dart:developer';

import 'package:entekbootcamp/core/home/model/get_user_model.dart';
import 'package:entekbootcamp/core/home/viewmodel/home_viewmodel.dart';
import 'package:entekbootcamp/core/profile/view/profile_view.dart';
import 'package:entekbootcamp/service/home_sevice.dart';
import 'package:entekbootcamp/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/view/login_view.dart';
import '../../login/viewmodel/login_viewmodel.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username;
  //GetUsersModel? getUserModel;
  //bool isLoading = true;

  ///get fonksyionu
  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = null;
    });
  }

  void getUser() async {
    await Provider.of<HomeViewModel>(context).getUsersRequest();
  }

  @override
  void initState() {
    getData();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<HomeViewModel>(context, listen: false).getUsersRequest();
    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      floatingActionButton: homeFloatingActionButton(context),
      body: homeBody(context),
    );
  }

  Widget homeBody(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.asset(
                "assets/photos/pp2.png",
              ),
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
        mylistView(context, "Kişiler", Colors.black45),
      ],
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      title: const Text(
        "ENTEK UYGULAMA",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              getData();
            },
            icon: Icon(Icons.message_rounded))
      ],
      elevation: 0,
      backgroundColor: MyColors().cetaceanBlue,
    );
  }

  FloatingActionButton homeFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.logout),
        onPressed: () {
          bool deleteState = LoginViewModel().logout();

          if (deleteState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false);
          }
        });
  }

  Widget mylistView(BuildContext context, String listTitle, Color color3) {
    return FutureBuilder(
        future: HomeService().getUserData(),
        builder: (context, data) {
          GetUsersModel userModel = data.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      listTitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 253,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: userModel!.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          userModel!.data![index].avatar!,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${userModel!.data![index].firstName} ${userModel!.data![index].lastName}"),
                                              Text(
                                                  "E-Posta: ${userModel!.data![index].email}"),
                                              Text(
                                                  "ID: ${userModel!.data![index].id}"),
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

  // Widget mylistView(BuildContext context, String listTitle, Color color3) {
  //   bool state = Provider.of<HomeViewModel>(context).isLoading;
  //   GetUsersModel getUserModel =
  //       Provider.of<HomeViewModel>(context).getUserModel;
  //   print(state);
  //   if (state) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height - 200,
  //       width: MediaQuery.of(context).size.width,
  //       child: Padding(
  //         padding: EdgeInsets.all(10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(bottom: 10),
  //               child: Text(
  //                 listTitle,
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             SizedBox(
  //               height: MediaQuery.of(context).size.height - 253,
  //               width: MediaQuery.of(context).size.width,
  //               child: ListView.builder(
  //                 itemCount: getUserModel!.data!.length,
  //                 scrollDirection: Axis.vertical,
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: EdgeInsets.only(bottom: 10),
  //                     child: Container(
  //                       height: 150,
  //                       decoration: BoxDecoration(
  //                           color: Colors.blue.shade100,
  //                           borderRadius: BorderRadius.circular(10)),
  //                       child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Row(
  //                             children: [
  //                               Flexible(
  //                                 flex: 1,
  //                                 child: ClipRRect(
  //                                   borderRadius: BorderRadius.circular(20),
  //                                   child: Image.network(
  //                                     getUserModel!.data![index].avatar!,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Flexible(
  //                                   flex: 2,
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.center,
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(
  //                                             "${getUserModel!.data![index].firstName} ${getUserModel!.data![index].lastName}"),
  //                                         Text(
  //                                             "E-Posta: ${getUserModel!.data![index].email}"),
  //                                         Text(
  //                                             "ID: ${getUserModel!.data![index].id}"),
  //                                       ],
  //                                     ),
  //                                   ))
  //                             ],
  //                           )),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   } else {
  //     return CircularProgressIndicator();
  //   }
  // }

