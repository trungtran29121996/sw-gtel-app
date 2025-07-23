import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sw_app_gtel/common/config/show_loading.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/srceen/list_scanbarcode/bloc/scan_listbarcode_bloc.dart';
import 'package:sw_app_gtel/srceen/list_scanbarcode/bloc/scan_listbarcode_event.dart';
import 'package:sw_app_gtel/srceen/list_scanbarcode/bloc/scan_listbarcode_state.dart';

class ScanListbarcodeScreen extends StatefulWidget {
  int routeID;
  ScanListbarcodeScreen({required this.routeID});

  @override
  State<ScanListbarcodeScreen> createState() => _ScanListbarcodeScreenState();
}

class _ScanListbarcodeScreenState extends State<ScanListbarcodeScreen> {
  ScanListBarcodeBloc scanListBarcodeBloc = ScanListBarcodeBloc();

  final List<String> scannedCodes = [];

  DateTime? lastScanTime;
  final Duration scanCooldown = Duration(seconds: 2);

  void _onDetect(BarcodeCapture barcode) {
    final now = DateTime.now();
    final code = barcode.barcodes.first.rawValue ?? '';

    if (code.isEmpty) return;

    if (lastScanTime == null || now.difference(lastScanTime!) > scanCooldown) {
      lastScanTime = now;

      if (!scannedCodes.contains(code)) {
        setState(() {
          scannedCodes.add(code);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => scanListBarcodeBloc,
        child: BlocConsumer<ScanListBarcodeBloc, ScanListBarCodeState>(
            listener: (context, state) {
          if (state.loading.isLoading) {
            showLoading(context);
          } else if (state.loading.isLoadSuccess) {
            Navigator.pop(context, true);
            hideLoadingBool(context);
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFb3e0ff),
              title: Text('Quét danh sách đơn',
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: MobileScanner(
                    onDetect: _onDetect,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Các đơn đã tiếp nhận",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        // Hiển thị mã đã quét
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: scannedCodes.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final code = scannedCodes[index];
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(code,
                                    style: const TextStyle(fontSize: 12)),
                              );
                            },
                          ),
                        ),
                        // Nút hoàn thành tiếp nhận
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DefaultButton(
                                  padding: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderColor: ColorsUtils.bgHome,
                                  backgroundColor: Colors.white,
                                  text: 'Xác nhận lấy',
                                  textStyle: TextStylesUtils.style16FnormalBlue,
                                  press: () {
                                    showLoading(context);
                                    scanListBarcodeBloc.add(GetListBarCodeEvent(
                                        listBarCode: scannedCodes,
                                        route_id: widget.routeID,
                                        is_drop: false,
                                        image_urls: []));
                                  }),
                            ),
                            Expanded(
                              flex: 1,
                              child: DefaultButton(
                                  padding: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderColor: ColorsUtils.infoItemContact,
                                  backgroundColor: Colors.white,
                                  text: 'Xác nhận giao',
                                  textStyle: TextStylesUtils.style16Orange,
                                  press: () {
                                    showLoading(context);
                                    scanListBarcodeBloc.add(GetListBarCodeEvent(
                                        listBarCode: scannedCodes,
                                        route_id: widget.routeID,
                                        is_drop: true,
                                        image_urls: []));
                                  }),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
