import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/change_password.dart';

class AccountState extends BaseState {
  Loading loading;
  bool isLogout;
  ChangePassWordReponse changePassWordReponse;
  AccountState(
      {required this.isLogout,
      required this.changePassWordReponse,
      required this.loading});
  factory AccountState.initial() {
    return AccountState(
      isLogout: false,
      changePassWordReponse: ChangePassWordReponse(),
      loading: Loading.initial(),
    );
  }
  AccountState copyWith(
      {bool? isLogout,
      ChangePassWordReponse? changePassWordReponse,
      Loading? loading}) {
    return AccountState(
        isLogout: isLogout ?? this.isLogout,
        changePassWordReponse:
            changePassWordReponse ?? this.changePassWordReponse,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [isLogout, changePassWordReponse, loading];
}
