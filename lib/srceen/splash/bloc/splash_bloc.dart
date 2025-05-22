import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/network/repository/login_repository.dart';
import 'package:sw_app_gtel/srceen/splash/bloc/splash_event.dart';
import 'package:sw_app_gtel/srceen/splash/bloc/splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(state: SplashState.initial()) {
    on<SplashEvent>(_onChecklogin);
  }

  Future _onChecklogin(SplashEvent event, Emitter<SplashState> emit) async {
    String token = SpUtil.getString("token");
    String refreshToken = SpUtil.getString("refreshToken");
    if (token != "") {
      bool hasExpired = Jwt.isExpired(token);
      if (hasExpired) {
        LoginRepository loginRepository = LoginRepository();
        bool isRefresh = await loginRepository.refreshToken(refreshToken);
        if (isRefresh) {
          emit.call(state.copyWith(isExDate: true));
        } else {
          emit.call(state.copyWith(isExDate: false));
        }
      } else {
        emit.call(state.copyWith(isExDate: true));
      }
    } else {
      emit.call(state.copyWith(isExDate: false));
    }
  }
}
