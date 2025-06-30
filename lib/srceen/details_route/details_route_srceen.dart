import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';
import 'package:sw_app_gtel/srceen/details_route/details_item_router_screen.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/contact_info_header.dart';
import 'package:sw_app_gtel/srceen/details_route/widget/section_title.dart';
import 'package:sw_app_gtel/srceen/receive_bill/receive_bill_details_screen.dart';

class DetailsRouteSrceen extends StatefulWidget {
  int routeId;
  int isSrceen; //1 - màn hình ds chuyến vô //2 - màn hình noti vô

  DetailsRouteSrceen({required this.routeId, required this.isSrceen});

  @override
  State<DetailsRouteSrceen> createState() => _DetailsRouteSrceenState();
}

class _DetailsRouteSrceenState extends State<DetailsRouteSrceen> {
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();
  ScrollController controller = ScrollController();

  int requestType = 0;
  int status = 0;

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
              //backgroundColor: Color(0xFFe6f4ff),
              appBar: AppBar(
                backgroundColor: Color(0xFFb3e0ff),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black)),
                title: Text('Chi tiết chuyến',
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
              ),
              body: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Container(
                    child: ListView.builder(
                        controller: controller,
                        itemCount: state.routeRequestList.length,
                        itemBuilder: (context, index) {
                          RouteRequestList item = state.routeRequestList[index];
                          //requestType 1 là giao - 2 là nhận
                          // requestType = state.routeByID.requestType!;
                          status = state.routeByID.status!;

                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ListOrderDetialsScreen(
                                        routeItem: item,
                                        requestType: requestType,
                                      ),
                                    ));
                              },
                              child: deliveryCard(item, state));
                        }),
                  )),
              // bottomNavigationBar: widget.isSrceen == 2
              //     ? state.routeByID.status == 100
              //         ? Container(
              //             padding: EdgeInsets.all(10),
              //             child: DefaultButton(
              //                 padding:
              //                     EdgeInsets.only(right: 25, left: 25),
              //                 borderRadius: BorderRadius.circular(15.0),
              //                 borderColor: ColorsUtils.itemCodeOrder,
              //                 backgroundColor: ColorsUtils.itemCodeOrder,
              //                 textStyle:
              //                     TextStylesUtils.style16WhiteNormal,
              //                 text: 'Bắt đầu chạy',
              //                 press: () async {
              //                   context.read<RouteDetailBloc>().add(
              //                       GetRoutingStartEvent(
              //                           routeId: widget.routeId));
              //                 }),
              //           )
              //         : SizedBox()
              //     : SizedBox()
              // // )),
              // bottomNavigationBar: state.routeByID.status != 100
              //     ? Container(
              //         padding: EdgeInsets.all(10),
              //         child: DefaultButton(
              //             padding: EdgeInsets.only(right: 25, left: 25),
              //             borderRadius: BorderRadius.circular(15.0),
              //             borderColor: ColorsUtils.textColorGrey,
              //             backgroundColor: Colors.white,
              //             textColor: Colors.white,
              //             text: 'Kết thúc chuyến',
              //             textStyle: TextStylesUtils.style14FnormalGrey,
              //             press: () async {
              //               await routeDetailBloc
              //                   .onRoutingComplete(widget.routeId)
              //                   .then(
              //                 (value) {
              //                   Navigator.pop(context, true);
              //                 },
              //               );
              //             }),
              //         // )),
              //       )
              //     : SizedBox()
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

  Widget _buildButton(RouteRequestList item, DetailsRouteState state) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: BlocListener<RouteDetailBloc, DetailsRouteState>(
            listener: (context, state) {},
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
                          showLoading(context);
                          routeDetailBloc
                              .onUpdatetStatus(seq.seqId!, 200,
                                  SpUtil.getInt("driverId"), "Lấy hàng")
                              .then(
                            (value) {
                              hideLoading(context);
                              Navigator.pop(context, true);
                            },
                          );
                        })
                    : seq.stoppointType == 3 &&
                            seq.status == 100 &&
                            item.requestInfo!.sequenceList[0].stoppointType ==
                                2 &&
                            item.requestInfo!.sequenceList[0].status == 200
                        ? item.requestInfo!.requestType != 1
                            ? DefaultButton(
                                padding: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(15.0),
                                borderColor: ColorsUtils.infoItemContact,
                                backgroundColor: Colors.white,
                                text: 'Xác nhận giao hàng',
                                textStyle: TextStylesUtils.style16Orange,
                                press: () {
                                  showLoading(context);
                                  routeDetailBloc
                                      .onUpdatetStatus(
                                          seq.seqId!,
                                          200,
                                          SpUtil.getInt("driverId"),
                                          "Giao hàng")
                                      .then(
                                    (value) {
                                      hideLoading(context);
                                      Navigator.pop(context, true);
                                    },
                                  );
                                })
                            : SizedBox()
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
                                    style: TextStylesUtils.style16FnormalRed))
                            : SizedBox();
              },
            )),
          ),
        ),
        state.routeByID.sourceType == 7
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
            status == 500 ? SizedBox() : _buildButton(item, state)
          ],
        ),
      ),
    );
  }
}
