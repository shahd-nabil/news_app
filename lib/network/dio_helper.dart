import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/v2/',
          receiveDataWhenStatusError: true,
          headers: {
            "X-Api-Key": '5ad6ff10bc5c4cb4866eaa2defc0067d',
          },
        )
    );
  }
  static  Future<Response> getData({
    required String endPoint,
    required Map<String, dynamic> query})async{
    return await dio.get(endPoint,queryParameters:query );
  }
}
