import 'package:electricity_flutter/common/page/base_scaffold.dart';
import 'package:electricity_flutter/pages/cart/logics/cart_logic.dart';
import 'package:electricity_flutter/pages/cart/views/cart_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/cart_bottom_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseScaffold(
      title: "购物车",
      leadType: AppBarBackType.none,
      body: GetBuilder<CartLogic>(builder: (logic) {
        return Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: logic.infoList.length,
              itemBuilder: (context, index) {
                return CartItemWidget(model: logic.infoList[index]);
              },
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              child: CartBottomWidget(),
            ),
          ],
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
