import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/utils/formart.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/srceen/receive_bill/add_info_customer_srceen.dart';

class ReceiveBillDetailsScreen extends StatefulWidget {
  const ReceiveBillDetailsScreen({super.key});

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

  List<XFile> images = [];

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
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
                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    setState(() {
                      images.add(photo);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFb3e0ff),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text('Tiếp nhận vận đơn theo lô',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Thông tin người gửi *", style: TextStylesUtils.style16Blod),
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
                        child: Icon(Icons.location_on, color: Colors.cyan)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lê Vũ Phúc | 0983692949",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            "63 Điện Biên Phủ, Phường 2, Quận Bình Thạnh, Hồ Chí Minh",
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
              _buildCounter("Số lượng tài liệu", Icons.mail_outline_outlined,
                  documentCount, () {
                setState(() => documentCount++);
              }, () {
                if (documentCount > 0) setState(() => documentCount--);
              }),
              Divider(
                color: ColorsUtils.boderGray,
              ),
              _buildCounter(
                  "Số lượng bưu kiện", Icons.cases_outlined, parcelCount, () {
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
                  _buildSmallTextField("0", lengthUnitController),
                  Text(" x "),
                  _buildSmallTextField("0", widththUnitController),
                  Text(" x "),
                  _buildSmallTextField("0", heighthUnitController),
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
                  _buildSmallTextField("0", weighthUnitController),
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
              // Row(
              //   children: List.generate(4, (index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 8),
              //       child: Container(
              //         width: 70,
              //         height: 70,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey.shade300),
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Icon(Icons.camera_alt, color: Colors.grey),
              //       ),
              //     );
              //   }),
              // ),
              SizedBox(height: 7),
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
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => removeImage(index),
                            child:
                                Icon(Icons.cancel, color: Colors.red, size: 18),
                          ),
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
                press: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, IconData icon, value,
      void Function() onAdd, void Function() onRemove) {
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
            Text(value.toString()),
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
}
