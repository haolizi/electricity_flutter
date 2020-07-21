/*
 * -------搜索页-------
 * 商品信息
 */

import 'dart:ffi';

class SearchGoodsModel {
  String code;
  String message;
  List<GoodsModel> data;

  SearchGoodsModel({this.code, this.message, this.data});

  SearchGoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<GoodsModel>();
      json['data'].forEach((v) {
        data.add(new GoodsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsModel {
  String image;
  String goodsName;
  double pRESENTPRICE;
  String goodsId;
  double price;
  String goodsNumber;

  GoodsModel(
      {this.image,
      this.goodsName,
      this.pRESENTPRICE,
      this.goodsId,
      this.price,
      this.goodsNumber});

  GoodsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    goodsName = json['goodsName'];
    pRESENTPRICE = json['PRESENT_PRICE'];
    goodsId = json['goodsId'];
    price = json['price'];
    goodsNumber = json['goodsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsName'] = this.goodsName;
    data['PRESENT_PRICE'] = this.pRESENTPRICE;
    data['goodsId'] = this.goodsId;
    data['price'] = this.price;
    data['goodsNumber'] = this.goodsNumber;
    return data;
  }
}
