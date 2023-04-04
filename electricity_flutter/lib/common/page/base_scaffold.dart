import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import 'base_text_style.dart';

enum AppBarBackType { back, close, none }

class BaseScaffold extends Scaffold {
  BaseScaffold({
    Key? key,
    String? title,
    PreferredSizeWidget? appBar,
    Widget? body,
    backgroundColor = AppColors.primaryBgColor,
    List<Widget>? actions,
    AppBarBackType leadType = AppBarBackType.back,
    WillPopCallback? onWillPop,
    Brightness brightness = Brightness.light,
    Widget? floatingActionButton,
    Color appBarBackgroundColor = AppColors.themeColor,
    Color titleColor = AppColors.primaryWhiteColor,
    bool centerTitle = true,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    bool isResizeToAvoidBottomInset = true, // 输入框是否随键盘顶起
  }) : super(
          key: key,
          appBar: appBar ??
              BaseAppBar(
                brightness: Brightness.light,
                leadingType: leadType,
                onWillPop: onWillPop ?? onWillPop,
                actions: actions ?? actions,
                centerTitle: centerTitle,
                title: MyTitle(title ?? '', color: titleColor),
                backgroundColor: appBarBackgroundColor,
              ),
          backgroundColor: backgroundColor,
          body: body ?? body,
          floatingActionButton: floatingActionButton ?? floatingActionButton,
          floatingActionButtonLocation:
              floatingActionButtonLocation ?? floatingActionButtonLocation,
          resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
        );
}

// 自定义 AppBar
class BaseAppBar extends AppBar implements PreferredSizeWidget {
  BaseAppBar(
      {Key? key,
      Widget? title,
      AppBarBackType? leadingType,
      WillPopCallback? onWillPop,
      Widget? leading,
      PreferredSizeWidget? bottom,
      Widget? flexibleSpace,
      Brightness? brightness,
      Color? backgroundColor,
      List<Widget>? actions,
      bool centerTitle = true,
      double? elevation})
      : super(
          key: key ?? key,
          title: title ?? title,
          bottom: bottom ?? bottom,
          flexibleSpace: flexibleSpace ?? flexibleSpace,
          centerTitle: centerTitle,
          backgroundColor: backgroundColor ?? Colors.white,
          leading: leading ??
              (leadingType == AppBarBackType.none
                  ? Container()
                  : AppBarBack(
                      leadingType ?? AppBarBackType.back,
                      onWillPop: onWillPop ?? onWillPop,
                    )),
          actions: actions ?? actions,
          elevation: elevation ?? 0.5,
        );

  @override
  get preferredSize => const Size.fromHeight(44.0);
}

// 自定义返回按钮
class AppBarBack extends StatelessWidget {
  final AppBarBackType? _backType;
  final Color? color;
  final WillPopCallback? onWillPop;

  const AppBarBack(this._backType, {Key? key, this.onWillPop, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final willBack = onWillPop == null ? true : await onWillPop!();
        if (!willBack) return;
        Get.back();
      },
      child: _backType == AppBarBackType.close
          ? Icon(
              Icons.close,
              color: color ?? AppColors.themeColor,
              size: 24.0,
            )
          : Container(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Image.asset(
                'images/nav_back.png',
                color: color,
              ),
            ),
    );
  }
}

class MyTitle extends StatelessWidget {
  final String? title;
  final Color? color;

  const MyTitle(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTextWidget(
      title!,
      style: baseTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
