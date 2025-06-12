import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/common/widget/login_repository.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/login/bloc/login_event.dart';
import 'package:sw_app_gtel/srceen/login/bloc/login_state.dart';

class LoginBloc extends BaseBloc<BaseLoginEvent, LoginState> {
  LoginBloc() : super(state: LoginState.initial()) {
    on<LoginEvent>(_onLogin);
    on<CleanControllerEvent>(_onCleanTextController);
  }

  Future _onLogin(LoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit.call(
          state.copyWith(loading: state.loading.copyWith(isLoading: true)));
      LoginRepository loginRepository = LoginRepository();
      LoginReponse reponse =
          await loginRepository.login(event.phone, event.passWord);
      if (reponse != "") {
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, isLoadSuccess: true)));

        return reponse;
      } else {
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, loadError: true)));
      }
    } catch (e) {
      emit.call(state.copyWith(
          loading: state.loading.copyWith(isLoading: false, loadError: true)));
      print("LOI: $e");
    }
  }

  void _onCleanTextController(
      CleanControllerEvent event, Emitter<LoginState> emit) {
    emit.call(state.copyWith(loading: Loading.initial()));
    emit.call(state.copyWith(editTextController: event.editTextController));
  }
}
