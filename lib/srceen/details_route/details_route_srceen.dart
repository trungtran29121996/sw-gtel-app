import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/helper/screen_type.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';
import 'package:sw_app_gtel/srceen/details_route/details_item_router_screen.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/dialog_confirm.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/scan_listbarcode_screen.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/section_title.dart';
import 'package:sw_app_gtel/srceen/receive_bill/receive_bill_details_screen.dart';

class DetailsRouteSrceen extends StatefulWidget {
  SCREEN screen;
  int routeId;

  DetailsRouteSrceen({required this.routeId, required this.screen});

  @override
  State<DetailsRouteSrceen> createState() => _DetailsRouteSrceenState();
}

class _DetailsRouteSrceenState extends State<DetailsRouteSrceen> {
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();
  ScrollController controller = ScrollController();

  int requestType = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => routeDetailBloc
                ..add(GetRouteByIDEvent(routeId: widget.routeId))),
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
            }),
          ],
          child: BlocBuilder<RouteDetailBloc, DetailsRouteState>(
              builder: (BuildContext context, state) {
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFb3e0ff),
                //actions: [
                //   Row(
                //     children: [
                //       Container(
                //           margin: EdgeInsets.only(right: 10),
                //           child:
                //               Image.asset("assets/images/qrcode_search.png")),
                //     ],
                //   )
                // ],
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black)),
                title: Text('Chi tiết chuyến',
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
              ),
              body: WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, true);
                  return true;
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
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
                              suffixIcon: widget.screen ==
                                      SCREEN.SCREEN_PICKUP_GOODS
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                          InkWell(
                                              onTap: () async {
                                                final scanned = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScanListbarcodeScreen()));
                                                if (scanned == true) {
                                                  context
                                                      .read<RouteDetailBloc>()
                                                      .add(GetRouteByIDEvent(
                                                          routeId:
                                                              widget.routeId));
                                                }
                                              },
                                              child: Image.asset(
                                                  "assets/images/qrcode_search.png"))
                                        ])
                                  : SizedBox())),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: ListView.builder(
                            controller: controller,
                            itemCount: state.routeRequestList.length,
                            itemBuilder: (context, index) {
                              RouteRequestList item =
                                  state.routeRequestList[index];
                              //requestType 1 là giao - 2 là nhận

                              return InkWell(
                                  onTap: () {
                                    final result = Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListOrderDetialsScreen(
                                            routeItem: item,
                                            requestType: requestType,
                                          ),
                                        ));
                                    if (result == true) {
                                      context.read<RouteDetailBloc>().add(
                                          GetRouteByIDEvent(
                                              routeId: widget.routeId));
                                    }
                                  },
                                  child: deliveryCard(item, state));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
        ));
  }

  Widget _buildStatus(String textStatus, Color color) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(textStatus),
    );
  }

  Widget deliveryCard(RouteRequestList item, DetailsRouteState state) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
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
                Icon(
                  Icons.qr_code_scanner_sharp,
                  color: requestType == 1
                      ? ColorsUtils.infoItemContact
                      : Colors.blue,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("${item.requestInfo!.orderCodeOfClient!}",
                    style: TextStyle(
                      color: requestType == 1
                          ? ColorsUtils.infoItemContact
                          : Colors.blue,
                      fontSize: 16,
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
                    color: ColorsUtils.disableButon,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorsUtils.bgHomeMenu),
                  ),
                  child: Text('CPN'),
                ),
                SizedBox(
                  width: 10,
                ),
                requestType == 1
                    ? Image.asset("assets/images/upload.png")
                    : Image.asset("assets/images/download.png")
              ],
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            // Sender
            Row(
              children: [
                SectionTitle(
                  icon: Icons.send,
                  title: requestType == 1
                      ? 'Thông tin người giao'
                      : 'Thông tin người nhận',
                  isBlue: requestType == 1 ? true : false,
                ),
                Spacer(),
                item.requestInfo!.pickupFailedCount! <= 0
                    ? SizedBox()
                    : _buildStatus(
                        "Hẹn giao lần ${item.requestInfo!.pickupFailedCount!}",
                        ColorsUtils.statusContact),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            requestType == 1
                ? ContactInfo(
                    name: item.requestInfo!.senderName!,
                    phone: item.requestInfo!.senderPhone!,
                    address: item.requestInfo!.pickupAddress!,
                    date: formatDay(DateTime.fromMillisecondsSinceEpoch(
                        item.requestInfo!.pickupTime!)),
                    isRed: true,
                  )
                : ContactInfo(
                    name: item.requestInfo!.receiverName!,
                    phone: item.requestInfo!.receiverPhone!,
                    address: item.requestInfo!.dropAddress!,
                    date: item.requestInfo!.pickupTimePreferred!,
                    isRed: false,
                  ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            Row(
              children: [
                item.requestInfo!.requestPackageItems!.isNotEmpty
                    ? Row(children: [
                        Image.asset("assets/images/letter.png"),
                        SizedBox(width: 4),
                        Text(
                            "${item.requestInfo!.requestPackageItems![0].name}")
                      ])
                    : SizedBox(),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Row(children: [
                    Image.asset("assets/images/money.png"),
                    SizedBox(width: 4),
                    Text("${formatVND(item.requestInfo!.totalFee!)}",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            state.routeByID.status! == 500
                ? SizedBox()
                : _buildButton(item, state)
          ],
        ),
      ),
    );
  }

  Widget _buildButton(RouteRequestList item, DetailsRouteState state) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: item.requestInfo!.sequenceList.length,
              itemBuilder: (context, index) {
                SequenceList seq = item.requestInfo!.sequenceList[index];

                return seq.stoppointType == 2 && seq.status == 100
                    ? DefaultButton(
                        padding: EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(15.0),
                        borderColor: ColorsUtils.bgHome,
                        backgroundColor: Colors.white,
                        textColor: ColorsUtils.bgHome,
                        text: 'Xác nhận lấy hàng',
                        textStyle: TextStylesUtils.style16FnormalBlue,
                        press: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              contentPadding: EdgeInsets.all(15.0),
                              content: SizedBox(
                                width: getDeviceWidth(context),
                                height: 300,
                                child: DialogConfirm(
                                  label: 'Xác nhận lấy hàng',
                                  seq: seq,
                                ),
                              ),
                            ),
                          ).then((valute) {
                            context
                                .read<RouteDetailBloc>()
                                .add(GetRouteByIDEvent(routeId: seq.routeId!));
                          });
                        })
                    : seq.stoppointType == 3 &&
                            seq.status == 100 &&
                            item.requestInfo!.sequenceList[0].stoppointType ==
                                2 &&
                            item.requestInfo!.sequenceList[0].status == 200
                        ? state.routeByID.requestType == 1
                            ? DefaultButton(
                                padding: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(15.0),
                                borderColor: ColorsUtils.infoItemContact,
                                backgroundColor: Colors.white,
                                text: 'Xác nhận giao hàng',
                                textStyle: TextStylesUtils.style16Orange,
                                press: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      contentPadding: EdgeInsets.all(15.0),
                                      content: SizedBox(
                                        width: getDeviceWidth(context),
                                        height: 300,
                                        child: DialogConfirm(
                                          label: 'Xác nhận giao hàng',
                                          seq: seq,
                                        ),
                                      ),
                                    ),
                                  ).then((valute) {
                                    context.read<RouteDetailBloc>().add(
                                        GetRouteByIDEvent(
                                            routeId: seq.routeId!));
                                  });
                                  ;
                                })
                            : SizedBox()
                        : seq.stoppointType == 2 && seq.status == 101
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.red),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(7),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "Lấy không thành công",
                                    style: TextStylesUtils.style16FnormalRed))
                            : seq.stoppointType == 3 && seq.status == 101
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.red),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        "Giao không thành công",
                                        style:
                                            TextStylesUtils.style16FnormalRed))
                                : SizedBox();
              },
            ))),
        state.routeByID.sourceType == 7 &&
                state.routeByID.status! > 100 &&
                state.routeByID.status! < 330
            ? Expanded(
                child: DefaultButton(
                    padding: EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(15.0),
                    borderColor: ColorsUtils.btnHandover,
                    backgroundColor: Colors.white,
                    text: 'Cập nhật',
                    textStyle: TextStylesUtils.style16FnormalRed,
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiveBillDetailsScreen(
                              routeID: state.routeByID.routeId!,
                              requestId: item.requestId!,
                            ),
                          ));
                    }))
            : SizedBox()
      ],
    );
  }
}
