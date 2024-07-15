import 'package:bloc/bloc.dart';
import 'package:flutnews/core/config/service_locater.dart';
import 'package:flutnews/features/presentation/bloc/auth/auth_event.dart';
import 'package:flutnews/features/presentation/bloc/auth/auth_state.dart';
import 'package:flutnews/model/user/handle_model.dart';
import 'package:flutnews/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LogIn>(
      (event, emit) async {
        core.get<SharedPreferences>().setString('data', event.user.toJson());
        ResultUserModel result = await AuthServiceImp().logIn(event.user);
        if (result is DataSuccess) {
          emit(SuccessToLogIn());
        } else {
          emit(FailedToLogIn());
        }
      },
    );
  }
}
