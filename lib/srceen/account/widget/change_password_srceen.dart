import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';

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

  bool oldObscureText = true;
  bool newObscureText = true;
  bool renewObscureText = true;

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
      body: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            buildEditextField(
                oldController, "Mật khẩu hiện tại", oldObscureText),
            SizedBox(
              height: 7,
            ),
            buildEditextField(newController, "Mật khẩu mới", newObscureText),
            SizedBox(
              height: 7,
            ),
            buildEditextField(
                newController, "Nhập lại mật khẩu mới", renewObscureText),
            SizedBox(
              height: 7,
            ),
            Spacer(),
            DefaultButton(
                padding: EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(15.0),
                borderColor: ColorsUtils.bgHome,
                backgroundColor: ColorsUtils.bgHome,
                text: 'Cập nhật',
                textStyle: TextStylesUtils.style14Fnormalwhite,
                press: () {})
          ],
        ),
      ),
      // bottomNavigationBar: DefaultButton(
      //     padding: EdgeInsets.all(5),
      //     borderRadius: BorderRadius.circular(15.0),
      //     borderColor: ColorsUtils.bgHome,
      //     backgroundColor: ColorsUtils.bgHome,
      //     text: 'Cập nhật',
      //     textStyle: TextStylesUtils.style14Fnormalwhite,
      //     press: () {}),
    );
  }

  Widget buildEditextField(
      TextEditingController controller, String label, bool obscureText) {
    return InputTextField(
      label: label,
      fillColor: Colors.white,
      obscureText: obscureText,
      controller: controller,
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
}
