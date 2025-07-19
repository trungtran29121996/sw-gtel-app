import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sw_app_gtel/common/config/format.dart';
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
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_event.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_state.dart';

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
  String? selectedValue;
  int? assignee_id = 0;
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
    return BlocProvider(
        create: (context) =>
            HandOverBloc()..add(GetInfoHandOver(routeId: widget.routeID)),
        child: Builder(builder: (context) {
          return BlocConsumer<HandOverBloc, HandOverState>(
            listener: (context, state) {
              if (state.loading.isLoading) {
                showLoading(context);
              } else if (state.loading.isLoadSuccess) {
                hideLoading(context);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Container(
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
                              textInfo(
                                  state.routeHandoverReponse.data?.sourceType ??
                                      0),
                              style: TextStylesUtils.style16Blod)),
                      SizedBox(
                        height: 7,
                      ),
                      state.routeHandoverReponse.data?.sourceType == 7
                          ? _infoHandoverLot(state)
                          : _infoHandover(state),
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
                        value: selectedValue,
                        decoration: InputDecoration(
                          labelText: 'Chọn người nhận bàn giao',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.subAccountReponse.data!.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.memberId.toString(),
                            child: Text(
                              item.name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Vui lòng chọn mục' : null,
                      ),
                      SizedBox(height: 10),
                      DefaultInput(
                        hintText: "Ghi chú bàn giao",
                        textEditingController: noteController,
                        keyboardType: TextInputType.text,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorsUtils.brownGrey),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorsUtils.brownGrey),
                            borderRadius: BorderRadius.circular(10)),
                        style: TextStylesUtils.style14FnormalBlack,
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Hình ảnh bàn giao"),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: images.length < 5 ? images.length + 1 : 5,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) {
                            if (index < images.length) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.file(
                                  File(images[index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.add_a_photo_sharp,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DefaultButton(
                          padding:
                              EdgeInsets.only(top: 13, right: 10, left: 10),
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
                          padding:
                              EdgeInsets.only(top: 13, right: 10, left: 10),
                          borderRadius: BorderRadius.circular(10.0),
                          borderColor: ColorsUtils.handover,
                          backgroundColor: ColorsUtils.handover,
                          text: 'Xác nhận',
                          textStyle: TextStylesUtils.style16WhiteNormal,
                          press: () {
                            if (selectedValue == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("Vui lòng chọn người nhận bàn giao."),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              showLoading(context);
                              routeDetailBloc
                                  .onRoutingComplete(
                                      widget.routeID,
                                      noteController.text,
                                      selectedValue!,
                                      lstImage)
                                  .then(
                                (value) {
                                  hideLoading(context);
                                  Navigator.pop(context, true);
                                },
                              );
                            }
                          }),
                    ),
                  ],
                ),
              );
            },
          );
        }));
  }

  String textInfo(int type) {
    String requestType;
    if (type == 4) {
      requestType = 'Chuyến thư';
    } else if (type == 5) {
      requestType = 'Chuyến đi giao';
    } else if (type == 6) {
      requestType = 'Chuyến lấy hàng được tạo thủ công';
    } else if (type == 7) {
      requestType = 'Chuyến lô';
    } else {
      requestType = "";
    }
    return requestType;
  }

  Widget _buildStatItem(
      IconData icon, Color iconColor, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              width: 1,
            ),
            Icon(icon, color: iconColor, size: 20),
          ],
        ),
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatItemMoney(Color iconColor, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 14)),
      ],
    );
  }

  Widget _infoHandover(HandOverState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
                Icons.receipt_long,
                Colors.orange,
                "${state.routeHandoverReponse.data?.countOfRoute ?? 0}",
                'Vận đơn'),
            _buildStatItem(
                Icons.check_circle,
                Colors.green,
                "${state.routeHandoverReponse.data?.successfulRequests ?? 0}",
                'Thành công'),
            _buildStatItem(
                Icons.cancel,
                Colors.red,
                "${state.routeHandoverReponse.data?.failedRequests ?? 0}",
                'Thất bại'),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItemMoney(
                Colors.black87,
                "${formatVND(state.routeHandoverReponse.data?.totalCod)}đ",
                'Cước vận chuyển'),
            _buildStatItemMoney(
                Colors.black87,
                "${formatVND(state.routeHandoverReponse.data?.shippingFee)}đ",
                'Tiền thu hộ (COD)'),
          ],
        ),
      ],
    );
  }

  Widget _infoHandoverLot(HandOverState state) {
    return state.routeHandoverReponse.data!.packageItemSummary!.isNotEmpty
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                      Icons.receipt_long,
                      Colors.orange,
                      "${state.routeHandoverReponse.data?.countOfRoute}",
                      'Chuyến'),
                  _buildStatItem(
                      Icons.inventory_2,
                      Colors.grey[700]!,
                      "${state.routeHandoverReponse.data?.packageItemSummary?[0].quantity}",
                      "${state.routeHandoverReponse.data?.packageItemSummary?[0].name}"),
                  _buildStatItem(
                      Icons.insert_drive_file,
                      Colors.grey[700]!,
                      "${state.routeHandoverReponse.data?.packageItemSummary?[1].quantity}",
                      "${state.routeHandoverReponse.data?.packageItemSummary?[1].name}"),
                ],
              ),
            ],
          )
        : SizedBox();
  }
}
