import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/mine_address_edit_page.dart';

class NoAddressWidget extends StatelessWidget {
  const NoAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.note_add,
            color: Colors.black12,
            size: 70,
          ),
          _noteWidget(),
          _addBtnWidget(context)
        ],
      ),
    );
  }

  Widget _noteWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 10),
      child: BaseTextWidget(
        '您还未添加地址~',
        style: baseTextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _addBtnWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(const AddressEditPage());
      },
      child: Container(
        color: AppColors.themeColor,
        width: 80,
        height: 32,
        alignment: Alignment.center,
        child: BaseTextWidget(
          "点击添加",
          style: baseTextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
