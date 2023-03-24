import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/dao/CartItemDoa.dart';
import 'package:hot_foods/model/CartItemModel.dart';
import 'package:hot_foods/screens/menu/menuScreen.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';

import '../../const/LogginConst.dart';
import '../../dao/CheckOutDoa.dart';

class MyOrderScreen extends StatefulWidget {
  static const routeName = "/myOrderScreen";
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<CartItemModel> _items = [];

  bool _isLoading = true;

  @override
  void initState() {
    _loadItems();
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

class BurgerCard extends StatelessWidget {
  const BurgerCard({
    Key key,
    String name,
    String price,
    bool isLast = false,
  })  : _name = name,
        _price = price,
        _isLast = isLast,
        super(key: key);

  final String _name;
  final String _price;
  final bool _isLast;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: _isLast
              ? BorderSide.none
              : BorderSide(
                  color: AppColor.placeholder.withOpacity(0.25),
                ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${_name}",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            "RS $_price",
            style: TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
