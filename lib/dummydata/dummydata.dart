import 'package:planear/model/item.dart';

List<Item> dummyItems = [
  item1_1,
  item1_2,
  item1_3,
  item1_4,
  item1_5,
  itme2_1,
  itme2_2,
  itme2_3,
  itme2_4,
  itme2_5,
  itme2_6,
  item3_1,
  item3_2,
  item3_3,
  item3_4,
  item3_5,
  item4_1
];
String url1 = 'https://planear.s3.amazonaws.com/FACE/1_FACE1.jpg';
String url2 = 'https://planear.s3.amazonaws.com/HAIR/2_HAIR1.jpg';
String url3 = 'https://planear.s3.amazonaws.com/TOP/4_TOP1.jpg';
String url4 = 'https://planear.s3.amazonaws.com/BOTTOM/5_BOTTOM1.jpg';
Item item1_1 = Item(
    id: 1, url: url1, category: 1, price: 1, has: true, url2: url1, url3: url1);
Item item1_2 = Item(
    id: 2, url: url1, category: 1, price: 1, has: true, url2: url1, url3: url1);
Item item1_3 = Item(
    id: 3,
    url: url1,
    category: 1,
    price: 1,
    has: false,
    url2: url1,
    url3: url1);
Item item1_4 = Item(
    id: 4,
    url: url1,
    category: 1,
    price: 1,
    has: false,
    url2: url1,
    url3: url1);
Item item1_5 = Item(
    id: 5, url: url1, category: 1, price: 1, has: true, url2: url1, url3: url1);
Item itme2_1 = Item(
    id: 6,
    url: url2,
    category: 2,
    price: 2,
    has: false,
    url2: url2,
    url3: url2);
Item itme2_2 = Item(
    id: 7, url: url2, category: 2, price: 2, has: true, url2: url2, url3: url2);
Item itme2_3 = Item(
    id: 8,
    url: url2,
    category: 2,
    price: 2,
    has: false,
    url2: url2,
    url3: url2);
Item itme2_4 = Item(
    id: 9,
    url: url2,
    category: 2,
    price: 2,
    has: false,
    url2: url2,
    url3: url2);
Item itme2_5 = Item(
    id: 10,
    url: url2,
    category: 2,
    price: 2,
    has: true,
    url2: url2,
    url3: url2);
Item itme2_6 = Item(
    id: 11,
    url: url2,
    category: 2,
    price: 2,
    has: false,
    url2: url2,
    url3: url2);
Item item3_1 = Item(
    id: 12,
    url: url3,
    category: 3,
    price: 3,
    has: true,
    url2: url3,
    url3: url3);
Item item3_2 = Item(
    id: 13,
    url: url3,
    category: 3,
    price: 3,
    has: true,
    url2: url3,
    url3: url3);
Item item3_3 = Item(
    id: 14,
    url: url3,
    category: 3,
    price: 3,
    has: false,
    url2: url3,
    url3: url3);
Item item3_4 = Item(
    id: 15,
    url: url3,
    category: 3,
    price: 3,
    has: true,
    url2: url3,
    url3: url3);
Item item3_5 = Item(
    id: 16,
    url: url3,
    category: 3,
    price: 3,
    has: false,
    url2: url3,
    url3: url3);
Item item4_1 = Item(
    id: 17,
    url: url4,
    category: 4,
    price: 2,
    has: false,
    url2: url4,
    url3: url4);
