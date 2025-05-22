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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg_sanxe.webp",
                ),
                fit: BoxFit.cover,
              ))),
              Align(
                alignment: Alignment.bottomCenter,
                child: buildImageBottom(),
              ),
              CustomScrollView(reverse: true, slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: AppDimensions.paddingXXLarge,
                        top: getDeviceHeight(context) * .2,
                        right: AppDimensions.paddingXXLarge),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //const WidgetLogoEmover(),
                          buildTextAppName(),
                          const SizedBox(height: AppDimensions.paddingXXLarge),
                          buildPhoneField(),
                          const SizedBox(height: AppDimensions.paddingXXLarge),
                          buildPasswordField(),
                          const SizedBox(height: AppDimensions.paddingXXLarge),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state.loading.isLoading) {
                                showLoading(context);
                              } else if (state.loading.isLoadSuccess) {
                                hideLoading(context);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.NAVIGATION_BAR, (route) => false);
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
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhoneField() {
    return InputTextField(
      fillColor: Colors.white,
      label: "Số điện thoại",
      keyboardType: TextInputType.number,
      controller: usernameController,
      filled: true,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      prefixIcon: Container(
          height: 10,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Icon(
            Icons.phone_android,
            color: ColorsUtils.bgWareHouse,
          )),
    );
  }

  Widget buildPasswordField() {
    return InputTextField(
      label: "Mật khẩu",
      fillColor: Colors.white,
      obscureText: obscureText,
      controller: passwordController,
      filled: true,
      prefixIcon: Container(
        child: Icon(
          Icons.lock,
          color: ColorsUtils.bgWareHouse,
        ),
      ),
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
        child:
            Image.asset("assets/images/bottom_register.webp", fit: BoxFit.fill),
      );

  Widget buildTextAppName() => Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        alignment: Alignment.topCenter,
        child: Text("GtelPost Bưu tá",
            textAlign: TextAlign.center,
            style: TextStylesUtils.styleLight30Black),
      );

  String convertPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+84' + phoneNumber.substring(1);
    }
    return phoneNumber;
  }
}
