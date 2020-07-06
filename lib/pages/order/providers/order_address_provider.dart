import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_adress_model.dart';
import 'dart:convert';

class OrderAdressProvider with ChangeNotifier {
  String adressString = '[]';
  List<AdressInfoModel> infoList = [];
  // 选择地址回调时使用
  AdressInfoModel selectModel;

  // 添加地址信息到缓存区
  addAdressToList(name, contact, adress, fullAdress) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    String adressStr = pres.getString('adressInfo');
    var temp = adressStr == null ? [] : json.decode(adressStr.toString());
    List<Map> tempList = (temp as List).cast();
    Map<String, dynamic> newAdress = {
      'name': name,
      'contact': contact,
      'adress': adress,
      'fullAdress': fullAdress
    };
    tempList.add(newAdress);
    infoList.add(AdressInfoModel.fromJson(newAdress));
    adressString = json.encode(tempList).toString();
    pres.setString('adressInfo', adressString);

    notifyListeners();
  }

  // 清空缓存
  removeAllAdress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('adressInfo');
    infoList = [];
    selectModel = null;
    notifyListeners();
  }

  // 删除某一条地址
  deleteOneAdress(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    adressString = prefs.getString('adressInfo');
    List<Map> tempList = (json.decode(adressString.toString()) as List).cast();
    tempList.removeAt(index);
    if (tempList.length <= 0) {
      selectModel = null;
    }
    adressString = json.encode(tempList).toString();
    prefs.setString('adressInfo', adressString);

    await getAdressList();
  }

  // 取出缓存信息
  getAdressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    adressString = prefs.getString('adressInfo');
    infoList = [];
    if (adressString == null) {
      infoList = [];
    } else {
      List<Map> tempList =
          (json.decode(adressString.toString()) as List).cast();
      tempList.forEach((element) {
        infoList.add(AdressInfoModel.fromJson(element));
      });
    }
    notifyListeners();
  }

  // 选择地址
  selectAdressInfo(AdressInfoModel model) async {
    selectModel = model;

    notifyListeners();
  }
}
