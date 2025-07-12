import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';

class ScanListbarcodeScreen extends StatefulWidget {
  const ScanListbarcodeScreen({super.key});

  @override
  State<ScanListbarcodeScreen> createState() => _ScanListbarcodeScreenState();
}

class _ScanListbarcodeScreenState extends State<ScanListbarcodeScreen> {
  final List<String> scannedCodes = [];

  DateTime? lastScanTime;
  final Duration scanCooldown =
      Duration(seconds: 2); // Khoảng thời gian chờ giữa 2 lần quét

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFb3e0ff),
        title:
            Text('Quét danh sách đơn', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Camera scanner ở trên
          Expanded(
            flex: 3,
            child: MobileScanner(
              onDetect: _onDetect,
            ),
          ),
          // Danh sách các đơn đã tiếp nhận
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Các đơn đã tiếp nhận",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
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
                          child:
                              Text(code, style: const TextStyle(fontSize: 12)),
                        );
                      },
                    ),
                  ),
                  // Nút hoàn thành tiếp nhận
                  DefaultButton(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      borderRadius: BorderRadius.circular(15.0),
                      borderColor: ColorsUtils.bgWareHouse,
                      backgroundColor: ColorsUtils.bgWareHouse,
                      text: 'Hoàn thành tiếp nhận',
                      textStyle: TextStylesUtils.style16WhiteNormal,
                      press: () {
                        Navigator.pop(context, true);
                      }),
                  SizedBox(
                    height: 10,
                  )
                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         // Xử lý logic khi nhấn hoàn thành tiếp nhận
                  //         showDialog(
                  //           context: context,
                  //           builder: (_) => AlertDialog(
                  //             title: const Text("Thông báo"),
                  //             content: Text(
                  //                 "Đã tiếp nhận ${scannedCodes.length} đơn hàng."),
                  //             actions: [
                  //               TextButton(
                  //                 onPressed: () => Navigator.pop(context),
                  //                 child: const Text("OK"),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         padding: const EdgeInsets.symmetric(vertical: 16),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12)),
                  //         backgroundColor: Colors.lightBlue,
                  //       ),
                  //       child: const Text("Hoàn thành tiếp nhận",
                  //           style: TextStyle(fontSize: 16)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
