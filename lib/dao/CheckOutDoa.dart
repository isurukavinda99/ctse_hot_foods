import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/CartItemModel.dart';
import 'package:hot_foods/model/CheckOurModel.dart';
import 'package:hot_foods/model/CreditCardModel.dart';
import 'package:hot_foods/model/MenuItemModel.dart';
import 'package:hot_foods/const/LogginConst.dart';

import '../model/CheckOurModelView.dart';

class CheckOutDao {
  final CollectionReference itemCollection =
  FirebaseFirestore.instance.collection('checkout');

  Future addCheckOut(
      String userId, List<CartItemModel> items) async {
    List<String> itemNames = items.map((item) => item.item).toList();
    return await itemCollection.add({
      "userId": userId,
      "items": itemNames,
      "date" : DateTime.now().toString()
    });
  }

  List<CheckOurModelView> mapCheckoutList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return CheckOurModelView(e.get("userId"), e.get("items").toString() , e.get("date"));
    }).toList();
  }

  Stream<List<CheckOurModelView>> chekOutList() {
    return itemCollection
        .where('userId', isEqualTo: LoginConst.uid)
        .snapshots()
        .map(mapCheckoutList);
  }

}

