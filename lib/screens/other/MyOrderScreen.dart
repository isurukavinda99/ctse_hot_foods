import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/dao/CartItemDoa.dart';
import 'package:hot_foods/model/CartItemModel.dart';
import 'package:hot_foods/screens/menu/menuScreen.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';

import '../../const/LogginConst.dart';
import '../../dao/CheckOutDoa.dart';
import '../../widgets/BurgerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderScreen extends StatefulWidget {
  static const routeName = "/myOrderScreen";
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<CartItemModel> _items = [];

  bool _isLoading = true;

  int _selectedQuantity = 1;

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final items = await CartItemDoa().cartList().first;
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading carts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // void _deleteItem(int index) {
  //   setState(() {
  //     _items.removeAt(index);
  //   });
  // }
  void _deleteItem(int index) async {
    final item = _items[index];
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              firestore
                  .collection('cart')
                  .doc(item.item.replaceAll(" ", "") + item.userId)
                  .delete();
              Navigator.of(context).pop(true);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      setState(() {
        _items.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.primary,
          content: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                '${item.item} successfully deleted',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

// void _deleteItem(int index) async {
//   final item = _items[index];
//   setState(() {
//     _items.removeAt(index);
//   });
//   await CartItemDoa().deleteCartItem(item.id);
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "My Cart",
                        style: Utill.getTheme(context).headline5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: AppColor.placeholderBg,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 300,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: ClampingScrollPhysics(),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                final rest = _items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: BurgerCard(
                                    price: rest.price.toString(),
                                    name: rest.item,
                                    onDelete: () => _deleteItem(index),
                                    onQuantityChange: (quantity) {
                                      setState(() {
                                        _items[index].number =
                                            quantity; // Update the quantity of the item
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            CheckOutDao().addCheckOut(LoginConst.uid, _items);
                            Navigator.of(context)
                                .pushNamed(MenuScreen.routeName);
                          },
                          child: Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(),
          ),
        ],
      ),
    );
  }
}
