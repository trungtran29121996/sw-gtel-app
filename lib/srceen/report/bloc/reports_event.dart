import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class ReportsEvent extends BaseEvent {}

class GetReportsNowsEvent extends ReportsEvent {
  int form_date;
  int to_date;
  GetReportsNowsEvent({required this.form_date, required this.to_date});
}

class GetReportsWeeksEvent extends ReportsEvent {
  int form_date;
  int to_date;
  GetReportsWeeksEvent({required this.form_date, required this.to_date});
}

class DashboardListEvent extends ReportsEvent {
  int form_date;
  int to_date;
  DashboardListEvent({required this.form_date, required this.to_date});
}
