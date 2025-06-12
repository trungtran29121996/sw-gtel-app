import 'package:sw_app_gtel/common/core/base/state/base_state.dart';

class AccountState extends BaseState {
  final bool isLogout;
  AccountState({required this.isLogout});
  factory AccountState.initial() {
    return AccountState(isLogout: false);
  }
  AccountState copyWith({
    bool? isLogout,
  }) {
    return AccountState(isLogout: isLogout ?? this.isLogout);
  }

  @override
  List<Object?> get props => [isLogout];
}
