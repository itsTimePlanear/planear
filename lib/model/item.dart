class Item {
  late int id;
  late String urlShop;
  late String urlAvatar1;
  late String urlAvatar2;
  late int category;
  int? price;
  bool? has;
  Item({
    this.price,
    this.has,
    required this.id,
    required this.urlShop,
    required this.urlAvatar1,
    required this.urlAvatar2,
    required this.category,
  });

  factory Item.fromJsonWithCategory(Map<String, dynamic> json, int category) {
    return Item(
        id: json['id'],
        urlShop: json['url_shop'],
        urlAvatar1: json['url_avatar1'],
        urlAvatar2: json['url_avatar2'],
        category: category,
        price: json['price'],
        has: json['has']);
  }

  factory Item.wearingFromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        urlShop: json['url_shop'],
        urlAvatar1: json['url_avatar1'],
        urlAvatar2: json['url_avatar2'],
        category: partToCategory(json['category']));
  }
}

int partToCategory(String part) {
  switch (part) {
    case "FACE":
      return 1;
    case "HAIR":
      return 2;
    case "TOP":
      return 3;
    case "BOTTOM":
      return 4;
    case "SHOES":
      return 5;
    case "ACCESSORY":
      return 6;

    default:
      return 0;
  }
}
