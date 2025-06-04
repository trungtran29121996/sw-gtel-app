import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/common/widget/default_input.dart';
import 'package:sw_app_gtel/common/widget/keyboard_dismiss.dart';

class AddInfoCustomerSrceen extends StatefulWidget {
  const AddInfoCustomerSrceen({super.key});

  @override
  State<AddInfoCustomerSrceen> createState() => _AddInfoCustomerSrceenState();
}

class _AddInfoCustomerSrceenState extends State<AddInfoCustomerSrceen> {
  TextEditingController phoneCustomerUnitController = TextEditingController();
  TextEditingController nameCustomerUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: KeyboardDismiss(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Thông tin khách hàng",
                  style: TextStylesUtils.style16Blod),
            ),
            Divider(
              color: ColorsUtils.boderGray,
            ),
            DefaultInput(
              hintText: "Mã KH/Số điện thoại",
              textEditingController: phoneCustomerUnitController,
              keyboardType: TextInputType.text,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              style: TextStylesUtils.style14FnormalBlack,
            ),
            // Spacer(),
            SizedBox(
              height: 15,
            ),
            DefaultInput(
              hintText: "Tên khách hàng",
              textEditingController: nameCustomerUnitController,
              keyboardType: TextInputType.number,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              style: TextStylesUtils.style14FnormalBlack,
            ),
            SizedBox(
              height: 15,
            ),
            DefaultInput(
              suffixIcon: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.add_location_alt_sharp,
                  color: ColorsUtils.bgWareHouse,
                ),
              ),
              hintText: "Nhập địa chỉ hoặc bấm nút lấy địa chỉ theo",
              textEditingController: nameCustomerUnitController,
              keyboardType: TextInputType.number,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsUtils.brownGrey),
                  borderRadius: BorderRadius.circular(10)),
              style: TextStylesUtils.style14FnormalBlack,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DefaultButton(
                      padding: EdgeInsets.all(5),
                      borderRadius: BorderRadius.circular(15.0),
                      borderColor: ColorsUtils.disableButon,
                      backgroundColor: Colors.white,
                      text: 'Quay lại',
                      textStyle: TextStylesUtils.style14FnormalGrey,
                      press: () {
                        Navigator.pop(context);
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: DefaultButton(
                    padding: EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(15.0),
                    borderColor: ColorsUtils.bgWareHouse,
                    backgroundColor: ColorsUtils.bgWareHouse,
                    text: 'Lưu lại',
                    textStyle: TextStylesUtils.style14Fnormalwhite,
                    press: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
