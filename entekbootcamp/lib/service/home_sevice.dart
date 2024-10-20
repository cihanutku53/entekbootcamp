import 'package:entekbootcamp/core/home/model/get_user_model.dart';
import 'package:entekbootcamp/service/base_service.dart';

class HomeService {
  Future getUserData() async {
    return await BaseService().request("users", GetUsersModel());
  }

  Future getPersonData() async {
    return await BaseService().request("users", GetUsersModel());
  }
}
