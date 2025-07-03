import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/common/widget/keyboard_dismiss.dart';
import 'package:sw_app_gtel/navigation/route.dart';
import 'package:sw_app_gtel/srceen/login/bloc/login_bloc.dart';
import 'package:sw_app_gtel/srceen/login/bloc/login_event.dart';
import 'package:sw_app_gtel/srceen/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;
  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          body: KeyboardDismiss(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                    left: AppDimensions.paddingXXLarge,
                    top: getDeviceHeight(context) * 0.12,
                    right: AppDimensions.paddingXXLarge,
                  ),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Welcome!",
                        style: TextStylesUtils.styleLight30Black,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: buildImageBottom(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 70,
                        ),
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildPhoneField(),
                                const SizedBox(
                                    height: AppDimensions.paddingXXLarge),
                                buildPasswordField(),
                                SizedBox(height: AppDimensions.paddingXXLarge),
                                BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state.loading.isLoading) {
                                      showLoading(context);
                                    } else if (state.loading.isLoadSuccess) {
                                      hideLoading(context);
                                      // NotificationService notificationService =
                                      //     NotificationService();
                                      // notificationService
                                      //     .connectSocket(context);
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.NAVIGATION_BAR,
                                          (route) => false);
                                    } else if (state.loading.loadError) {
                                      hideLoading(context);
                                      showAppDialog(
                                          context: context,
                                          suffixIcon: Icon(
                                            Icons.warning_amber_outlined,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                          title: "Thông báo",
                                          message:
                                              "${"Tài khoản của bạn không đúng"}\n${"Vui lòng thử lại"}");
                                    }
                                  },
                                  builder: (context, state) {
                                    return buildButtonLogin(context);
                                  },
                                ),
                              ],
                            )),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }

  Widget buildPhoneField() {
    return InputTextField(
      fillColor: Colors.white,
      label: "Số điện thoại",
      keyboardType: TextInputType.number,
      controller: usernameController,
      filled: true,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Widget buildPasswordField() {
    return InputTextField(
      label: "Mật khẩu",
      fillColor: Colors.white,
      obscureText: obscureText,
      controller: passwordController,
      filled: true,

      suffixIcon: InkWell(
        child: obscureText
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.visibility_off),
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
      onChanged: (value) {},
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        // return Validator.minLenght(context, value);
      },
    );
  }

  Widget buildButtonLogin(BuildContext context) {
    return Container(
      child: DefaultButton(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        borderRadius: BorderRadius.circular(15.0),
        borderColor: ColorsUtils.bgWareHouse,
        backgroundColor: ColorsUtils.bgWareHouse,
        text: "Đăng nhập",
        press: () {
          context.read<LoginBloc>().add(LoginEvent(
              phone: convertPhoneNumber(usernameController.text),
              passWord: passwordController.text));
        },
      ),
    );
  }

  Widget buildImageBottom() => SizedBox(
        width: double.infinity,
        height: 0.25.sh,
        child: Image.asset("assets/images/bg_login.png", fit: BoxFit.fill),
      );

  String convertPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+84' + phoneNumber.substring(1);
    }
    return phoneNumber;
  }
}
