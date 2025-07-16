import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/default_input.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_bloc.dart';

class DialogConfirm extends StatefulWidget {
  String label;
  SequenceList seq;

  DialogConfirm({required this.label, required this.seq});

  @override
  State<DialogConfirm> createState() => _DialogConfirmState();
}

class _DialogConfirmState extends State<DialogConfirm> {
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();
  HandOverBloc handOverBloc = HandOverBloc();

  TextEditingController noteController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  Directory? dir;
  List<XFile> images = [];
  List<String> lstImage = [];

  Future<void> pickImage() async {
    dir = await getTemporaryDirectory();
    if (images.length >= 5) return;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
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
                        .onUploadImage(
                            widget.seq.routeId!, imageFile, false, dir!)
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
                        .onUploadImage(
                            widget.seq.routeId!, imageFile, false, dir!)
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
        );
      },
    );
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: TextStylesUtils.style16Blod,
              ),
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Hình ảnh giao/nhận"),
            ),
            SizedBox(height: 10),
            SizedBox(
              child: GridView.builder(
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
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Ghi chú"),
            ),
            SizedBox(
              height: 7,
            ),
            DefaultInput(
              hintText: "Ghi chú giao/nhận",
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
          ]),
        ),
        bottomNavigationBar: Row(
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
                    showLoading(context);
                    routeDetailBloc
                        .onUpdatetStatus(widget.seq.seqId!, 200,
                            SpUtil.getInt("driverId"), "Lấy hàng", lstImage)
                        .then(
                      (value) {
                        if (value.success == false) {
                          showAppDialog(
                                  barrierDismissible: false,
                                  isHiddenCancel: true,
                                  context: context,
                                  suffixIcon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                  message: "${value.message}",
                                  title: 'Thông báo')
                              .then(
                            (value) {
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          hideLoading(context);
                          Navigator.pop(context);
                        }

                        // context.read<RouteDetailBloc>().add(
                        //     GetRouteByIDEvent(routeId: widget.seq.routeId!));
                      },
                    );
                  }),
            ),
          ],
        ));
  }
}
