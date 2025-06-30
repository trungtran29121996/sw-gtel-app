import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/dashboard_list_reponse.dart';
import 'package:sw_app_gtel/network/responses/dashboard_summary_reponse.dart';

class ReportsState extends BaseState {
  Loading loading;
  DashboardSummaryReponse dashboardSummaryNows;
  DashboardSummaryReponse dashboardSummaryWeeks;
  DashboardListReponse dashboardListReponse;
  DashboardListReponse dashboardListReponseWeeks;
  bool dialogLoading;

  ReportsState(
      {required this.loading,
      required this.dashboardSummaryNows,
      required this.dashboardSummaryWeeks,
      required this.dialogLoading,
      required this.dashboardListReponse,
      required this.dashboardListReponseWeeks});
  factory ReportsState.initial() {
    return ReportsState(
        loading: Loading.initial(),
        dashboardSummaryNows: DashboardSummaryReponse(),
        dashboardSummaryWeeks: DashboardSummaryReponse(),
        dialogLoading: false,
        dashboardListReponse: DashboardListReponse(data: []),
        dashboardListReponseWeeks: DashboardListReponse(data: []));
  }
  ReportsState copyWith({
    Loading? loading,
    DashboardSummaryReponse? dashboardSummaryNows,
    DashboardSummaryReponse? dashboardSummaryWeeks,
    bool? dialogLoading,
    DashboardListReponse? dashboardListReponse,
    DashboardListReponse? dashboardListReponseWeeks,
  }) {
    return ReportsState(
        loading: loading ?? this.loading,
        dashboardSummaryNows: dashboardSummaryNows ?? this.dashboardSummaryNows,
        dashboardSummaryWeeks:
            dashboardSummaryWeeks ?? this.dashboardSummaryWeeks,
        dialogLoading: dialogLoading ?? this.dialogLoading,
        dashboardListReponse: dashboardListReponse ?? this.dashboardListReponse,
        dashboardListReponseWeeks:
            dashboardListReponseWeeks ?? this.dashboardListReponseWeeks);
  }

  @override
  List<Object?> get props => [
        loading,
        dashboardSummaryNows,
        dashboardSummaryWeeks,
        dialogLoading,
        dashboardListReponse,
        dashboardListReponseWeeks
      ];
}
