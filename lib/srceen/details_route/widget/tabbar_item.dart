import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool active;

  const TabItem({required this.title, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(color: active ? Colors.blue : Colors.black)),
        if (active)
          Container(
            margin: EdgeInsets.only(top: 4),
            height: 2,
            width: 60,
            color: Colors.blue,
          )
      ],
    );
  }
}
