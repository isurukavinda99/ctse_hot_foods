import 'package:hot_foods/model/MenuItemModel.dart';

class CartItemModel {
  String userId;
  String item;
  bool status = false;
  int number;
  double price;

  CartItemModel(this.userId, this.item, this.status, this.number, this.price);

  static CartItemModel fromMap(Map<String, dynamic> map) {
    return CartItemModel(
        map['userId'], map['item'], map['status'], map['number'], map['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'item': item,
      'status': status,
      'number': number,
      'price': price,
    };
  }
}
