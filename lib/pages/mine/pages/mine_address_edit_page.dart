/*
 * 添加/编辑地址
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:electricity_flutter/common/page/base_scaffold.dart';
import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:electricity_flutter/pages/mine/logics/mine_address_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressEditPage extends StatelessWidget {
  const AddressEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "添加位置",
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: ListView.builder(
              itemCount: normalList.length,
              itemBuilder: (context, index) {
                return _rowWidget(normalList[index], index);
              },
            ),
          ),

          // 添加按钮
          Positioned(bottom: 0, left: 0, child: _addWidget(context)),
        ],
      ),
    );
  }

  Widget _rowWidget(item, index) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.only(left: 10),
      color: AppColors.white,
      child: Row(
        children: <Widget>[
          BaseTextWidget(item['title']),
          const SizedBox(width: 5),
          SizedBox(
            width: Get.width - 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: item['placehold'],
                border: InputBorder.none,
              ),
              keyboardType:
                  index == 1 ? TextInputType.number : TextInputType.text,
              onChanged: (value) {
                normalList[index]['text'] = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isInputAll = true;
        for (var element in normalList) {
          String textStr = element['text'];
          if (textStr.isEmpty) {
            isInputAll = false;
            BotToast.showText(text: "请填完所有信息");
            return;
          }
        }

        // 全部输入
        if (isInputAll) {
          String name = normalList[0]['text'];
          String contact = normalList[1]['text'];
          String address = normalList[2]['text'];
          String fullAddress = normalList[3]['text'];

          MineAddressLogic logic = Get.find();
          logic.addAddressToList(name, contact, address, fullAddress);
          Get.back();
        }
      },
      child: Container(
        width: Get.width,
        height: 45,
        alignment: Alignment.center,
        color: AppColors.themeColor,
        child: BaseTextWidget(
          '添加',
          style: baseTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

List normalList = [
  {'title': '姓名：', 'placehold': '请输入收货人姓名', 'text': ''},
  {'title': '电话：', 'placehold': '请输入电话号码', 'text': ''},
  {'title': '地区：', 'placehold': '请输入省市区信息', 'text': ''},
  {'title': '详细地址：', 'placehold': '请输入详细地址', 'text': ''}
];
