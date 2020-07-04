import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> infoList = []; 
  double allPrice = 0;   // 总价
  int allGoodsCount = 0; // 商品总数
  bool isAllCheck = true; // 是否全选

  // 添加商品信息到缓存区
  addGoodsToCart(goodsId, goodsName, count, price, image) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    String cartStr = pres.getString('cartInfo');
    var temp = cartStr == null?[]:json.decode(cartStr.toString());
    List<Map> tempList = (temp as List).cast();
    bool isExist = false;
    int ival = 0;
    allPrice = 0; 
    allGoodsCount = 0;
    
    tempList.forEach((element) {
      // 已经存在，数量加1
      if(element['goodsId'] == goodsId) {
        tempList[ival]['count'] = element['count'] + 1;
        infoList[ival].count ++;
        isExist = true;
      }
      // 购物车选中状态，计算总数和总价
      if(element['isCheck']) {
        allPrice += (infoList[ival].price * infoList[ival].count);
        allGoodsCount += infoList[ival].count;
      }
      ival ++;
    });

    // 不存在，添加进缓存
    if(!isExist) {
      Map<String, dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'image':image,
        'isCheck':true
      };
      tempList.add(newGoods);
      infoList.add(CartInfoModel.fromJson(newGoods));

      allPrice += (count*price);
      allGoodsCount += count;
    }
   
    cartString = json.encode(tempList).toString();
    pres.setString('cartInfo', cartString); 

    notifyListeners();
  }

  // 清空缓存
  removeAllGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    infoList = [];
    notifyListeners();
  }

  // 删除某一个购物车商品
  deleteOneGood(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        delIndex = tempIndex;
      } 
      tempIndex ++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); 

    await getCartInfo ();
  }

  // 取出缓存信息
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    infoList = [];
    if(cartString == null) {
      infoList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((element) {
        infoList.add(CartInfoModel.fromJson(element));
        if(element['isCheck']) {
          allPrice += element['count']*element['price'];
          allGoodsCount += element['count'];
        } else {
          isAllCheck = false;
        }
      });
    }
    notifyListeners();
  }

  // 商品复选框点击事件
  changeCheckState(CartInfoModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    infoList = [];
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0; 
    tempList.forEach((element) {
      if (element['goodsId'] == model.goodsId) {
        changeIndex = tempIndex;
      } 
      tempIndex ++;
    });

    tempList[changeIndex] = model.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo ();
  }

  // 全选按钮点击事件
  changeAllCheckState(isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];

    tempList.forEach((element) {
      var newItem = element;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    });

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo ();
  }

  // 商品数量加减 states加或减操作
  addOrReduceAction(var cartItem, String states ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); 
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if(item['goodsId']==cartItem.goodsId){
      changeIndex = tempIndex; 
      }
      tempIndex ++;
     });
     if(states == 'add'){
       cartItem.count++;
     }
     else if(cartItem.count > 1) {
       cartItem.count --;
     }
     tempList[changeIndex]=cartItem.toJson();
     cartString = json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();
  }
}
