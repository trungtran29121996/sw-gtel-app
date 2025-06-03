import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/section_title.dart';

class ListOrderDetialsScreen extends StatefulWidget {
  RouteRequestList routeItem;
  int requestType;

  ListOrderDetialsScreen({required this.routeItem, required this.requestType});

  @override
  State<ListOrderDetialsScreen> createState() => _ListOrderDetialsScreenState();
}

class _ListOrderDetialsScreenState extends State<ListOrderDetialsScreen> {
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();
  TextEditingController reasonController = TextEditingController();
  bool _isVisible = false;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe6f4ff),
      appBar: AppBar(
        backgroundColor: Color(0xFFb3e0ff),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text('Chi tiết đơn ${widget.routeItem.requestId}',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              deliveryCard()
            ],
          ),
        ),
      ),
    );
  }

  Widget deliveryCard() {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.qr_code_scanner_sharp),
                SizedBox(
                  width: 5,
                ),
                Text(widget.routeItem.requestInfo!.orderCodeOfClient!,
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
                widget.requestType == 1
                    ? Image.asset("assets/images/upload.png")
                    : Image.asset("assets/images/download.png")
              ],
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            // Sender
            SectionTitle(
              icon: Icons.send,
              title: 'Thông tin người giao',
              isBlue: true,
            ),
            SizedBox(
              height: 7,
            ),
            ContactInfo(
              name: widget.routeItem.requestInfo!.senderName!,
              phone: widget.routeItem.requestInfo!.senderPhone!,
              address: widget.routeItem.requestInfo!.pickupAddress!,
              date: formatDay(DateTime.fromMillisecondsSinceEpoch(
                  widget.routeItem.requestInfo!.pickupTime!)),
              isRed: true,
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            GestureDetector(
              onTap: _toggleVisibility,
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye,
                      color: ColorsUtils.textNamegreyItem),
                  SizedBox(width: 8),
                  Text(
                    'Hiển thị thông tin người nhận',
                    style: TextStyle(
                      color: ColorsUtils.textNamegreyItem,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (_isVisible)
              Column(
                children: [
                  SectionTitle(
                      icon: Icons.location_on, title: 'Thông tin người nhận'),
                  SizedBox(
                    height: 7,
                  ),
                  ContactInfo(
                    name: widget.routeItem.requestInfo!.receiverName!,
                    phone: widget.routeItem.requestInfo!.receiverPhone!,
                    address: widget.routeItem.requestInfo!.dropAddress!,
                    date: widget.routeItem.requestInfo!.pickupTimePreferred!,
                    isRed: false,
                  ),
                ],
              ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(children: [
                  Image.asset("assets/images/letter.png"),
                  SizedBox(width: 4),
                  widget.routeItem.requestInfo!.requestPackageItems!.isNotEmpty
                      ? Text(widget
                          .routeItem.requestInfo!.requestPackageItems![0].name!)
                      : SizedBox()
                ]),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.routeItem.requestInfo!.basePackagingInfo!.packageName!}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'COD',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                    '📦 ${widget.routeItem.requestInfo!.rlength} x ${widget.routeItem.requestInfo!.rheight} x ${widget.routeItem.requestInfo!.rwidth}'),
                SizedBox(width: 10),
                Text('⚖ ${widget.routeItem.requestInfo!.rweight}'),
              ],
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Text('📅 Thanh toán cuối tháng',
                    style: TextStyle(color: Colors.grey[700])),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ColorsUtils.statusContact,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorsUtils.statusContact),
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
                    border: Border.all(color: ColorsUtils.statusContact),
                  ),
                  child: Text('KG'),
                ),
              ],
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
                      borderColor: Colors.red,
                      backgroundColor: Colors.white,
                      //width: getDeviceWidth(context) * 0.8,
                      text: 'Không thành công',
                      textStyle: TextStylesUtils.style14FnormalRed,
                      press: () {
                        showBottomSheet();
                      }),
                ),
                // Expanded(
                //   flex: 1,
                //   child: DefaultButton(
                //     padding: EdgeInsets.all(5),
                //     borderRadius: BorderRadius.circular(15.0),
                //     borderColor: ColorsUtils.bgHome,
                //     backgroundColor: Colors.white,
                //     //width: getDeviceWidth(context) * 0.8,
                //     text: 'Hoàn thành',
                //     textStyle: TextStylesUtils.style16FnormalBlue,
                //     press: () {},
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: 7,
                  right: 7,
                  left: 7,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Lý do không lấy được hàng',
                      style: TextStylesUtils.style16Blod,
                    ),
                  ),
                  Divider(
                    color: ColorsUtils.boderGray,
                  ),
                  _buildItemReason(Icons.schedule, 'Khách hẹn lại'),
                  Divider(
                    color: ColorsUtils.boderGray,
                  ),
                  _buildItemReason(Icons.location_off, 'Sai địa chỉ'),
                  Divider(
                    color: ColorsUtils.boderGray,
                  ),
                  _buildItemReason(Icons.cancel, 'Khách hủy đơn'),
                  Divider(
                    color: ColorsUtils.boderGray,
                  ),
                  CupertinoListTile(
                    leading:
                        Icon(Icons.edit_note, color: ColorsUtils.iconReason),
                    title: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: InputTextField(
                        fillColor: Colors.white,
                        label: "Lý do khác",
                        controller: reasonController,
                        filled: true,
                        enabled: false,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                      borderRadius: BorderRadius.circular(15.0),
                      borderColor: Colors.red,
                      backgroundColor: Colors.white,
                      //width: getDeviceWidth(context) * 0.8,
                      text: 'Đồng ý',
                      textStyle: TextStylesUtils.style14FnormalRed,
                      press: () {
                        routeDetailBloc
                            .getSeqStpoppoint(
                                widget.routeItem.requestInfo!.sequenceList)
                            .then(
                          (value) {
                            showLoading(context);
                            routeDetailBloc
                                .onUpdatetStatus(
                                    value,
                                    101,
                                    SpUtil.getInt("driverId"),
                                    "Giao/lấy không thành công")
                                .then(
                              (value) {
                                hideLoading(context);
                                Navigator.pop(context, true);
                              },
                            );
                          },
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildItemReason(IconData icon, String textStatus) {
    return CupertinoListTile(
      leading: Icon(
        icon,
        color: ColorsUtils.iconReason,
      ),
      title: Text(
        textStatus,
        style: TextStylesUtils.style14FnormalBlack,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
