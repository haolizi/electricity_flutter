import 'dart:convert';

import 'package:electricity_flutter/config/key_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/cart_model.dart';

class CartLogic extends GetxController {
  List<CartInfoModel> infoList = [];
  double allPrice = 0; // 总价
  int allGoodsCount = 0; // 商品总数
  bool isAllCheck = true; // 是否全选

  late GetStorage _storage;

  CartLogic() {
    _storage = GetStorage();
    getCartInfo();
  }

  // 添加商品信息到缓存区
  addGoodsToCart(
      goodsId, goodsName, int count, double price, String image) async {
    bool isExist = false;

    for (int i = 0; i < infoList.length; i++) {
      CartInfoModel model = infoList[i];
      // 已经存在，数量加1
      if (model.goodsId == goodsId) {
        infoList[i].count += count;
        isExist = true;
        // 购物车选中状态，计算总数和总价
        if (model.isCheck) {
          allPrice += price * count;
          allGoodsCount += count;
        }
      }
    }

    // 不存在，添加进缓存
    if (!isExist) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image,
        'isCheck': true
      };

      infoList.add(CartInfoModel.fromJson(newGoods));

      allPrice += (count * price);
      allGoodsCount += count;
    }

    update();

    writeToCache();
  }

  // 清空缓存
  removeAllGoods() async {
    _storage.remove('cartInfo');
    infoList = [];
    allPrice = 0;
    allGoodsCount = 0;
    update();
  }

  // 删除某一个购物车商品
  deleteOneGood(String goodsId) async {
    for (int i = 0; i < infoList.length; i++) {
      CartInfoModel model = infoList[i];
      if (goodsId == model.goodsId) {
        if (model.isCheck) {
          allPrice -= (model.count * model.price);
          allGoodsCount -= model.count;
        }
        infoList.removeAt(i);
        break;
      }
    }

    /// 是否全选
    for (CartInfoModel model in infoList) {
      if (model.isCheck == false) {
        isAllCheck = false;
        break;
      }
    }

    update();
    writeToCache();
  }

  // 商品复选框点击事件
  changeCheckState(String goodsId) async {

    for (int i = 0; i < infoList.length; i++) {
      CartInfoModel model = infoList[i];
      if (goodsId == model.goodsId) {
        bool isCheck = model.isCheck;
        if (isCheck == false) {
          allPrice += (model.count * model.price);
          allGoodsCount += model.count;
        } else {
          allPrice -= (model.count * model.price);
          allGoodsCount -= model.count;
        }
        infoList[i].isCheck = !isCheck;
        break;
      }
    }

    /// 是否全选
    isAllCheck = true;
    for (CartInfoModel model in infoList) {
      if (model.isCheck == false) {
        isAllCheck = false;
        break;
      }
    }

    update();
    writeToCache();
  }

  // 全选按钮点击事件
  changeAllCheckState(bool isCheck) async {
    for (int i = 0; i < infoList.length; i++) {
      infoList[i].isCheck = isCheck;
    }

    writeToCache();
    await getCartInfo();
  }

  /* 商品数量加减
   * type： 1+   2-
   */
  addOrReduceAction(String goodsId, int type) async {
    for (int i = 0; i < infoList.length; i++) {
      CartInfoModel model = infoList[i];
      if (goodsId == model.goodsId) {
        if (type == 1) {
          if (model.isCheck) {
            allGoodsCount += 1;
            allPrice += model.price;
          }
          infoList[i].count += 1;
        } else {
          if (model.isCheck) {
            allGoodsCount -= 1;
            allPrice -= model.price;
          }
          infoList[i].count -= 1;
        }
        break;
      }
    }

    update();
    writeToCache();
  }

  // 取出缓存信息
  getCartInfo() async {
    infoList.clear();
    infoList = readFromCache();

    allPrice = 0;
    allGoodsCount = 0;
    isAllCheck = true;
    for (var element in infoList) {
      if (element.isCheck) {
        allPrice += element.count * element.price;
        allGoodsCount += element.count;
      } else {
        isAllCheck = false;
      }
    }

    update();
  }

  List<CartInfoModel> readFromCache() {
    List<CartInfoModel> tempList = [];
    if (_storage.read(CacheKey.cartCacheKey) != null) {
      String cartString = _storage.read(CacheKey.cartCacheKey);
      List<Map<String, dynamic>> list =
          (json.decode(cartString.toString()) as List).cast();

      tempList =
          List<CartInfoModel>.from(list.map((x) => CartInfoModel.fromJson(x)));
    }
    return tempList;
  }

  writeToCache() {
    String cartString = json.encode(infoList).toString();
    _storage.write(CacheKey.cartCacheKey, cartString);
  }
}
