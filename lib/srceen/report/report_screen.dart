import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/network/responses/dashboard_list_reponse.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_bloc.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_event.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_state.dart';
import 'package:sw_app_gtel/srceen/report/widget/widget_chart_reports.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedIndex = 0;

  DateTime now = DateTime.now();
  ReportsBloc reportsBloc = ReportsBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReportsBloc>(
          create: (context) => reportsBloc
            ..add(GetReportsNowsEvent(
                form_date: formatDaysToDate(dateNow(), 00, 01),
                to_date: formatDaysToDate(dateNow(), 23, 59)))
            ..add(GetReportsWeeksEvent(
                form_date: formatDaysToDate(daysMon(), 00, 01),
                to_date: formatDaysToDate(daysSun(), 23, 59)))
            ..add(DashboardListEvent(
                form_date: formatDaysToDate(dateNow(), 00, 01),
                to_date: formatDaysToDate(dateNow(), 23, 59)))
            ..add(DashboardListWeeksEvent(
                form_date: formatDaysToDate(daysMon(), 00, 01),
                to_date: formatDaysToDate(daysSun(), 23, 59))),
        ),
      ],
      child: MultiBlocListener(
          listeners: [
            BlocListener<ReportsBloc, ReportsState>(listener: (context, state) {
              if (state.loading.isLoading) {
                showLoading(context);
              } else if (state.loading.isLoadSuccess &&
                  state.dialogLoading == true) {
                hideLoading(context);
              }
            })
          ],
          child: BlocBuilder<ReportsBloc, ReportsState>(
              builder: (BuildContext context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xFFb3e0ff),
                title: Text('Thống kê sản lượng',
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTab(
                                "Hôm nay",
                                0,
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              _buildTab(
                                "Tuần này",
                                1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        selectedIndex == 0
                            ? Column(
                                children: [
                                  _tabToDay(
                                      "${dayOfWeekNow()}, ngày ${dateNow()}",
                                      state),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state.dashboardListReponse.data.length,
                                    itemBuilder: (context, index) {
                                      Datum item = state
                                          .dashboardListReponse.data[index];
                                      return _itemInfo(item);
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  _tabToWeeks(
                                      '${daysMon()} - ${daysSun()}', state),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state
                                        .dashboardListReponseWeeks.data.length,
                                    itemBuilder: (context, index) {
                                      Datum item = state
                                          .dashboardListReponseWeeks
                                          .data[index];
                                      return _itemInfo(item);
                                    },
                                  ),
                                ],
                              )
                      ],
                    )),
              ),
            );
          })),
    );
  }

  Widget _tabToDay(String days, ReportsState state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            days,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAmountColumn(
                  "${formatVND(state.dashboardSummaryNows.data?.totalCod)}đ",
                  'Tiền mặt'),
              _buildAmountColumn(
                  "${formatVND(state.dashboardSummaryNows.data?.shippingFee)}đ",
                  'Thu hộ (COD)'),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusColumn(
                  "${state.dashboardSummaryNows.data?.successCount}",
                  'Thành công',
                  Colors.green),
              Image.asset("assets/images/drive_line.png"),
              _buildStatusColumn(
                  "${state.dashboardSummaryNows.data?.failedCount}",
                  'Thất bại',
                  Colors.red),
              Image.asset("assets/images/drive_line.png"),
              _buildStatusColumn(
                  "${state.dashboardSummaryNows.data?.onTimeRate}%",
                  'Tỉ lệ đúng hẹn',
                  Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabToWeeks(String days, ReportsState state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            days,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAmountColumn(
                  "${formatVND(state.dashboardSummaryWeeks.data?.totalCod)}đ",
                  'Tiền mặt'),
              _buildAmountColumn(
                  "${formatVND(state.dashboardSummaryWeeks.data?.shippingFee)}đ",
                  'Thu hộ (COD)'),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusColumn(
                  "${state.dashboardSummaryWeeks.data?.successCount}",
                  'Thành công',
                  Colors.green),
              Image.asset("assets/images/drive_line.png"),
              _buildStatusColumn(
                  "${state.dashboardSummaryWeeks.data?.failedCount}",
                  'Thất bại',
                  Colors.red),
              Image.asset("assets/images/drive_line.png"),
              _buildStatusColumn(
                  "${state.dashboardSummaryWeeks.data?.onTimeRate}%",
                  'Tỉ lệ đúng hẹn',
                  Colors.orange),
            ],
          ),
          SizedBox(height: 25),
          WidgetChartReports()
        ],
      ),
    );
  }

  Widget _itemInfo(Datum item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon hình hộp
          _buildicon(item),
          SizedBox(width: 12),
          // Nội dung chính
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.packageName} | ${item.serviceName} | ${item.rweight} kg',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  '#${item.orderCodeOfClient}',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          // Trạng thái + Giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              item.requestStatus?.label == "Thành công"
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFE5FBE6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${item.requestStatus?.label}",
                        style:
                            TextStyle(color: Color(0xFF12A613), fontSize: 12),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${item.requestStatus?.label}",
                        style:
                            TextStyle(color: Color(0xFFF97251), fontSize: 12),
                      ),
                    ),
              SizedBox(height: 8),
              Text(
                '${formatVND(item.shippingFee)}đ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'COD: ${formatVND(item.cod)}đ',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildicon(Datum item) {
    return item.packageName == "Bưu kiện"
        ? CircleAvatar(
            backgroundColor: Color(0XFFC6DCE2),
            radius: 24,
            child: Image.asset(
              "assets/images/report_package.png",
              color: Color(0XFF00A3CB),
            ))
        : CircleAvatar(
            backgroundColor: Color(0xFFFCEAD1),
            radius: 24,
            child: Image.asset(
              "assets/images/report_letter.png",
              color: Color(0xFFDB9F4B),
            ),
          );
  }

  Widget _buildAmountColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildStatusColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget _buildTab(String text, int index) {
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
            "$text",
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
