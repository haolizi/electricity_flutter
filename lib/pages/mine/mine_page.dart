/*
 * -------我的-------
 */

import 'package:flutter/material.dart';
import './views/mine_head_widget.dart';
import './views/mine_order_widget.dart';
import './views/mine_order_status_widget.dart';
import './views/mine_list_widget.dart';

class SetPage extends StatelessWidget {
  const SetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TopHead(),
        OrdeInfo(),
        OrderStatus(),
        ListTitleWidget()
      ],
    );
  }
}
