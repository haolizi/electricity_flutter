import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/key_config.dart';
import '../models/mine_address_model.dart';

class MineAddressLogic extends GetxController {
  List<AddressInfoModel> infoList = [];
  late AddressInfoModel selectModel;
  late GetStorage _storage;

  MineAddressLogic() {
    selectModel = AddressInfoModel();
    _storage = GetStorage();

    infoList = readFromCache();
  }

  /// 添加地址
  Future addAddressToList(String name, String contact, String address, String fullAddress) async {
    Map<String, dynamic> newAddress = {
      'name': name,
      'contact': contact,
      'address': address,
      'fullAddress': fullAddress
    };

    infoList.insert(0, AddressInfoModel.fromJson(newAddress));
    update();
    writeToCache();
  }

  /// 删除某一条地址
  deleteOneAddress(int index) async {
    infoList.removeAt(index);
    update();
    writeToCache();
  }

  /// 清空缓存
  removeAllAddress() async {
    _storage.remove(CacheKey.addressCacheKey);
    infoList = [];
    selectModel = AddressInfoModel();
    update();
  }

  /// 读出缓存
  List<AddressInfoModel> readFromCache() {
    List<AddressInfoModel> tempList = [];
    if (_storage.read(CacheKey.addressCacheKey) != null) {
      String addressString = _storage.read(CacheKey.addressCacheKey);
      List<Map<String, dynamic>> list =
          (json.decode(addressString.toString()) as List).cast();

      tempList = List<AddressInfoModel>.from(
          list.map((x) => AddressInfoModel.fromJson(x)));
    }
    return tempList;
  }

  /// 写入缓存
  writeToCache() {
    String addressString = json.encode(infoList).toString();
    _storage.write(CacheKey.addressCacheKey, addressString);
  }
}
