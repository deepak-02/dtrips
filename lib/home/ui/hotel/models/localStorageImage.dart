class PostItem {
  String? hotelCode;
  String? url;
  String? address;
  String? cityName;
  String? attribute;
  String? category;
  String? hotelName;

  PostItem(
      {this.hotelCode,
      this.url,
      this.address,
      this.cityName,
      this.attribute,
      this.category,
      this.hotelName});

  Map<String, dynamic> toJson() => {
        'hotelCode': hotelCode,
        'url': url,
        'address': address,
        'cityName': cityName,
        'attribute': attribute,
        'category': category,
        'hotelName': hotelName
      };

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
        hotelCode: json['hotelCode'],
        url: json['url'],
        address: json['address'],
        cityName: json['cityName'],
        attribute: json['attribute'],
        category: json['category'],
        hotelName: json['hotelName']);
  }
}
