import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';

// ignore: must_be_immutable
class LoginState extends BaseState {
  Loading loading;
  String editTextController;
  LoginState({required this.loading, required this.editTextController});
  factory LoginState.initial() {
    return LoginState(loading: Loading.initial(), editTextController: "");
  }
  LoginState copyWith({
    Loading? loading,
    String? editTextController,
  }) {
    return LoginState(
        loading: loading ?? this.loading,
        editTextController: editTextController ?? this.editTextController);
  }

  @override
  List<Object?> get props => [loading, editTextController];
}
