
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/tabs.dart';
import 'pages/catagory/providers/category_provider.dart';
import 'pages/catagory/providers/category_goods_provider.dart';
import 'pages/home/providers/detail_provider.dart';
import 'pages/cart/providers/cart_provider.dart';
import 'package:fluro/fluro.dart';
import 'config/routers/router_application.dart';
import 'config/routers/routers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChildCategoryProvoder()),
        ChangeNotifierProvider(create: (context) => CategoryGoodsListProvide()),
        ChangeNotifierProvider(create: (context) => DetailInfoProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),  
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由
    final router = Router();
    Routes.configureRoutes(router);
    ApplicationRouter.router = router;

    return new MaterialApp(
      title: '某知名电商',
      onGenerateRoute: ApplicationRouter.router.generator,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new Tabs()
    );
  }
}