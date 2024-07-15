import 'package:bloc/bloc.dart';
import 'package:flutnews/core/config/service_locater.dart';
import 'package:flutnews/features/presentation/bloc/manager/manager_event.dart';
import 'package:flutnews/features/presentation/bloc/manager/manager_state.dart';
import 'package:flutnews/model/user/handle_model.dart';
import 'package:flutnews/model/user/user_model.dart';
import 'package:flutnews/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(NavigateToLogIn()) {
    on<CheckAuthorized>((event, emit) {
      if (core.get<SharedPreferences>().getString('token') == null ||
          core.get<SharedPreferences>().getString('token') == '') {
        emit(NavigateToLogIn());
      } else {
        emit(NavigateToHomePage());
      }
    });

    on<HeLoggedIn>((event, emit) {
      emit(NavigateToHomePage());
    });

    on<HeFailedToLoggedIn>((event, emit) => emit(NavigateToOffline()));

    on<RestoreToLogIn>((event, emit) => emit(NavigateToLogIn()));

    on<LogOut>((event, emit) {
      core.get<SharedPreferences>().setString('token', '');
      emit(NavigateToLogIn());
    });

    on<ExcuteLastRequest>((event, emit) async {
      ResultUserModel result = await AuthServiceImp().logIn(
          UserModel.fromJson(core.get<SharedPreferences>().getString('data')!));
      if (result is DataSuccess) {
        emit(NavigateToHomePage());
      } else {
        emit(NavigateToOffline());
      }
    });
  }
}
