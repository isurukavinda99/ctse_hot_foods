import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/MenuItemModel.dart';

class DessertItemDao {
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future addDessertItem(String name, String imgUrl, String shop, int rating,
      String category) async {
    return await itemCollection.add({
      "name": name,
      "imgUrl": imgUrl,
      "shop": shop,
      "rating": rating,
      "category": category,
    });
  }

  Future editDessertItem(
      id, String title, String description, String ingredients) async {
    await itemCollection.doc(id).update({
      "title": title,
      "description": description,
      "ingredients": ingredients,
    });
  }

  Future removeDessertItem(id) async {
    await itemCollection.doc(id).delete();
  }

  List<MenuItemModel> dessertList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return MenuItemModel(e.get("name"), e.get("imgUrl"), e.get("shop"),
          e.get("rating"), e.get("category"), e.get("price"));
    }).toList();
  }

  Stream<List<MenuItemModel>> listDesserts() {
    return itemCollection
        .where('category', isEqualTo: "dessert")
        .snapshots()
        .map(dessertList);
  }
}
