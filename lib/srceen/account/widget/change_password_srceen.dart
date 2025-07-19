import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  void _toggleObscure(String field) {
    setState(() {
      switch (field) {
        case 'old':
          _obscureOld = !_obscureOld;
          break;
        case 'new':
          _obscureNew = !_obscureNew;
          break;
        case 'confirm':
          _obscureConfirm = !_obscureConfirm;
          break;
      }
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đổi mật khẩu thành công')),
      );
    }
  }

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
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  _buildPasswordField(
                    label: "Mật khẩu cũ",
                    controller: _oldPasswordController,
                    obscure: _obscureOld,
                    toggle: () => _toggleObscure('old'),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    label: "Mật khẩu mới",
                    controller: _newPasswordController,
                    obscure: _obscureNew,
                    toggle: () => _toggleObscure('new'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập mật khẩu mới";
                      }
                      if (value.length < 6) {
                        return "Mật khẩu phải có ít nhất 6 ký tự";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    label: "Nhập lại mật khẩu mới",
                    controller: _confirmPasswordController,
                    obscure: _obscureConfirm,
                    toggle: () => _toggleObscure('confirm'),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return "Mật khẩu nhập lại không khớp";
                      }
                      return null;
                    },
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
                              if (_oldPasswordController.text == "" ||
                                  _newPasswordController.text == "" ||
                                  _confirmPasswordController.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Vui lòng nhập đầy đủ thông tin!",
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
                                return;
                              }
                              accountBloc.add(ChangePassWordEvent(
                                  oldPassword: _oldPasswordController.text,
                                  newPassword: _newPasswordController.text,
                                  renewPassword:
                                      _confirmPasswordController.text));
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

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: ColorsUtils.brownGrey,
            width: 1,
          ),
        ),
        labelText: label,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(4)),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Không được để trống";
            }
            return null;
          },
    );
  }
}
