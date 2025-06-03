import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
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
  @override
  State<ListAllrouteScreen> createState() => _ListAllrouteScreenState();
}

class _ListAllrouteScreenState extends State<ListAllrouteScreen> {
  TextEditingController textController = TextEditingController();
  ScrollController controller = ScrollController();
  HomeBloc homeBloc = HomeBloc();

  bool isShowInput = false;
  bool _dialogShow = false;

  List<DataCnpRouteReponse> lstDataCnpRoute = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouteDetailBloc>(
          create: (BuildContext context) => RouteDetailBloc(),
        ),
        BlocProvider<HomeBloc>(
            create: (context) => homeBloc
              ..add(
                GetAllRoute(
                    page: 1, size: 30, driver_id: SpUtil.getInt("driverId")),
              ))
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.loading.isLoading) {
                showLoading(context);
              } else if (state.loading.isLoadSuccess) {
                hideLoading(context);
                setState(() {
                  lstDataCnpRoute = state.listRoute;
                });
              }
            },
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
                itemCount: lstDataCnpRoute.length,
                itemBuilder: (context, index) {
                  DataCnpRouteReponse routeItem = lstDataCnpRoute[index];
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
                      onTap: () {
                        Navigator.push(
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
                              Icon(
                                Icons.qr_code_scanner_sharp,
                                color: _color(routeItem),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${routeItem.routeId}",
                                  style: TextStyle(
                                    color: _color(routeItem),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Spacer(),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${routeItem.countofpackage}",
                                  style: TextStyle(
                                    color: _color(routeItem),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 2,
                              ),
                              Text("đơn",
                                  style: TextStyle(
                                    color: ColorsUtils.brownGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              WidgetStatus(status: routeItem.status!),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: _color(routeItem)),
                            SizedBox(width: 4),
                            Text(formatDay(DateTime.fromMillisecondsSinceEpoch(
                                routeItem.startTime!))),
                            SizedBox(width: 4),
                            Spacer(),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: controller,
                                  itemCount:
                                      routeItem.countEachHandlingUnit!.length,
                                  itemBuilder: (context, index) {
                                    CountEachHandlingUnit
                                        countEachHandlingUnit =
                                        routeItem.countEachHandlingUnit![index];
                                    return Container(
                                        margin: EdgeInsets.only(right: 40),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: _countPackage(
                                            countEachHandlingUnit));
                                  }),
                            ),
                            Container(
                              child: Text(
                                '⚖ ${routeItem.weight} kg',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: ColorsUtils.boderGray,
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: controller,
                                itemCount: routeItem.routeAddressList!.length,
                                itemBuilder: (context, index) {
                                  String routeAddressList =
                                      routeItem.routeAddressList![index];
                                  return Row(children: [
                                    Icon(Icons.location_on,
                                        size: 14, color: _color(routeItem)),
                                    SizedBox(width: 4),
                                    Expanded(child: Text(routeAddressList))
                                  ]);
                                }),
                          ),
                          Divider(
                            color: ColorsUtils.boderGray,
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
                                      lstDataCnpRoute = state.listRoute;
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
                                    Expanded(
                                      flex: 1,
                                      child: DefaultButton(
                                          padding: EdgeInsets.only(
                                              top: 13, right: 10, left: 10),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderColor: ColorsUtils.disableButon,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.white,
                                          text: 'Xem chi tiết',
                                          textStyle: TextStylesUtils
                                              .style16FnormalGrey,
                                          press: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsRouteSrceen(
                                                    routeId: routeItem.routeId!,
                                                  ),
                                                ));
                                          }),
                                    ),
                                    routeItem.status == 100
                                        ? Expanded(
                                            flex: 1,
                                            child: DefaultButton(
                                                padding: EdgeInsets.only(
                                                    top: 13,
                                                    right: 10,
                                                    left: 10),
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
                                        : Expanded(flex: 1, child: SizedBox()),
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
      ),
    );
  }

  Widget _countPackage(CountEachHandlingUnit item) {
    return Container(
        child: item.handlingUnitId == 800
            ? Text(
                '${item.count} 📦',
                style: TextStyle(fontSize: 12),
              )
            : Text(
                '${item.count} 📮',
                style: TextStyle(fontSize: 12),
              ));
  }

  Color _color(DataCnpRouteReponse routeItem) {
    Color color =
        routeItem.requestType == 1 ? ColorsUtils.infoItemContact : Colors.blue;
    return color;
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
