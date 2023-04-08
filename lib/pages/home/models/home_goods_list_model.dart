class GoodsModel {
  GoodsModel({
    required this.name,
    required this.image,
    required this.mallPrice,
    required this.goodsId,
    required this.price,
  });

  String name;
  String image;
  double mallPrice;
  String goodsId;
  double price;

  factory GoodsModel.fromJson(Map<String, dynamic> json) => GoodsModel(
    name: json["name"],
    image: json["image"],
    mallPrice: json["mallPrice"]?.toDouble(),
    goodsId: json["goodsId"],
    price: json["price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "mallPrice": mallPrice,
    "goodsId": goodsId,
    "price": price,
  };
}
