class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String image;
  bool isCheck;

  CartInfoModel({
    required this.goodsId,
    required this.goodsName,
    required this.count,
    required this.price,
    required this.image,
    required this.isCheck,
  });

  factory CartInfoModel.fromJson(Map<String, dynamic> json) => CartInfoModel(
        goodsId: json['goodsId'],
        goodsName: json['goodsName'],
        count: json['count'],
        price: json['price'],
        image: json['image'],
        isCheck: json['isCheck'],
      );

  Map<String, dynamic> toJson() => {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image,
        'isCheck': isCheck,
      };
}
