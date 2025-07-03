import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';

class WidgetInfoAccount extends StatefulWidget {
  MemberInfoLogin user;
  WidgetInfoAccount({required this.user});

  @override
  State<WidgetInfoAccount> createState() => _WidgetInfoAccountState();
}

class _WidgetInfoAccountState extends State<WidgetInfoAccount> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: "${widget.user.name}");
    TextEditingController phoneController =
        TextEditingController(text: "${widget.user.phone}");
    TextEditingController emailController =
        TextEditingController(text: "${widget.user.email}");
    return Scaffold(
      backgroundColor: Color(0xFF8CD3FF), // Nền xanh trên
      appBar: AppBar(
        backgroundColor: Color(0xFF8CD3FF),
        elevation: 0,
        title: Text('Thông tin cá nhân',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Họ và tên"),
            _buildReadOnlyField(controller: nameController),
            SizedBox(height: 16),
            _buildLabel("Số điện thoại"),
            _buildReadOnlyField(controller: phoneController),
            SizedBox(height: 16),
            _buildLabel("Email"),
            _buildReadOnlyField(controller: emailController),
            //Spacer(),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {

            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF00B9F1), // Màu nút xanh
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       padding: EdgeInsets.symmetric(vertical: 14),
            //     ),
            //     child: Text('Cập nhật', style: TextStyle(fontSize: 16)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget itemInfo(String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStylesUtils.style16Blod,
          ),
          Text(
            description,
            style: TextStylesUtils.style16Gray,
          )
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  Widget _buildReadOnlyField({required TextEditingController controller}) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        children: [
          TextField(
            controller: controller,
            readOnly: true,
            style: TextStyle(color: Colors.grey[600]),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          Divider(
            color: ColorsUtils.boderGray,
          ),
        ],
      ),
    );
  }
}
