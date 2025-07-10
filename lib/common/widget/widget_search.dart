import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/widget/widget_scan_barcode.dart';

class WidgetSearchField extends StatefulWidget {
  final Function(String) onSearch;

  const WidgetSearchField({super.key, required this.onSearch});

  @override
  State<WidgetSearchField> createState() => _WidgetSearchFieldState();
}

class _WidgetSearchFieldState extends State<WidgetSearchField> {
  final TextEditingController _controller = TextEditingController();

  void _onChanged() {
    widget.onSearch(_controller.text.trim());
  }

  Future<void> _scanBarcode() async {
    final scanned = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BarcodeScannerPage(),
        ));

    if (scanned != null && scanned is String) {
      _controller.text = scanned;
      widget.onSearch(scanned);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            hintText: 'Mã vận đơn, Tên khách, Số điện thoại, ...',
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                icon: Icon(Icons.grid_view, color: Colors.cyan),
                onPressed: () {
                  _scanBarcode();
                },
              ),
            ])));
  }
}
