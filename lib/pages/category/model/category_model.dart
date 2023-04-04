
import '../../home/models/home_content_model.dart';

class CategoryModel {
  CategoryModel({
    required this.mallCategoryId,
    required this.mallCategoryName,
    required this.bxMallSubDto,
    this.comments,
    required this.image,
  });

  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  dynamic comments;
  String image;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    mallCategoryId: json["mallCategoryId"],
    mallCategoryName: json["mallCategoryName"],
    bxMallSubDto: List<BxMallSubDto>.from(json["bxMallSubDto"].map((x) => BxMallSubDto.fromJson(x))),
    comments: json["comments"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "mallCategoryId": mallCategoryId,
    "mallCategoryName": mallCategoryName,
    "bxMallSubDto": List<dynamic>.from(bxMallSubDto.map((x) => x.toJson())),
    "comments": comments,
    "image": image,
  };
}

class CategoryGoodModel {
  CategoryGoodModel({
    required this.image,
    required this.oriPrice,
    required this.presentPrice,
    required this.goodsName,
    required this.goodsId,
  });

  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  factory CategoryGoodModel.fromJson(Map<String, dynamic> json) => CategoryGoodModel(
    image: json["image"],
    oriPrice: json["oriPrice"]?.toDouble(),
    presentPrice: json["presentPrice"]?.toDouble(),
    goodsName: json["goodsName"],
    goodsId: json["goodsId"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "oriPrice": oriPrice,
    "presentPrice": presentPrice,
    "goodsName": goodsName,
    "goodsId": goodsId,
  };
}


