class MenuItemModel{
  final String name;
  final String imgUrl;
  final String shop;
  final double rating;
  final String category;
  final double price;

  MenuItemModel(this.name, this.imgUrl, this.shop, this.rating, this.category , this.price);

  static MenuItemModel fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      map['name'],
      map['imgUrl'],
      map['shop'],
      map['rating'].toDouble(),
      map['category'],
      map['price']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'shop': shop,
      'rating': rating,
      'category': category,
      'price':price
    };
  }
}