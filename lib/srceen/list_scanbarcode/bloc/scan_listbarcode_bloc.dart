import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/network/repository/scan_listbarcode_respository.dart';
import 'package:sw_app_gtel/network/responses/scanbarcode_reponse.dart';
import 'package:sw_app_gtel/srceen/list_scanbarcode/bloc/scan_listbarcode_event.dart';
import 'package:sw_app_gtel/srceen/list_scanbarcode/bloc/scan_listbarcode_state.dart';

class ScanListBarcodeBloc
    extends BaseBloc<ScanListBarCodeEvent, ScanListBarCodeState> {
  ScanListBarcodeBloc() : super(state: ScanListBarCodeState.initial()) {
    on<GetListBarCodeEvent>(_scanbarcode);
  }

  ScanListBarcodeRepository scanListBarcodeRepository =
      ScanListBarcodeRepository();

  Future _scanbarcode(GetListBarCodeEvent event, Emitter emit) async {
    try {
      ScanListBarcodeReponse? scanListBarcodeReponse =
          await scanListBarcodeRepository.scanListBarCode(event.listBarCode,
              event.route_id, event.is_drop, event.image_urls);

      emit.call(
        state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, isLoadSuccess: true),
            scanListBarcodeReponse: scanListBarcodeReponse),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
