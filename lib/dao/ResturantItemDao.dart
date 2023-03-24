import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/MenuItemModel.dart';
import 'package:hot_foods/model/PromotionItem.dart';

import '../model/ResturantItem.dart';

class ResturantItemDao {
  final CollectionReference restContoller =
      FirebaseFirestore.instance.collection('restaurant');

  Future addRestaurantsItem(String name, String imgUrl, String address) async {
    return await restContoller.add({
      "name": name,
      "imgUrl": imgUrl,
      "address": address,
    });
  }

  Future editRestaurantsItem(
      id, String name, String imgUrl, String address) async {
    await restContoller.doc(id).update({
      "name": name,
      "imgUrl": imgUrl,
      "address": address,
    });
  }

  Future removeRestaurantsItem(id) async {
    await restContoller.doc(id).delete();
  }

  List<ResturantItem> RestaurantList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return ResturantItem(
          e.get("name"),
          e.get("imgUrl"),
          e.get("address")
      );
    }).toList();
  }

  Stream<List<ResturantItem>> listRestaurant() {
    return restContoller.snapshots().map(RestaurantList);
  }
}
