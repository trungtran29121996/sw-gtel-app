import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/scanbarcode_reponse.dart';

class ScanListBarCodeState extends BaseState {
  Loading loading;
  ScanListBarcodeReponse scanListBarcodeReponse;

  ScanListBarCodeState({
    required this.loading,
    required this.scanListBarcodeReponse,
  });
  factory ScanListBarCodeState.initial() {
    return ScanListBarCodeState(
      loading: Loading.initial(),
      scanListBarcodeReponse: ScanListBarcodeReponse(),
    );
  }
  ScanListBarCodeState copyWith({
    Loading? loading,
    ScanListBarcodeReponse? scanListBarcodeReponse,
  }) {
    return ScanListBarCodeState(
      loading: loading ?? this.loading,
      scanListBarcodeReponse:
          scanListBarcodeReponse ?? this.scanListBarcodeReponse,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        scanListBarcodeReponse,
      ];
}
