import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_foods/model/MenuItemModel.dart';
import 'package:hot_foods/model/PromotionItem.dart';

class PromotionItemDao {
  final CollectionReference promotionController =
      FirebaseFirestore.instance.collection('promotion');

  Future addPromotionItem(String name, String imgUrl, String shop, String discount,
      String category) async {
    return await promotionController.add({
      "name": name,
      "imgUrl": imgUrl,
      "discount": discount,
      "shop": shop,
    });
  }

  Future editPromotionItem(
      id, String name, String imgUrl, String shop, String discount) async {
    await promotionController.doc(id).update({
      "name": name,
      "imgUrl": imgUrl,
      "discount": discount,
      "shop": shop,
    });
  }

  Future removePromotionItem(id) async {
    await promotionController.doc(id).delete();
  }

  List<PromotionItem> promotionList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return PromotionItem(
          e.get("name"),
          e.get("imgUrl"),
          e.get("shop"),
          e.get("discount")
      );
    }).toList();
  }

  Stream<List<PromotionItem>> listPromotion() {
    return promotionController.snapshots().map(promotionList);
  }
}
