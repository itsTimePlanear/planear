class Item {
  late int id;
  late String urlShop;
  late String urlAvatar1;
  late String? urlAvatar2;
  late int category;
  late int price;
  late bool has;
  Item(
      {required this.id,
      required this.urlShop,
      required this.category,
      required this.price,
      required this.has,
      required this.urlAvatar1,
      required this.urlAvatar2});

  factory Item.fromJson(Map<String, dynamic> json, int category) {
    return Item(
        id: json['id'],
        urlShop: json['url_shop'],
        urlAvatar1: json['url_avatar1'],
        urlAvatar2: json['url_avatar2'],
        category: category,
        price: json['price'],
        has: json['has']);
  }
}
