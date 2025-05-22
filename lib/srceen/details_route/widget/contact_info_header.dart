import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';

class ContactInfo extends StatelessWidget {
  String? name;
  String? phone;
  String? address;
  String? date;
  bool isRed;

  ContactInfo({
    this.name,
    this.phone,
    this.address,
    this.date,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isRed ? ColorsUtils.infoItemContact : Colors.blue;
    final colorPhone = isRed ? ColorsUtils.infoItemContact : Colors.blue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.account_box_sharp, size: 14, color: color),
          SizedBox(width: 4),
          Text(
            name!,
          )
        ]),
        SizedBox(
          height: 7,
        ),
        phone != null
            ? Row(
                children: [
                  Row(children: [
                    Icon(Icons.phone, size: 14, color: color),
                    SizedBox(width: 4),
                    Text(
                      phone!,
                      style: TextStyle(color: colorPhone),
                    )
                  ]),
                  SizedBox(
                    height: 7,
                  )
                ],
              )
            : SizedBox(),
        Row(children: [
          Icon(Icons.location_on, size: 14, color: color),
          SizedBox(width: 4),
          Expanded(child: Text(address!))
        ]),
        SizedBox(
          height: 7,
        ),
        Row(children: [
          Icon(Icons.calendar_today, size: 14, color: color),
          SizedBox(width: 4),
          Text(date!),
          SizedBox(width: 4),
        ]),
      ],
    );
  }
}
