import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/network/repository/login_repository.dart';
import 'package:sw_app_gtel/network/responses/change_password.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_event.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_state.dart';

class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  AccountBloc() : super(state: AccountState.initial()) {
    on<LogoutEvent>(_onLogout);
    on<ChangePassWordEvent>(_onChangePassWord);
  }

  LoginRepository loginRepository = LoginRepository();

  Future _onLogout(LogoutEvent event, Emitter<AccountState> emit) async {
    try {
      await loginRepository.logout();
      emit.call(state.copyWith(isLogout: true));
    } catch (e) {
      print("LOI $e");
    }
  }

  Future _onChangePassWord(ChangePassWordEvent event, Emitter emit) async {
    try {
      ChangePassWordReponse? changePassWordReponse =
          await loginRepository.getChangePassWord(
              event.oldPassword, event.newPassword, event.renewPassword);

      if (changePassWordReponse?.success == true) {
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, isLoadSuccess: true),
            changePassWordReponse: changePassWordReponse));
      } else {
        emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true),
        ));
      }
    } catch (e) {
      print("LOI$e");
      emit.call(state.copyWith(changePassWordReponse: ChangePassWordReponse()));
    }
  }
}
