import 'package:flutter/material.dart';
import '../utils/color.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

typedef ValueChanged<T> = void Function(T value);
class BaseTabBar extends TabBar implements PreferredSizeWidget {
  BaseTabBar({
    Key? key,
    required List<Widget> tabs,
    bool isScrollable = true,
    Color labelColor = AppColors.primaryTitleColor31,
    Color unselectedLabelColor = AppColors.primarySubTitleColor153,
    Decoration? indicator,
    double height = 2,
    double horizontalPadding = 5,
    TabPosition tabPosition = TabPosition.bottom,
    TabController? controller,
    final ValueChanged<int>? onTap,
  }) : super(
          key: key,
          tabs: tabs,
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          isScrollable: isScrollable,
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          controller: controller,
          onTap: onTap,
          indicator: indicator ??
              MaterialIndicator(
                height: height,
                horizontalPadding: horizontalPadding,
                tabPosition: tabPosition,
              ),
        );
}
