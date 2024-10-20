import 'package:dio/dio.dart';

import 'base_model.dart';

class BaseService {
  String baseUrl = "https://reqres.in/api";
  final Dio dio = Dio();

  Future request<T extends IBaseModel>(String path, IBaseModel model) async {
    try {
      final response = await dio.get(
        "$baseUrl/$path",
      );

      return model.fromJson(response.data);
    } catch (e) {}
  }
}
