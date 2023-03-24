import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/dao/ResturantItemDao.dart';
import 'package:hot_foods/model/ResturantItem.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/ResturuntCardWidget.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';
import 'package:hot_foods/widgets/SearchText.dart';

import '../../widgets/MenuItemCardWidget.dart';

class RestruantScreen extends StatefulWidget {
  static const routeName = '/restaurants';
  static const screenName = "Restaurants";

  @override
  State<RestruantScreen> createState() => _RestruantScreenState();
}

class _RestruantScreenState extends State<RestruantScreen> {
  List<ResturantItem> _resturant = [];

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
      final resturunt = await ResturantItemDao().listRestaurant().first;
      setState(() {
        _resturant = resturunt;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading restaurants: $e');
      setState(() {
        _isLoading = false;
      });
    }
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
                    RestruantScreen.screenName,
                    style: Utill.getTheme(context).headline5,
                  ),
                ),
                Image.network(
                  Utill.getAssetName("cart.png", "staticIcons"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SearchText(title: "Search Restaurants"),
          SizedBox(height: 15),
          Expanded(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: _resturant.length,
              itemBuilder: (context, index) {
                final rest = _resturant[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ResturuntCardWidget(
                    image: Image.network(
                      rest.imgUrl,
                      fit: BoxFit.cover,
                    ),
                    name: rest.name,
                    address: rest.address,

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
