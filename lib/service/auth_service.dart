import 'package:flutnews/core/config/service_locater.dart';
import 'package:flutnews/core/constants/constants.dart';
import 'package:flutnews/model/user/handle_model.dart';
import 'package:flutnews/model/user/user_model.dart';
import 'package:flutnews/service/core_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService extends CoreSerivce {
  Future<ResultUserModel> logIn(UserModel user);
}

class AuthServiceImp extends AuthService {
  @override
  Future<ResultUserModel> logIn(UserModel user) async {
    try {
      response = await dio.post(baseurlAuth, data: user.toMap());
      if (response.statusCode == 200) {
        core
            .get<SharedPreferences>()
            .setString("token", response.data['token']);
        return DataSuccess();
      } else {
        return ErrorData();
      }
    } catch (e) {
      return ErrorData();
    }
  }
}
