import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/widget_status.dart';
import 'package:sw_app_gtel/network/responses/data_hand_over_reponse.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_bloc.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_bloc.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_event.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_state.dart';
import 'package:sw_app_gtel/srceen/hand_over/dialog_confirrm_handover.dart';

import '../../common/pref/sp_util.dart';

class HandOverSrceen extends StatefulWidget {
  const HandOverSrceen({super.key});

  @override
  State<HandOverSrceen> createState() => _HandOverSrceenState();
}

class _HandOverSrceenState extends State<HandOverSrceen> {
  ScrollController controller = ScrollController();

  HandOverBloc handOverBloc = HandOverBloc();

  int selectedIndex = 0;
  bool isSelectCheckbox = false;

  MemberInfoLogin user =
      MemberInfoLogin.fromJson(SpUtil.getObject("member_info"));

  TextEditingController noteController = TextEditingController();
  RouteDetailBloc routeDetailBloc = RouteDetailBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HandOverBloc>(
            create: (context) => HandOverBloc()
              ..add(GetAllHandOver(
                  page: 1, size: 20, driver_id: SpUtil.getInt("driverId")))
              ..add(GetSubAccount(
                  page: 1,
                  size: 10,
                  service_provider_id: SpUtil.getInt("serviceProviderId"))))
      ],
      child: MultiBlocListener(
          listeners: [
            BlocListener<HandOverBloc, HandOverState>(
              listener: (context, state) {
                if (state.loading.isLoading) {
                  showLoading(context);
                } else if (state.loading.isLoadSuccess &&
                    state.handOver == true) {
                  hideLoading(context);
                }
              },
            ),
          ],
          child: BlocBuilder<HandOverBloc, HandOverState>(
              builder: (BuildContext context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xFFb3e0ff),
                title: Text('Bàn giao nội bộ',
                    style: TextStyle(color: Colors.black)),
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
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
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTab("Đơn có thể bàn giao", 0, 0),
                            const SizedBox(width: 20),
                            _buildTab("Đơn đã bàn giao", 1, 0),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _itemHandOver(state),
                    ],
                  )),
            );
          })),
    );
  }

  Widget _clickChosseHandOver(HandOverState state) {
    return Container(
      margin: EdgeInsets.all(3),
      child: Row(
        children: [
          if (isSelectCheckbox)
            Stack(
              children: [
                Image.asset("assets/images/checked.png"),
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 4, bottom: 1),
                  child: Image.asset("assets/images/square_checked.png"),
                )
              ],
            ),
          SizedBox(
            width: 3,
          ),
          if (isSelectCheckbox)
            Text("${state.listHandOver.length} đơn đã được chọn"),
          Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectCheckbox = false;
                  });
                },
                child: Text(
                  "Bỏ chọn",
                  style: TextStyle(
                    color: isSelectCheckbox ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectCheckbox = true;
                  });
                },
                child: const Text(
                  "Chọn vận đơn",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemHandOver(HandOverState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.listHandOver.length,
        controller: controller,
        itemBuilder: (context, index) {
          HandOverReponse item = state.listHandOver[index];

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
                      if (isSelectCheckbox)
                        Image.asset("assets/images/checkbox.png"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.qr_code_scanner_sharp,
                        color: ColorsUtils.bgWareHouse,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(item.orderCodeOfClient!,
                          style: TextStyle(
                            color: ColorsUtils.bgWareHouse,
                            fontWeight: FontWeight.bold,
                          )),
                      Spacer(),
                      WidgetStatus(status: item.status!),
                    ],
                  ),
                  Divider(
                    color: ColorsUtils.boderGray,
                  ),
                  Row(children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: ColorsUtils.bgWareHouse),
                    SizedBox(width: 4),
                    Text(formatDay(
                        DateTime.fromMillisecondsSinceEpoch(item.startTime!))),
                  ]),
                  // Row(
                  //   children: [
                  //     RichText(
                  //       text: TextSpan(
                  //         children: [
                  //           WidgetSpan(
                  //             child: Image.asset(
                  //               "assets/images/icon_name.png",
                  //               width: 15,
                  //               height: 15,
                  //             ),
                  //           ),
                  //           TextSpan(
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14,
                  //                 color: Colors.black),
                  //             text: "",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     RichText(
                  //       text: TextSpan(
                  //         children: [
                  //           WidgetSpan(
                  //             child: Image.asset(
                  //               "assets/images/phone.png",
                  //               width: 15,
                  //               height: 15,
                  //             ),
                  //           ),
                  //           TextSpan(
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14,
                  //                 color: Colors.black),
                  //             text: "0908376564",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: item.routeAddressList!.length,
                        itemBuilder: (context, index) {
                          String routeAddressList =
                              item.routeAddressList![index];
                          if (index < 5) {
                            return Column(
                              children: [
                                Divider(
                                  color: ColorsUtils.boderGray,
                                ),
                                Row(children: [
                                  Icon(Icons.location_on,
                                      size: 14, color: ColorsUtils.bgWareHouse),
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DefaultButton(
                            padding:
                                EdgeInsets.only(top: 13, right: 10, left: 10),
                            borderRadius: BorderRadius.circular(10.0),
                            borderColor: ColorsUtils.disableButon,
                            backgroundColor: Colors.white,
                            textColor: Colors.white,
                            text: 'Xem chi tiết',
                            textStyle: TextStylesUtils.style16FnormalGrey,
                            press: () {}),
                      ),
                      Expanded(
                          flex: 1,
                          child: DefaultButton(
                              disable: item.status! >= 330 ? false : true,
                              padding:
                                  EdgeInsets.only(top: 13, right: 10, left: 10),
                              borderRadius: BorderRadius.circular(10.0),
                              borderColor: ColorsUtils.handover,
                              backgroundColor: ColorsUtils.handover,
                              text: 'Bàn giao',
                              textStyle: TextStylesUtils.style16WhiteNormal,
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
                                            height: 510,
                                            child: DialogConfirrmHandover(
                                              routeID: item.routeId!,
                                              subAccountReponse:
                                                  state.subAccountReponse,
                                            ),
                                          ),
                                        )).then(
                                  (value) {
                                    if (value == true) {
                                      context.read<HandOverBloc>().add(
                                          GetAllHandOver(
                                              page: 1,
                                              size: 20,
                                              driver_id:
                                                  SpUtil.getInt("driverId")));
                                    }
                                  },
                                );
                              }))
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget _buildTab(String text, int index, int count) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$text ($count)",
            style: TextStyle(
              color: isSelected ? Colors.cyan : Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 3,
              width: 100,
              color: Colors.cyan,
            )
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }
}
