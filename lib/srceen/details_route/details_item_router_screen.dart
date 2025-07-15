import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/network/responses/tracking_log_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/section_title.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider<RouteDetailBloc>(
            create: (context) =>
                routeDetailBloc..add(TrackingLogEvent(requestId: 1000000597)),
          )
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<RouteDetailBloc, DetailsRouteState>(
                listener: (context, state) {
                  if (state.loading.isLoading) {
                    showLoading(context);
                  } else if (state.loading.isLoadSuccess) {
                    hideLoading(context);
                  }
                },
              )
            ],
            child: BlocBuilder<RouteDetailBloc, DetailsRouteState>(
                builder: (BuildContext context, state) {
              return Scaffold(
                //backgroundColor: Color(0xFFe6f4ff),
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
                    child: deliveryCard(state),
                  ),
                ),
                bottomNavigationBar: DefaultButton(
                    padding: EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(15.0),
                    borderColor: Colors.red,
                    backgroundColor: Colors.white,
                    //width: getDeviceWidth(context) * 0.8,
                    text: 'Không thành công',
                    textStyle: TextStylesUtils.style14FnormalRed,
                    press: () {
                      showBottomSheet().then(
                        (value) {
                          Navigator.pop(context, true);
                        },
                      );
                    }),
              );
            })));
  }

  Widget deliveryCard(DetailsRouteState state) {
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
                    widget.routeItem.requestInfo!.basePackagingInfo != null
                        ? '${widget.routeItem.requestInfo!.basePackagingInfo!.packageName!}'
                        : "",
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
            Row(children: [
              Image.asset("assets/images/icon_trackinglog.png",
                  color: Colors.grey[700]),
              SizedBox(
                width: 5,
              ),
              Text(
                'Hành trình đơn hàng',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ]),

            SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.listTrackingLogReponse.length,
                  itemBuilder: (context, index) {
                    Datum trackingItem = state.listTrackingLogReponse[index];
                    return Container(
                        height: 70,
                        child: TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.3,
                          indicatorStyle: IndicatorStyle(
                              color: index == 0
                                  ? ColorsUtils.bgHome
                                  : ColorsUtils.bgHome.withOpacity(0.3),
                              iconStyle: IconStyle(
                                  iconData: Icons.check,
                                  color: Colors.white,
                                  fontSize: 20),
                              padding: EdgeInsets.only(right: 10)),
                          startChild: Text(
                            "${formatDataTime(trackingItem.createdAt!)}",
                            style: index == 0
                                ? TextStylesUtils.style14FnormalBlack
                                : TextStylesUtils.styleRegular14BrownGreyW400,
                          ),
                          isFirst: index == 0 ? true : false,
                          endChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${trackingItem.description}",
                                style: TextStylesUtils.text14w600(index == 0
                                    ? ColorsUtils.normalText
                                    : ColorsUtils.brownGrey),
                              ),
                            ],
                          ),
                          beforeLineStyle: LineStyle(
                            color: index == 0
                                ? ColorsUtils.bgHome
                                : ColorsUtils.bgHome.withOpacity(0.3),
                          ),
                        ));
                  },
                ),
              ),
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
                      text: 'Đồng ý',
                      textStyle: TextStylesUtils.style14FnormalRed,
                      press: () {
                        routeDetailBloc
                            .getSeqStpoppoint(
                                widget.routeItem.requestInfo!.sequenceList)
                            .then(
                          (value) {
                            routeDetailBloc.onUpdatetStatus(
                                value,
                                101,
                                SpUtil.getInt("driverId"),
                                reasonController.text, []).then(
                              (value) {
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
      trailing: InkWell(
          onTap: () {
            routeDetailBloc
                .getSeqStpoppoint(widget.routeItem.requestInfo!.sequenceList)
                .then(
              (value) {
                routeDetailBloc.onUpdatetStatus(
                    value, 101, SpUtil.getInt("driverId"), textStatus, []).then(
                  (value) {
                    Navigator.pop(context, true);
                  },
                );
              },
            );
          },
          child: Icon(Icons.arrow_forward_ios)),
    );
  }
}
