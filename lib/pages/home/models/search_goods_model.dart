class SearchGoodsModel {
  SearchGoodsModel({
    required this.goodsName,
    required this.image,
    required this.presentPrice,
    required this.goodsId,
    required this.price,
  });

  String goodsName;
  String image;
  double presentPrice;
  String goodsId;
  double price;

  factory SearchGoodsModel.fromJson(Map<String, dynamic> json) =>
      SearchGoodsModel(
        goodsName: json["goodsName"],
        image: json["image"],
        presentPrice: json["PRESENT_PRICE"]?.toDouble(),
        goodsId: json["goodsId"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "goodsName": goodsName,
        "image": image,
        "PRESENT_PRICE": presentPrice,
        "goodsId": goodsId,
        "price": price,
      };
}
