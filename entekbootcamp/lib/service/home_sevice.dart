import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entekbootcamp/core/home/model/get_user_model.dart';
import 'package:entekbootcamp/service/base_service.dart';

class HomeService {
  Future getUserData() async {
    return await BaseService().request("users", GetUsersModel());
  }

  Future getPersonData() async {
    return await BaseService().request("users", GetUsersModel());
  }

  Future<void> getFLow() {
    CollectionReference ref = FirebaseFirestore.instance.collection("users");

    inspect(ref.get());
    return ref.get();
  }
}
