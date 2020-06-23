/*
 * -------首页-------
 * provider
 */

import 'package:flutter/material.dart';
import '../../../config/request/service_method.dart';
import 'dart:convert';

class HomeContentProvider with ChangeNotifier {
  List<Map> bannerList;
  List<Map> categoryList;
  String adBannerImage;
  String leaderInfoBgImage;
  String leaderInfoContact;
  List<Map> recommendList;
  String floor1TopImage;
  List<Map> floor1List;
  String floor2TopImage;
  List<Map> floor2List;
  String floor3TopImage;
  List<Map> floor3List;

  // 请求数据(暂时未用model)
  getContentInfo() async {
    var formData = {'lon': '113.931396', 'lat': '22.525577'};
    await DioUtil.requestData('homePageUrl', formData: formData).then((value) {
      var data = json.decode(value.toString())['data'];
      bannerList = (data['slides'] as List).cast();
      categoryList = (data['category'] as List).cast();
      adBannerImage = data['advertesPicture']['PICTURE_ADDRESS'];
      leaderInfoBgImage = data['shopInfo']['leaderImage'];
      leaderInfoContact = data['shopInfo']['leaderPhone'];
      recommendList = (data['recommend'] as List).cast();
      floor1TopImage = data['floor1Pic']['PICTURE_ADDRESS'];
      floor1List = (data['floor1'] as List).cast();
      floor2TopImage = data['floor2Pic']['PICTURE_ADDRESS'];
      floor2List = (data['floor2'] as List).cast();
      floor3TopImage = data['floor3Pic']['PICTURE_ADDRESS'];
      floor3List = (data['floor3'] as List).cast();

      notifyListeners();
    });
  } 
}


class HomeListProvider with ChangeNotifier {
  List<Map> goodsList = [];
  int currentPage = 1;
  // 请求商品列表数据
  getListInfo() async {
    var formData = {'page':currentPage};
    await DioUtil.requestData('homePageListUrl', formData: formData).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      goodsList.addAll(newGoodsList);
      currentPage ++;

      notifyListeners();
    });
  } 
}