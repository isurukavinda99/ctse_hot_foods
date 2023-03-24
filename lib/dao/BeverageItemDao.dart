import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/MenuItemModel.dart';

class BeverageItemDao {
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future addBeverageItem(String name, String imgUrl, String shop, int rating,
      String category) async {
    return await itemCollection.add({
      "name": name,
      "imgUrl": imgUrl,
      "shop": shop,
      "rating": rating,
      "category": category,
    });
  }

  Future editBeverageItem(id, String name, String imgUrl, String shop,
      int rating, String category) async {
    await itemCollection.doc(id).update({
      "name": name,
      "imgUrl": imgUrl,
      "shop": shop,
      "rating": rating,
      "category": category,
    });
  }

  Future removeBeverageItem(id) async {
    await itemCollection.doc(id).delete();
  }

  List<MenuItemModel> beverageList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return MenuItemModel(e.get("name"), e.get("imgUrl"), e.get("shop"),
          e.get("rating"), e.get("category"), e.get("price"));
    }).toList();
  }

  Stream<List<MenuItemModel>> listBeverage() {
    return itemCollection
        .where('category', isEqualTo: "beverage")
        .snapshots()
        .map(beverageList);
  }
}
