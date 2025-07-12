import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/common/widget/keyboard_dismiss.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_bloc.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_event.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_state.dart';

class ChangePasswordSrceen extends StatefulWidget {
  MemberInfoLogin user;
  ChangePasswordSrceen({required this.user});

  @override
  State<ChangePasswordSrceen> createState() => _ChangePasswordSrceenState();
}

class _ChangePasswordSrceenState extends State<ChangePasswordSrceen> {
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController renewController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool oldObscureText = true;
  bool newObscureText = true;
  bool renewObscureText = true;

  AccountBloc accountBloc = AccountBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8CD3FF), // Nền xanh trên
      appBar: AppBar(
        backgroundColor: Color(0xFF8CD3FF),
        elevation: 0,
        title: Text('Thay đổi mật khẩu',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: KeyboardDismiss(
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  buildEditextField(oldController, "Mật khẩu hiện tại"),
                  SizedBox(
                    height: 10,
                  ),
                  buildEditextField(newController, "Mật khẩu mới"),
                  SizedBox(
                    height: 10,
                  ),
                  buildEditextField(renewController, "Nhập lại mật khẩu mới"),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  BlocProvider(
                      create: (context) => accountBloc,
                      child: BlocConsumer<AccountBloc, AccountState>(
                          listener: (context, state) {
                        if (state.loading.isLoading) {
                          showLoading(context);
                        } else if (state.loading.isLoadSuccess) {
                          hideLoading(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Cập nhật mật khẩu thành công!",
                                  style:
                                      TextStyle(color: ColorsUtils.textNoti)),
                              backgroundColor: ColorsUtils.bgSnackBarNoti,
                              duration: Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.all(3),
                            ),
                          );
                        } else {
                          hideLoading(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Cập nhật mật khẩu thất bại!",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.all(3),
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        return DefaultButton(
                            padding: EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(15.0),
                            borderColor: ColorsUtils.bgHome,
                            backgroundColor: ColorsUtils.bgHome,
                            text: 'Cập nhật',
                            textStyle: TextStylesUtils.style14Fnormalwhite,
                            press: () {
                              accountBloc.add(ChangePassWordEvent(
                                  oldPassword: oldController.text,
                                  newPassword: newController.text,
                                  renewPassword: renewController.text));
                            });
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditextField(TextEditingController controller, String label) {
    if (controller == oldController) {}
    return InputTextField(
      label: label,
      fillColor: Colors.white,
      controller: controller,
      filled: true,

      // suffixIcon: InkWell(
      //   child: oldObscureText
      //       ? const Icon(Icons.remove_red_eye)
      //       : const Icon(Icons.visibility_off),
      //   onTap: () {
      //     setState(() {
      //       oldObscureText = !oldObscureText;
      //     });
      //   },
      // ),
      onChanged: (value) {},
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        // return Validator.minLenght(context, value);
      },
    );
  }
}
