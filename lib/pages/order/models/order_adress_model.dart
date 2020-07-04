/*
 * -------订单支付-------
 * 选择地址Model
 */

class AdressInfoModel {
  String name;
  String contact;
  String adress;
  String fullAdress;

  AdressInfoModel(
      {this.name, this.contact, this.adress, this.fullAdress});

  AdressInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contact = json['contact'];
    adress = json['adress'];
    fullAdress = json['fullAdress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['adress'] = this.adress;
    data['houseNum'] = this.fullAdress;
    return data;
  }
}