class DetailModel {
  DetailModel({
    this.goodInfo,
    this.goodComments,
    this.advertesPicture,
  });

  GoodInfo? goodInfo;
  List<GoodComment>? goodComments;
  AdvertesPicture? advertesPicture;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        goodInfo: GoodInfo.fromJson(json["goodInfo"]),
        goodComments: json["goodComments"] == null
            ? []
            : List<GoodComment>.from(
                json["goodComments"].map(
                  (x) => GoodComment.fromJson(x),
                ),
              ),
        advertesPicture: AdvertesPicture.fromJson(json["advertesPicture"]),
      );
}

class AdvertesPicture {
  AdvertesPicture({
    this.pictureAddress,
    this.toPlace,
    this.urlType,
  });

  String? pictureAddress;
  String? toPlace;
  int? urlType;

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

class GoodComment {
  GoodComment({
    required this.score,
    required this.comments,
    required this.userName,
    required this.discussTime,
  });

  int score;
  String comments;
  String userName;
  int discussTime;

  factory GoodComment.fromJson(Map<String, dynamic> json) => GoodComment(
        score: json["SCORE"],
        comments: json["comments"],
        userName: json["userName"],
        discussTime: json["discussTime"],
      );

  Map<String, dynamic> toJson() => {
        "SCORE": score,
        "comments": comments,
        "userName": userName,
        "discussTime": discussTime,
      };
}

class GoodInfo {
  GoodInfo({
    required this.image5,
    required this.amount,
    required this.image3,
    required this.image4,
    required this.goodsId,
    required this.isOnline,
    required this.image1,
    required this.image2,
    this.giftCouponsOffline,
    required this.mallCategoryId,
    required this.typeShip,
    required this.goodsSerialNumber,
    required this.oriPrice,
    required this.presentPrice,
    required this.comPic,
    required this.state,
    required this.shopId,
    required this.goodsName,
    required this.goodsDetail,
  });

  String image5;
  int amount;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String? giftCouponsOffline = "";
  String mallCategoryId;
  int typeShip;
  String goodsSerialNumber;
  double oriPrice;
  double presentPrice;
  String comPic;
  int state;
  String shopId;
  String goodsName;
  String goodsDetail;

  factory GoodInfo.fromJson(Map<String, dynamic> json) => GoodInfo(
        image5: json["image5"],
        amount: json["amount"],
        image3: json["image3"],
        image4: json["image4"],
        goodsId: json["goodsId"],
        isOnline: json["isOnline"],
        image1: json["image1"],
        image2: json["image2"],
        giftCouponsOffline: json["gift_coupons_offline"],
        mallCategoryId: json["MALL_CATEGORY_ID"],
        typeShip: json["TYPE_SHIP"],
        goodsSerialNumber: json["goodsSerialNumber"],
        oriPrice: json["oriPrice"],
        presentPrice: json["presentPrice"],
        comPic: json["comPic"],
        state: json["state"],
        shopId: json["shopId"],
        goodsName: json["goodsName"],
        goodsDetail: json["goodsDetail"],
      );

  Map<String, dynamic> toJson() => {
        "image5": image5,
        "amount": amount,
        "image3": image3,
        "image4": image4,
        "goodsId": goodsId,
        "isOnline": isOnline,
        "image1": image1,
        "image2": image2,
        "gift_coupons_offline": giftCouponsOffline,
        "MALL_CATEGORY_ID": mallCategoryId,
        "TYPE_SHIP": typeShip,
        "goodsSerialNumber": goodsSerialNumber,
        "oriPrice": oriPrice,
        "presentPrice": presentPrice,
        "comPic": comPic,
        "state": state,
        "shopId": shopId,
        "goodsName": goodsName,
        "goodsDetail": goodsDetail,
      };
}
