import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/default_input.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/network/responses/sub_account_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_bloc.dart';

class DialogConfirrmHandover extends StatefulWidget {
  SubAccountReponse subAccountReponse;
  int routeID;
  DialogConfirrmHandover(
      {required this.subAccountReponse, required this.routeID});

  @override
  State<DialogConfirrmHandover> createState() => _DialogConfirrmHandoverState();
}

class _DialogConfirrmHandoverState extends State<DialogConfirrmHandover> {
  MemberInfoLogin user =
      MemberInfoLogin.fromJson(SpUtil.getObject("member_info"));

  TextEditingController noteController = TextEditingController();
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();
  HandOverBloc handOverBloc = HandOverBloc();

  String? selectedPostOffice;
  String? _selectedValue;
  bool confirmChecked = false;
  List<XFile> images = [];
  List<String> lstImage = [];

  final ImagePicker picker = ImagePicker();
  Directory? dir;

  Future<void> pickImage() async {
    dir = await getTemporaryDirectory();
    if (images.length >= 5) return;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Chụp ảnh'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      showLoading(context);
                      File imageFile = File(pickedFile.path);
                      handOverBloc
                          .onUploadImage(widget.routeID, imageFile, false, dir!)
                          .then(
                        (value) {
                          hideLoading(context);
                          lstImage.add(value!.data!.imageUrl!);
                        },
                      );
                      images.add(pickedFile);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Chọn từ thư viện'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? gallery =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (gallery != null) {
                    setState(() {
                      showLoading(context);
                      File imageFile = File(gallery.path);
                      handOverBloc
                          .onUploadImage(widget.routeID, imageFile, false, dir!)
                          .then(
                        (value) {
                          hideLoading(context);
                          lstImage.add(value!.data!.imageUrl!);
                        },
                      );
                      images.add(gallery);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  void handleSubmit() {
    if (_selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Vui lòng chọn người nhận bàn giao."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Navigator.of(context).pop(); // đóng dialog

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Đã xác nhận bàn giao thành công!"),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Bàn giao nội bộ",
                style: TextStylesUtils.style16Blod,
              ),
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                user.contactName!,
                style: TextStylesUtils.style16Fnormalblack,
              ),
            ),
            SizedBox(height: 7),
            DropdownButtonFormField<String>(
              value: _selectedValue,
              decoration: InputDecoration(
                labelText: 'Chọn người nhận bàn giao',
                border: OutlineInputBorder(),
              ),
              items: widget.subAccountReponse.data!.map((item) {
                return DropdownMenuItem<String>(
                  value: item.memberId.toString(), // 👈 dùng id để làm giá trị
                  child: Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      item.name!,
                      style: TextStylesUtils.style14FnormalBlack,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              validator: (value) => value == null ? 'Vui lòng chọn mục' : null,
            ),
            SizedBox(height: 10),
            DefaultInput(
              hintText: "Ghi chú bàn giao",
              textEditingController: noteController,
              keyboardType: TextInputType.text,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              style: TextStylesUtils.style14FnormalBlack,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Hình ảnh bàn giao"),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              itemCount: images.length < 5 ? images.length + 1 : 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                if (index < images.length) {
                  return Stack(
                    children: [
                      Image.file(
                        File(images[index].path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: GestureDetector(
                      //     onTap: () => removeImage(index),
                      //     child:
                      //         Icon(Icons.cancel, color: Colors.red, size: 18),
                      //   ),
                      // ),
                    ],
                  );
                } else {
                  return GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DefaultButton(
                      padding: EdgeInsets.only(top: 13, right: 10, left: 10),
                      borderRadius: BorderRadius.circular(10.0),
                      borderColor: ColorsUtils.disableButon,
                      backgroundColor: Colors.white,
                      textColor: Colors.white,
                      text: 'Quay về',
                      textStyle: TextStylesUtils.style16FnormalGrey,
                      press: () {
                        Navigator.pop(context);
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: DefaultButton(
                      padding: EdgeInsets.only(top: 13, right: 10, left: 10),
                      borderRadius: BorderRadius.circular(10.0),
                      borderColor: ColorsUtils.handover,
                      backgroundColor: ColorsUtils.handover,
                      text: 'Xác nhận',
                      textStyle: TextStylesUtils.style16WhiteNormal,
                      press: () {
                        handleSubmit();
                        routeDetailBloc.onRoutingComplete(0).then(
                          (value) {
                            // Navigator.pop(context, true);
                            print("Trung ${lstImage.length}");
                          },
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
