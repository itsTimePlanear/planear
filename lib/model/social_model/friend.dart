class Friend{
  late int id;
  late String urlShop;
  late String urlAvatar1;
  late String urlAvatar2;
  late String bodyPart;
  Friend({
    required this.id,
    required this.bodyPart,
    required this.urlAvatar1,
    required this.urlAvatar2,
    required this.urlShop
  });

  factory Friend.wearingFromJson(Map<String, dynamic> json){
    return Friend(
    id: json['id'], 
    bodyPart: json['bodyPart'], 
    urlAvatar1: json['url_avatar1'], 
    urlAvatar2: json['url_avatar2'], 
    urlShop: json['url_shop']);
  }

}