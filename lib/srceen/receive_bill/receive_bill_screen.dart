import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';
import 'package:sw_app_gtel/srceen/receive_bill/receive_bill_details_screen.dart';

class ReceiveBillScreen extends StatefulWidget {
  const ReceiveBillScreen({super.key});

  @override
  State<ReceiveBillScreen> createState() => _ReceiveBillScreenWidgetState();
}

class _ReceiveBillScreenWidgetState extends State<ReceiveBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFe6f4ff),
        appBar: AppBar(
          backgroundColor: Color(0xFFb3e0ff),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),
          title:
              Text('Tiếp nhận vận đơn', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                                hintText:
                                    'Mã vận đơn, Tên khách, Số điện thoại, ...',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                                suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.grid_view,
                                            color: Colors.cyan),
                                        onPressed: () {
                                          // handle grid view
                                        },
                                      ),
                                    ])))),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
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
                          Icon(Icons.qr_code_scanner_sharp),
                          SizedBox(
                            width: 5,
                          ),
                          Text("GSGNE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
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
                              border: Border.all(color: ColorsUtils.bgHomeMenu),
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
                              child: Text('Hẹn lại lần 1')),
                        ],
                      ),
                      Divider(
                        color: ColorsUtils.boderGray,
                      ),
                      ContactInfo(
                        name: "Trần Phú Trung",
                        address: "353 Đ. Tân Sơn Nhì, P.Tân Sơn Nhì, Q.Tân Phú",
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
                                text: 'Xem chi tiết',
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
                ),
              ],
            )),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
              padding: EdgeInsets.only(right: 25, left: 25),
              borderRadius: BorderRadius.circular(15.0),
              borderColor: ColorsUtils.bgWareHouse,
              backgroundColor: ColorsUtils.bgWareHouse,
              text: '+ Tạo mới tiếp nhận theo lô',
              textStyle: TextStylesUtils.style14Fnormalwhite,
              press: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiveBillDetailsScreen(
                        routeID: 0,
                      ),
                    ));
              }),
        ));
  }
}
