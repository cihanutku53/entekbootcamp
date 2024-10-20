import 'dart:developer';
import 'package:entekbootcamp/core/home/model/get_user_model.dart';
import 'package:entekbootcamp/service/home_sevice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login/viewmodel/login_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  GetUsersModel _getUserModel = GetUsersModel();
  String baseUrl = "https://reqres.in/api";

  bool get isLoading => _isLoading;
  GetUsersModel get getUserModel => _getUserModel;

  void stateChange(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  Future getUsersRequest() async {
    try {
      _getUserModel = await HomeService().getUserData();
      inspect(_getUserModel);
      stateChange(true);
    } catch (e) {}
  }
}
