import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';

class NoficationScreen extends StatefulWidget {
  const NoficationScreen({super.key});

  @override
  State<NoficationScreen> createState() => _NoficationScreenState();
}

class _NoficationScreenState extends State<NoficationScreen> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFe6f4ff),
        appBar: AppBar(
          backgroundColor: Color(0xFFb3e0ff),
          title: Text('Thông báo', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                shrinkWrap: true,
                controller: controller,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorsUtils.bgHome),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.qr_code_scanner_sharp,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("BN_GTELHCMQ1_A1409T7",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                            SizedBox(
                              width: 1,
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ColorsUtils.bgHomeMenu,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: ColorsUtils.bgHomeMenu),
                              ),
                              child: Text('CPN'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ColorsUtils.statusContact,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorsUtils.statusContact),
                              ),
                              child: Text('Hẹn lại lần 1'),
                            ),
                          ],
                        ),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        ContactInfo(
                          name: "Trần Phú Trung",
                          address:
                              "353 Đ. Tân Sơn Nhì, P.Tân Sơn Nhì, Q.Tân Phú",
                          date: "29/12/1996 08:00 AM",
                          isRed: false,
                        ),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        Row(
                          children: [
                            Row(children: [
                              Image.asset(
                                "assets/images/letter.png",
                                color: ColorsUtils.bgWareHouse,
                              ),
                              SizedBox(width: 4),
                              Text("4 kiện + 1 thư")
                            ]),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Tài liệu',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Thông thường',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text('📦 30 x 10 x 20 cm'),
                              SizedBox(width: 10),
                              Text('⚖ 1kg'),
                            ],
                          ),
                        ),
                        Divider(
                          color: ColorsUtils.boderGray,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DefaultButton(
                                  padding: EdgeInsets.all(5),
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderColor: ColorsUtils.disableButon,
                                  backgroundColor: Colors.white,
                                  //width: getDeviceWidth(context) * 0.8,
                                  text: 'Từ chối',
                                  textStyle: TextStylesUtils.style14FnormalGrey,
                                  press: () {}),
                            ),
                            Expanded(
                              flex: 1,
                              child: DefaultButton(
                                padding: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(15.0),
                                borderColor: ColorsUtils.bgWareHouse,
                                backgroundColor: ColorsUtils.bgWareHouse,
                                text: 'Tiếp nhận',
                                textStyle: TextStylesUtils.style14Fnormalwhite,
                                press: () {},
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })));
  }
}
