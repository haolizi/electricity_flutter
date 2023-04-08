/*
 * 地址管理页面
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:electricity_flutter/common/page/base_scaffold.dart';
import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/screen_utils.dart';
import '../logics/mine_address_logic.dart';
import '../models/mine_address_model.dart';
import '../views/mine_address_no_data.dart';
import 'mine_address_edit_page.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  void initState() {
    Get.put(MineAddressLogic());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "收货地址",
      body: GetBuilder<MineAddressLogic>(builder: (logic) {
        if (logic.infoList.isEmpty) return const NoAddressWidget();
        return Stack(
          children: [
            _addressListWidget(logic.infoList),
            _bottomAddButton(),
          ],
        );
      }),
    );
  }

  _addressListWidget(List<AddressInfoModel> addressList) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        return _listItemWidget(addressList[index], index);
      },
    );
  }

  _listItemWidget(AddressInfoModel model, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Get.width,
        color: AppColors.white,
        margin: const EdgeInsets.only(top: 2),
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Row(
          children: <Widget>[
            _infoWidget(model),

            // 删除按钮
            Container(
              alignment: Alignment.centerRight,
              width: 47.5.w,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                ),
                onPressed: () {
                  MineAddressLogic logic = Get.find();
                  logic.deleteOneAddress(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoWidget(AddressInfoModel model) {
    String address = "${model.address!}${model.fullAddress!}";
    return SizedBox(
      width: 315.w,
      child: Column(
        children: <Widget>[
          // 姓名、手机号
          Row(
            children: <Widget>[
              BaseTextWidget(
                model.name!,
              ),
              const SizedBox(width: 10),
              BaseTextWidget(
                model.contact!,
                style: baseTextStyle(
                  fontSize: 12,
                  color: AppColors.primarySubTitleColor153,
                ),
              ),
            ],
          ),

          // 联系人地址
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: BaseTextWidget(address),
          ),
        ],
      ),
    );
  }

  Widget _bottomAddButton() {
    return Positioned(
      left: 0,
      bottom: getBottomBarHeight(),
      child: InkWell(
        onTap: () {
          Get.to(() => const AddressEditPage());
        },
        child: Container(
          width: screenGetWidth(),
          height: 44,
          color: AppColors.themeColor,
          alignment: Alignment.center,
          child: BaseTextWidget(
            "点击添加",
            style: baseTextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
