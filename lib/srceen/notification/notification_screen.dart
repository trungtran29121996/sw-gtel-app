import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/network/responses/data_notification_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/details_route_srceen.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_bloc.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_event.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_state.dart';

class NoficationScreen extends StatefulWidget {
  const NoficationScreen({super.key});

  @override
  State<NoficationScreen> createState() => _NoficationScreenState();
}

class _NoficationScreenState extends State<NoficationScreen> {
  ScrollController controller = ScrollController();

  NotificationBloc notificationBloc = NotificationBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => notificationBloc..add(GetNotificationEvent())),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
            if (state.loading.isLoading) {
              showLoading(context);
            } else if (state.loading.isLoadSuccess) {
              hideLoading(context);
            }
          }),
        ],
        child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (BuildContext context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
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
                      itemCount: state.datum.length,
                      itemBuilder: (context, index) {
                        Datum item = state.datum[index];
                        String dateTime = startTime(formatDataTime(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.createdAt!)));

                        return InkWell(
                          onTap: () {
                            if (item.screenName == "list_route_details") {
                              showLoading(context);
                              notificationBloc
                                  .onReadNotification(item.id!)
                                  .then(
                                (value) {
                                  hideLoading(context);
                                  if (value!.success == true) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsRouteSrceen(
                                            routeId: item.screenParams!.id!,
                                          ),
                                        ));
                                  }
                                },
                              );
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: item.readAt == ""
                                  ? Colors.white
                                  : Color(0xFFDCF5FC),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                iconPackage(item),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        item.message!,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        dateTime,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })));
        }),
      ),
    );
  }

  Widget iconPackage(Datum item) {
    return item.type! == "CREATE_DELIVERY_ROUTE" //Chuyển phát
        ? CircleAvatar(
            backgroundColor: Color(0xFFFCEAD1),
            child: Image(
              image: AssetImage("assets/images/icon_readnoti.png"),
              color: Color(0xFFE39F0F),
            ),
          )
        : CircleAvatar(
            backgroundColor: Color(0xFFDCF5FC),
            child: Image(image: AssetImage("assets/images/icon_readnoti.png")),
          );
  }
}
