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
import 'package:sw_app_gtel/network/responses/data_cpn_route_reponse.dart';
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
              } else {
                hideLoading(context);
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
                                isSrceen: 1,
                                routeId: routeItem.routeId!,
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Icon(
                              //   Icons.scaner,
                              //   color: _color(routeItem),
                              // ),
                              Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Image.asset(
                                      "assets/images/scan_qrcode.png")),

                              Text("${routeItem.orderCodeOfClient}",
                                  style: TextStyle(
                                    color: _color(routeItem),
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
                            SizedBox(width: 15),
                            Text("${routeItem.countofpackage}",
                                style: TextStyle(
                                  color: _color(routeItem),
                                  fontSize: 14,
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
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    controller: controller,
                                    itemCount:
                                        routeItem.countEachHandlingUnit!.length,
                                    itemBuilder: (context, index) {
                                      CountEachHandlingUnit
                                          countEachHandlingUnit = routeItem
                                              .countEachHandlingUnit![index];
                                      return Container(
                                          margin: EdgeInsets.only(right: 5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: _countPackage(
                                                countEachHandlingUnit),
                                          ));
                                    }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15, left: 10),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Image.asset(
                                        "assets/images/icon_kg.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                      text: "${routeItem.weight}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: controller,
                                itemCount: routeItem.routeAddressList!.length,
                                itemBuilder: (context, index) {
                                  String routeAddressList =
                                      routeItem.routeAddressList![index];
                                  if (index < 5) {
                                    return Column(
                                      children: [
                                        Divider(
                                          color: ColorsUtils.boderGray,
                                        ),
                                        Row(children: [
                                          Icon(Icons.location_on,
                                              size: 14,
                                              color: _color(routeItem)),
                                          SizedBox(width: 4),
                                          Expanded(
                                              child: Text(
                                            routeAddressList,
                                            style: TextStyle(fontSize: 14),
                                          ))
                                        ]),
                                      ],
                                    );
                                  }
                                  return null;
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
                                                  isSrceen: 1,
                                                  routeId: routeItem.routeId!,
                                                ),
                                              ));
                                          if (result == true) {
                                            _dialogShow = false;
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
                                          StatusType.FAILED &&
                                      !_dialogShow) {
                                    _dialogShow = true;
                                    showAppDialog(
                                            barrierDismissible: false,
                                            isHiddenCancel: true,
                                            context: context,
                                            suffixIcon: Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                              size: 35,
                                            ),
                                            message: "${state.message}",
                                            title: 'Thông báo')
                                        .then(
                                      (_) {
                                        _dialogShow = false;
                                      },
                                    );
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
                                                    isSrceen: 1,
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
                                                backgroundColor:
                                                    ColorsUtils.itemCodeOrder,
                                                text: 'Bắt đầu chạy',
                                                textStyle: TextStylesUtils
                                                    .style16WhiteNormal,
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
    return Row(
      children: [
        item.handlingUnitId == 800
            ? Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        text: "${item.count}",
                      ),
                      WidgetSpan(
                        child: Image.asset(
                          "assets/images/icon_package.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        text: "${item.count}",
                      ),
                      WidgetSpan(
                        child: Image.asset(
                          "assets/images/icon_letter.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Color _color(DataCnpRouteReponse routeItem) {
    Color color = routeItem.requestType == 1
        ? ColorsUtils.infoItemContact
        : ColorsUtils.bgWareHouse;
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
