import 'package:sw_app_gtel/common/core/base/state/base_state.dart';

class SplashState extends BaseState {
  final bool isExDate;

  SplashState({required this.isExDate});
  factory SplashState.initial() {
    return SplashState(
      isExDate: false,
    );
  }

  SplashState copyWith({
    bool? isExDate,
  }) {
    return SplashState(isExDate: isExDate ?? this.isExDate);
  }

  @override
  List<Object?> get props => [isExDate];
}
