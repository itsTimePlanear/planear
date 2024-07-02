class Item {
  late int id;
  late String url;
  late String url2;
  late String? url3;
  late int category;
  late int price;
  late bool has;
  Item(
      {required this.id,
      required this.url,
      required this.category,
      required this.price,
      required this.has,
      required this.url2,
      required this.url3});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        url: json['url'],
        url2: json['url'],
        url3: json['url'],
        // url2: json['url2'],
        // url3: json['url3'],
        category: json['category'],
        price: json['price'],
        has: json['has']);
  }
}
