import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isBlue;

  const SectionTitle({
    required this.icon,
    required this.title,
    this.isBlue = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isBlue ? ColorsUtils.infoItemContact : Colors.blue;
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 6),
        Text(title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
