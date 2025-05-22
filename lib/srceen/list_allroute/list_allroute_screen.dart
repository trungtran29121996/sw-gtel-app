import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/common/widget/default_app_bar.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/input_textfield.dart';
import 'package:sw_app_gtel/common/widget/widget_status.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';
import 'package:sw_app_gtel/srceen/details_route/details_route_srceen.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_bloc.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_event.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_state.dart';

class ListAllrouteScreen extends StatefulWidget {
  List<DataCnpRouteReponse> lstDataCnpRoute;

  ListAllrouteScreen({required this.lstDataCnpRoute});

  @override
  State<ListAllrouteScreen> createState() => _ListAllrouteScreenState();
}

class _ListAllrouteScreenState extends State<ListAllrouteScreen> {
  TextEditingController textController = TextEditingController();
  ScrollController controller = ScrollController();
  RouteDetailBloc detailBloc = RouteDetailBloc();

  bool isShowInput = false;
  bool _dialogShow = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouteDetailBloc>(
          create: (BuildContext context) => RouteDetailBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        )
      ],
      child: Scaffold(
        backgroundColor: Color(0xFFe6f4ff),
        appBar: !isShowInput
            ? DefaultAppBar(
                backgroundColor: Color(0xFFb3e0ff),
                title: "Danh sách chuyến",
                action: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.search_outlined),
                        onPressed: () {
                          setState(() {
                            isShowInput = true;
                          });
                        }),
                  ],
                ),
              )
            : DefaultAppBar(
                elevation: 5,
                action: Padding(
                  padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                  child: InputTextField(
                      width: getDeviceWidth(context) * .8,
                      label: "Tìm kiếm",
                      controller: textController,
                      autofocus: true,
                      borderRadius: BorderRadius.circular(50),
                      filled: true,
                      fillColor: ColorsUtils.fillInput,
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              textController.clear();
                              isShowInput = false;
                            });
                          },
                          child: Icon(Icons.close))),
                ),

                // AppBar(
                //   backgroundColor: Color(0xFFb3e0ff),
                //   title: Text('Danh sách chuyến'),
              ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              controller: controller,
              itemCount: widget.lstDataCnpRoute.length,
              itemBuilder: (context, index) {
                DataCnpRouteReponse routeItem = widget.lstDataCnpRoute[index];
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
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsRouteSrceen(
                              routeId: routeItem.routeId!,
                            ),
                          ));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("RouteID: ${routeItem.routeId}")),
                            Spacer(),
                            WidgetStatus(status: routeItem.status!),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "${routeItem.orderCodeOfClient}",
                              style: TextStylesUtils.style16ItemCodeOrder,
                            ),
                            Spacer(),
                            Text(formatDay(DateTime.fromMillisecondsSinceEpoch(
                                routeItem.createdAt!))),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                                "Loại chuyến: ${classifyType(routeItem.requestType!)}"),
                            Spacer(),
                            Text("Số lượng đơn: ${routeItem.countofroute!}"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(routeItem.toAddress!),
                        SizedBox(
                          height: 5,
                        ),
                        MultiBlocListener(
                          listeners: [
                            BlocListener<RouteDetailBloc, DetailsRouteState>(
                              listener: (context, state) {
                                if (state.isRouteStart ==
                                        StatusType.COMPLETED &&
                                    !_dialogShow) {
                                  _dialogShow = true;
                                  showAppDialog(
                                      context: context,
                                      suffixIcon: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: ColorsUtils.statusNotification,
                                        size: 35,
                                      ),
                                      barrierDismissible: false,
                                      isHiddenCancel: true,
                                      title: "Thông báo",
                                      message:
                                          "Chuyển trạng thái chuyến thành công!",
                                      onSucessButtonPressed: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsRouteSrceen(
                                                routeId: routeItem.routeId!,
                                              ),
                                            ));
                                        if (result == true) {
                                          Navigator.of(context).pop();
                                          context.read<HomeBloc>().add(
                                              GetAllRoute(
                                                  page: 1,
                                                  size: 10,
                                                  driver_id: SpUtil.getInt(
                                                      "driverId")));
                                        }
                                      }).then(
                                    (_) {
                                      _dialogShow = false;
                                    },
                                  );
                                } else if (state.isRouteStart ==
                                    StatusType.FAILED) {
                                  showAppDialog(
                                      context: context,
                                      suffixIcon: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                      message:
                                          "Chuyển trạng thái chuyến không thành công! Vui lòng thử lại.",
                                      title: 'Thông báo');
                                }
                              },
                            ),
                            BlocListener<HomeBloc, HomeState>(
                              listener: (context, state) {
                                if (state.listRoute.isNotEmpty) {
                                  setState(() {
                                    widget.lstDataCnpRoute = state.listRoute;
                                  });
                                }
                              },
                            )
                          ],
                          child:
                              BlocBuilder<RouteDetailBloc, DetailsRouteState>(
                            builder: (BuildContext context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  routeItem.status == 100
                                      ? Expanded(
                                          flex: 1,
                                          child: DefaultButton(
                                              padding: EdgeInsets.only(
                                                  top: 13, right: 10, left: 10),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderColor:
                                                  ColorsUtils.itemCodeOrder,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.white,
                                              text: 'Bắt đầu chạy',
                                              textStyle: TextStylesUtils
                                                  .style16ItemCodeOrder,
                                              press: () {
                                                context
                                                    .read<RouteDetailBloc>()
                                                    .add(GetRoutingStartEvent(
                                                        routeId: routeItem
                                                            .routeId!));
                                              }),
                                        )
                                      : routeItem.status != 100 &&
                                              routeItem.status != 500
                                          ? Expanded(
                                              flex: 1,
                                              child: DefaultButton(
                                                  padding: EdgeInsets.only(
                                                      top: 13,
                                                      right: 10,
                                                      left: 10),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderColor:
                                                      ColorsUtils.textColorGrey,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.white,
                                                  text: 'Kết thúc',
                                                  textStyle: TextStylesUtils
                                                      .style14FnormalGrey,
                                                  press: () {}),
                                            )
                                          : Expanded(
                                              flex: 1, child: SizedBox()),
                                  SizedBox(
                                    width: 7,
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  String classifyType(int type) {
    String requestType;
    if (type == 1) {
      requestType = 'Đi giao';
    } else {
      requestType = 'Đi lấy';
    }
    return requestType;
  }
}
