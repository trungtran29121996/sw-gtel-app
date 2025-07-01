import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/network/repository/reports_repository.dart';
import 'package:sw_app_gtel/network/responses/collect_chart_reponse.dart';
import 'package:sw_app_gtel/network/responses/dashboard_list_reponse.dart';
import 'package:sw_app_gtel/network/responses/dashboard_summary_reponse.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_event.dart';
import 'package:sw_app_gtel/srceen/report/bloc/reports_state.dart';

class ReportsBloc extends BaseBloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(state: ReportsState.initial()) {
    on<GetReportsNowsEvent>(_onGetReportsNows);
    on<GetReportsWeeksEvent>(_onGetReportsWeeks);
    on<DashboardListEvent>(_onGetDashboardList);
    on<DashboardListWeeksEvent>(_onGetDashboardListWeeks);
    on<CollectedChartEvent>(_onGetCollectedChart);
  }

  ReportsRepository reportsRepository = ReportsRepository();

  Future _onGetReportsNows(GetReportsNowsEvent event, Emitter emit) async {
    try {
      DashboardSummaryReponse dashboardSummaryNows = DashboardSummaryReponse();

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      dashboardSummaryNows =
          await reportsRepository.getReports(event.form_date, event.to_date);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          dashboardSummaryNows: dashboardSummaryNows,
          dialogLoading: true));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future _onGetReportsWeeks(GetReportsWeeksEvent event, Emitter emit) async {
    try {
      DashboardSummaryReponse dashboardSummaryWeeks = DashboardSummaryReponse();
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      dashboardSummaryWeeks =
          await reportsRepository.getReports(event.form_date, event.to_date);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          dashboardSummaryWeeks: dashboardSummaryWeeks,
          dialogLoading: false));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future _onGetDashboardList(DashboardListEvent event, Emitter emit) async {
    try {
      DashboardListReponse dashboardListReponse =
          DashboardListReponse(data: []);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      dashboardListReponse = await reportsRepository.getDashboardList(
          event.form_date, event.to_date);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          dashboardListReponse: dashboardListReponse,
          dialogLoading: false));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future _onGetDashboardListWeeks(
      DashboardListWeeksEvent event, Emitter emit) async {
    try {
      DashboardListReponse dashboardListReponseWeeks =
          DashboardListReponse(data: []);
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      dashboardListReponseWeeks = await reportsRepository.getDashboardList(
          event.form_date, event.to_date);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          dashboardListReponseWeeks: dashboardListReponseWeeks,
          dialogLoading: false));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future _onGetCollectedChart(CollectedChartEvent event, Emitter emit) async {
    try {
      CollectedChartReponse chartReponse = CollectedChartReponse(
          data: DataNum(collectedAmount: [], maxCash: 0, maxCod: 0, color: []));

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      chartReponse = await reportsRepository.getCollectedChart(
          event.form_date, event.to_date);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          chartReponse: chartReponse,
          dialogLoading: false));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }
}
