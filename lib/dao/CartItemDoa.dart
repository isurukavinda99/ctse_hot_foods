import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/CartItemModel.dart';
import 'package:hot_foods/model/CreditCardModel.dart';
import 'package:hot_foods/model/MenuItemModel.dart';
import 'package:hot_foods/const/LogginConst.dart';

class CartItemDoa {
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('cart');

  Future addCartItem(String userId, String item, bool status, int number,
      double price, int quantity) async {
    return await itemCollection.add({
      "userId": userId,
      "item": item,
      "status": status,
      "number": number,
      "price": price,
    });
  }

  List<CartItemModel> itemsinCart(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      print(e.get("item"));
      return CartItemModel(e.get("userId"), e.get("item"), e.get("status"),
          e.get("number"), e.get("price"));
    }).toList();
  }

  Stream<List<CartItemModel>> cartList() {
    return itemCollection
        .where('userId', isEqualTo: LoginConst.uid)
        .snapshots()
        .map(itemsinCart);
  }
}
