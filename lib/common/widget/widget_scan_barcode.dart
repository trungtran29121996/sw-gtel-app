import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sw_app_gtel/common/widget/default_app_bar.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool _isDetected = false;

  void _onDetect(BarcodeCapture capture) {
    if (_isDetected) return; // Đã quét, không xử lý nữa

    final barcode = capture.barcodes.first;
    final String? code = barcode.rawValue;

    if (code != null) {
      _isDetected = true;
      Navigator.pop(context, code); // Trả kết quả về 1 lần duy nhất
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        backgroundColor: Color(0xFFb3e0ff),
        title: "Quét mã",
      ),
      body: MobileScanner(
        onDetect: _onDetect,
      ),
    );
  }
}
