import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/format.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_bloc.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_event.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_state.dart';

class WidgetChartReports extends StatefulWidget {
  @override
  _WidgetChartReportsState createState() => _WidgetChartReportsState();
}

class _WidgetChartReportsState extends State<WidgetChartReports>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double? maxY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReportsBloc()
          ..add(CollectedChartEvent(
              form_date: formatDaysToDate(daysMon(), 00, 01),
              to_date: formatDaysToDate(daysSun(), 23, 59))),
        child: BlocConsumer<ReportsBloc, ReportsState>(
            listener: (context, state) {},
            builder: (context, state) {
              maxY = state.chartReponse.data.maxCash.toDouble();
              return AspectRatio(
                aspectRatio: 1.2,
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: maxY,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      if (value % 10 == 0 &&
                                          value <=
                                              state.chartReponse.data.maxCash) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: TextStyle(fontSize: 10),
                                        );
                                      }
                                      return Container(); // Không hiển thị giá trị không cần
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          // days[value.toInt()],
                                          state
                                              .chartReponse
                                              .data
                                              .collectedAmount[value.toInt()]
                                              .label,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: List.generate(
                                  state.chartReponse.data.collectedAmount
                                      .length, (index) {
                                double delayFactor = (index + 1) /
                                    state.chartReponse.data.collectedAmount
                                        .length;
                                double animatedY = state
                                        .chartReponse
                                        .data
                                        .collectedAmount[index]
                                        .totalAmount
                                        .cash
                                        .amount *
                                    (_animation.value.clamp(0.0, delayFactor) /
                                        delayFactor);
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: animatedY,
                                      width: 20,
                                      color: ColorsUtils.columChart,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildLegend(),
                  ],
                ),
              );
            }));
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 16, height: 16, color: ColorsUtils.columChart),
        const SizedBox(width: 8),
        const Text('Tiền mặt'),
      ],
    );
  }
}
