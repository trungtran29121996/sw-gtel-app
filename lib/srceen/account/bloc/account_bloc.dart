import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/common/widget/login_repository.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_event.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_state.dart';

class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  AccountBloc() : super(state: AccountState.initial()) {
    on<LogoutEvent>(_onLogout);
  }

  Future _onLogout(LogoutEvent event, Emitter<AccountState> emit) async {
    try {
      LoginRepository settingRepository = LoginRepository();
      await settingRepository.logout();
      emit.call(state.copyWith(isLogout: true));
    } catch (e) {
      print("LOI $e");
    }
  }
}
