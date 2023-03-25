import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/dao/DessertItemDao.dart';
import 'package:hot_foods/model/MenuItemModel.dart';
import 'package:hot_foods/screens/other/individualItem.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';
import 'package:hot_foods/widgets/SearchText.dart';

import '../../widgets/MenuItemCardWidget.dart';
import '../other/MyOrderScreen.dart';

class DessertsScreen extends StatefulWidget {
  static const routeName = '/dessertScreen';
  static const screenName = "Desserts";

  @override
  State<DessertsScreen> createState() => _DessertsScreenState();
}

class _DessertsScreenState extends State<DessertsScreen> {
  List<MenuItemModel> _desserts = [];

  bool _isLoading = true;

  @override
  void initState() {
    _loadDesserts();
  }

  Future<void> _loadDesserts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final desserts = await DessertItemDao().listDesserts().first;
      setState(() {
        _desserts = desserts;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading desserts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToItemDetailScreen(MenuItemModel menuItem) {
    Navigator.of(context).pushNamed(
      IndividualItem.routeName,
      arguments: menuItem.toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "Food Items",
                    style: Utill.getTheme(context).headline5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(MyOrderScreen.routeName,
                        arguments: LoginConst.uid);
                  },
                  child: Image.network(
                    Utill.getAssetName("cart.png", "staticIcons"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SearchText(title: "Search Food"),
          SizedBox(height: 15),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: _desserts.length,
                    itemBuilder: (context, index) {
                      MenuItemModel menuItem = _desserts[index];
                      return GestureDetector(
                        onTap: () {
                          _goToItemDetailScreen(menuItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: MenuItemCardWidget(
                            image: Image.network(
                              menuItem.imgUrl,
                              fit: BoxFit.cover,
                            ),
                            name: menuItem.name,
                            shop: menuItem.shop,
                            rating: menuItem.rating.toString(),
                            category: menuItem.category,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        menu: true,
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
