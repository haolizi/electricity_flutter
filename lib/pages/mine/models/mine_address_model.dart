class AddressInfoModel {
  String? name;
  String? contact;
  String? address;
  String? fullAddress;

  AddressInfoModel({
    this.name = "",
    this.contact = "",
    this.address = "",
    this.fullAddress = "",
  });

  factory AddressInfoModel.fromJson(Map<String, dynamic> json) =>
      AddressInfoModel(
        name: json['name'],
        contact: json['contact'],
        address: json['address'],
        fullAddress: json['fullAddress'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'contact': contact,
        'address': address,
        'fullAddress': fullAddress,
      };
}
