import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/utils/formart.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/network/request/create_cpnlot_request.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_bloc.dart';
import 'package:sw_app_gtel/srceen/receive_bill/add_info_customer_srceen.dart';

class ReceiveBillDetailsScreen extends StatefulWidget {
  int routeID;
  int requestId;
  ReceiveBillDetailsScreen({required this.routeID, required this.requestId});

  @override
  State<ReceiveBillDetailsScreen> createState() =>
      _ReceiveBillDetailsScreenState();
}

class _ReceiveBillDetailsScreenState extends State<ReceiveBillDetailsScreen> {
  int documentCount = 0;
  int parcelCount = 0;

  TextEditingController lengthUnitController = TextEditingController();
  TextEditingController widththUnitController = TextEditingController();
  TextEditingController heighthUnitController = TextEditingController();
  TextEditingController weighthUnitController = TextEditingController();
  TextEditingController moneyUnitController = TextEditingController();

  HandOverBloc handOverBloc = HandOverBloc();
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();

  List<XFile> images = [];
  List<String> lstImage = [];

  final ImagePicker picker = ImagePicker();
  Directory? dir;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RouteDetailBloc>(
            create: (context) => routeDetailBloc
              ..add(GetRequsetCPNEvent(requestID: widget.requestId)),
          ),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<RouteDetailBloc, DetailsRouteState>(
                  listener: (context, state) {
                if (state.loading.isLoading) {
                  showLoading(context);
                } else if (state.loading.isLoadSuccess) {
                  //hideLoading(context);
                }
                routeDetailBloc.getPackageItemsDoc(state.requsetCPN).then(
                  (value) {
                    documentCount = value;
                  },
                );
                routeDetailBloc.getPackageItemsParcel(state.requsetCPN).then(
                  (value) {
                    parcelCount = value;
                  },
                );
              }),
            ],
            child: BlocBuilder<RouteDetailBloc, DetailsRouteState>(
                builder: (BuildContext context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFFb3e0ff),
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black)),
                  title: Text('Cập nhật vận đơn theo lô',
                      style: TextStyle(color: Colors.black)),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thông tin người gửi *",
                            style: TextStylesUtils.style16Blod),
                        Container(
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsUtils.fillInput,
                                  ),
                                  child: Icon(Icons.location_on,
                                      color: Colors.cyan)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${state.requsetCPN.requestProviderInfo?.memberInfo?.name} | ${state.requsetCPN.requestProviderInfo?.memberInfo?.phone}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${state.requsetCPN.requestProviderInfo?.memberInfo?.address}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AddInfoCustomerSrceen();
                                      },
                                    );
                                  },
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey))
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Thông tin bưu phẩm tiếp nhận",
                            style: TextStylesUtils.style16Blod),
                        SizedBox(height: 5),
                        _buildCounter("Số lượng tài liệu",
                            Icons.mail_outline_outlined, documentCount, () {
                          setState(() => documentCount++);
                        }, () {
                          if (documentCount > 0)
                            setState(() => documentCount--);
                        }),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        _buildCounter("Số lượng bưu kiện", Icons.cases_outlined,
                            parcelCount, () {
                          setState(() => parcelCount++);
                        }, () {
                          if (parcelCount > 0) setState(() => parcelCount--);
                        }),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Kích thước (cm)",
                                style: TextStylesUtils.style14FnormalGrey),
                            Spacer(),
                            _buildSmallTextField(
                                state.requsetCPN.rlength.toString(),
                                lengthUnitController),
                            Text(" x "),
                            _buildSmallTextField(
                                state.requsetCPN.rwidth.toString(),
                                widththUnitController),
                            Text(" x "),
                            _buildSmallTextField(
                                state.requsetCPN.rheight.toString(),
                                heighthUnitController),
                          ],
                        ),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Trọng lượng (kg)",
                                style: TextStylesUtils.style14FnormalGrey),
                            Spacer(),
                            _buildSmallTextField(
                                state.requsetCPN.rweight.toString(),
                                weighthUnitController),
                          ],
                        ),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Tổng giá trị (vnđ)",
                                style: TextStylesUtils.style14FnormalGrey),
                            Spacer(),
                            _buildSmallTextField("0", moneyUnitController),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Hình ành tiếp nhận",
                            style: TextStylesUtils.style14FnormalGrey),
                        SizedBox(height: 7),
                        Container(
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                              itemCount: state.requsetCPN.urlPictures.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        state.requsetCPN.urlPictures[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 200,
                                            color: Colors.grey[300],
                                            child: Center(
                                              child: Icon(Icons.broken_image,
                                                  size: 50, color: Colors.grey),
                                            ),
                                          );
                                        },
                                      )),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        GridView.builder(
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
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(images[index].path),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => removeImage(index),
                                      child: Icon(Icons.cancel,
                                          color: Colors.red, size: 18),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return GestureDetector(
                                onTap: pickImage,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DefaultButton(
                            padding: EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(15.0),
                            borderColor: ColorsUtils.disableButon,
                            backgroundColor: Colors.white,
                            text: 'Quay lại',
                            textStyle: TextStylesUtils.style14FnormalGrey,
                            press: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: DefaultButton(
                          padding: EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(15.0),
                          borderColor: ColorsUtils.bgWareHouse,
                          backgroundColor: ColorsUtils.bgWareHouse,
                          text: 'Lưu lại',
                          textStyle: TextStylesUtils.style14Fnormalwhite,
                          press: () {
                            showLoading(context);
                            CreateCpnLotRequest? createCpnLotRequest;
                            List<RequestPackageItem> requestPackageItems = [];
                            List<String> urlPictures = [];

                            if (documentCount > 0) {
                              requestPackageItems.add(RequestPackageItem(
                                  name: 'Tài liệu', quantity: documentCount));
                            }
                            if (parcelCount > 0) {
                              requestPackageItems.add(RequestPackageItem(
                                  name: 'Bưu kiện', quantity: parcelCount));
                            }

                            if (state.requsetCPN.urlPictures.length > 0) {
                              urlPictures.addAll(state.requsetCPN.urlPictures);
                            }
                            if (lstImage.length > 0) {
                              urlPictures.addAll(lstImage);
                            }

                            createCpnLotRequest = CreateCpnLotRequest(
                              rlength: lengthUnitController.text == ""
                                  ? state.requsetCPN.rlength!
                                  : int.parse(lengthUnitController.text),
                              rwidth: widththUnitController.text == ""
                                  ? state.requsetCPN.rwidth!
                                  : int.parse(widththUnitController.text),
                              rheight: heighthUnitController.text == ""
                                  ? state.requsetCPN.rheight!
                                  : int.parse(heighthUnitController.text),
                              rweight: weighthUnitController.text == ""
                                  ? state.requsetCPN.rweight!
                                  : int.parse(weighthUnitController.text),
                              requestPackageItems: requestPackageItems,
                              urlPictures: urlPictures,
                              note: "",
                            );

                            routeDetailBloc
                                .onCreateCPNLot(
                                    widget.requestId, createCpnLotRequest)
                                .then(
                              (value) {
                                if (value == true) {
                                  hideLoading(context);
                                  Navigator.pop(context, true);
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  Widget _buildCounter(String label, IconData icon, value,
      void Function() onAdd, void Function() onRemove) {
    //print("Doc ${quantity} - Parcel ${quantity}");
    // value = quantity;
    return Row(
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStylesUtils.style14FnormalGrey,
          ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: onRemove,
            ),
            Text("${value.toString()}"),
            SizedBox(
              width: 5,
            ),
            Icon(icon, size: 14),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: onAdd,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSmallTextField(
      String initialValue, TextEditingController controller) {
    return Expanded(
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyInputFormatter(),
        ],
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(),
        canRequestFocus: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: initialValue,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsUtils.textColorGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsUtils.textColorGrey),
          ),
        ),
      ),
    );
  }

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
}
