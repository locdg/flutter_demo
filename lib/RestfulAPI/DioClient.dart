import 'package:dio/dio.dart';
import 'package:user_interface/RestfulAPI/DioDemo.dart';

class MyURL {
  static const baseURL = 'https://reqres.in/api';
}

class Api {
  static final instance = Api.createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: MyURL.baseURL,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(),
    });
    return dio;
  }
}

class MyServices {
  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await Api.instance.get('/users/$id');
      dLog('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      dLog('Error: ${e.message}');
    }
    return user;
  }

  Future<UserInfo?> createUser({required UserInfo userInfo}) async {
    UserInfo? retrievedUser;

    try {
      Response response = await Api.instance.post(
        '/users',
        data: userInfo.toJson(),
      );
      retrievedUser = UserInfo.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }
    return retrievedUser;
  }
}

void dLog(String doc) {
  print('dLog: $doc');
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    dLog(
        '=================================== \nRequest: ${options.method}\n -> Path: ${MyURL.baseURL}${options.path}\n -> Param: ${options.data}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dLog(
        '=================================== \nResponse code: ${response.statusCode}\nResponse message: ${response.statusMessage}\n -> Result: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    dLog(
        '=================================== \nError: ${err.requestOptions.path}\n -> Error message: ${err.message}');
    return super.onError(err, handler);
  }
}
