class HomeContentModel {
  HomeContentModel({
    this.slides,
    this.shopInfo,
    this.integralMallPic,
    this.couponsActList,
    this.toShareCode,
    this.recommend,
    this.advertesPicture,
    this.floor1,
    this.floor2,
    this.floor3,
    this.saoma,
    this.newUser,
    this.floor1Pic,
    this.floor2Pic,
    this.floorName,
    this.category,
    this.floor3Pic,
    this.reservationGoods,
  });

  List<Slide>? slides;
  ShopInfo? shopInfo;
  AdvertesPicture? integralMallPic;
  List<dynamic>? couponsActList;
  AdvertesPicture? toShareCode;
  List<Recommend>? recommend;
  AdvertesPicture? advertesPicture;
  List<Floor>? floor1;
  List<Floor>? floor2;
  List<Floor>? floor3;
  AdvertesPicture? saoma;
  AdvertesPicture? newUser;
  AdvertesPicture? floor1Pic;
  AdvertesPicture? floor2Pic;
  FloorName? floorName;
  List<Category>? category;
  AdvertesPicture? floor3Pic;
  List<dynamic>? reservationGoods;

  factory HomeContentModel.fromJson(Map<String, dynamic> json) =>
      HomeContentModel(
        slides: json["slides"] == null
            ? []
            : List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
        shopInfo: ShopInfo.fromJson(json["shopInfo"]),
        integralMallPic: AdvertesPicture.fromJson(json["integralMallPic"]),
        couponsActList:
            List<dynamic>.from(json["couponsActList"].map((x) => x)),
        toShareCode: AdvertesPicture.fromJson(json["toShareCode"]),
        recommend: json["recommend"] == null
            ? []
            : List<Recommend>.from(
                json["recommend"].map((x) => Recommend.fromJson(x))),
        advertesPicture: AdvertesPicture.fromJson(json["advertesPicture"]),
        floor1: List<Floor>.from(json["floor1"].map((x) => Floor.fromJson(x))),
        floor2: List<Floor>.from(json["floor2"].map((x) => Floor.fromJson(x))),
        floor3: List<Floor>.from(json["floor3"].map((x) => Floor.fromJson(x))),
        saoma: AdvertesPicture.fromJson(json["saoma"]),
        newUser: AdvertesPicture.fromJson(json["newUser"]),
        floor1Pic: AdvertesPicture.fromJson(json["floor1Pic"]),
        floor2Pic: AdvertesPicture.fromJson(json["floor2Pic"]),
        floorName: FloorName.fromJson(json["floorName"]),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        floor3Pic: AdvertesPicture.fromJson(json["floor3Pic"]),
        reservationGoods:
            List<dynamic>.from(json["reservationGoods"].map((x) => x)),
      );
}

class AdvertesPicture {
  AdvertesPicture({
    required this.pictureAddress,
    required this.toPlace,
    required this.urlType,
  });

  String pictureAddress;
  String toPlace;
  int urlType;

  factory AdvertesPicture.fromJson(Map<String, dynamic> json) =>
      AdvertesPicture(
        pictureAddress: json["PICTURE_ADDRESS"],
        toPlace: json["TO_PLACE"],
        urlType: json["urlType"],
      );

  Map<String, dynamic> toJson() => {
        "PICTURE_ADDRESS": pictureAddress,
        "TO_PLACE": toPlace,
        "urlType": urlType,
      };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        mallCategoryId: json["mallCategoryId"],
        mallCategoryName: json["mallCategoryName"],
        bxMallSubDto: List<BxMallSubDto>.from(
            json["bxMallSubDto"].map((x) => BxMallSubDto.fromJson(x))),
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

class BxMallSubDto {
  BxMallSubDto({
    required this.mallSubId,
    required this.mallCategoryId,
    required this.mallSubName,
    this.comments,
  });

  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  dynamic comments;

  factory BxMallSubDto.fromJson(Map<String, dynamic> json) => BxMallSubDto(
        mallSubId: json["mallSubId"],
        mallCategoryId: json["mallCategoryId"],
        mallSubName: json["mallSubName"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "mallSubId": mallSubId,
        "mallCategoryId": mallCategoryId,
        "mallSubName": mallSubName,
        "comments": comments,
      };
}

class Floor {
  Floor({
    required this.image,
    required this.goodsId,
  });

  String image;
  String goodsId;

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        image: json["image"],
        goodsId: json["goodsId"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "goodsId": goodsId,
      };
}

class FloorName {
  FloorName({
    required this.floor1,
    required this.floor2,
    required this.floor3,
  });

  String floor1;
  String floor2;
  String floor3;

  factory FloorName.fromJson(Map<String, dynamic> json) => FloorName(
        floor1: json["floor1"],
        floor2: json["floor2"],
        floor3: json["floor3"],
      );

  Map<String, dynamic> toJson() => {
        "floor1": floor1,
        "floor2": floor2,
        "floor3": floor3,
      };
}

class Recommend {
  Recommend({
    required this.image,
    required this.mallPrice,
    required this.goodsName,
    required this.giftCouponsOffline,
    required this.goodsId,
    required this.price,
  });

  String image;
  double mallPrice;
  String goodsName;
  String giftCouponsOffline;
  String goodsId;
  double price;

  factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
        image: json["image"],
        mallPrice: json["mallPrice"]?.toDouble(),
        goodsName: json["goodsName"],
        giftCouponsOffline: json["gift_coupons_offline"] ?? "",
        goodsId: json["goodsId"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "mallPrice": mallPrice,
        "goodsName": goodsName,
        "gift_coupons_offline": giftCouponsOffline,
        "goodsId": goodsId,
        "price": price,
      };
}

class ShopInfo {
  ShopInfo({
    required this.shopCode,
    required this.leaderPhone,
    required this.leaderImage,
    required this.shopName,
  });

  String shopCode;
  String leaderPhone;
  String leaderImage;
  String shopName;

  factory ShopInfo.fromJson(Map<String, dynamic> json) => ShopInfo(
        shopCode: json["SHOP_CODE"] ?? "",
        leaderPhone: json["leaderPhone"],
        leaderImage: json["leaderImage"],
        shopName: json["SHOP_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "SHOP_CODE": shopCode,
        "leaderPhone": leaderPhone,
        "leaderImage": leaderImage,
        "SHOP_NAME": shopName,
      };
}

class Slide {
  Slide({
    required this.image,
    required this.urlType,
    required this.goodsId,
  });

  String image;
  int urlType;
  String goodsId;

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
        image: json["image"],
        urlType: json["urlType"],
        goodsId: json["goodsId"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "urlType": urlType,
        "goodsId": goodsId,
      };
}
