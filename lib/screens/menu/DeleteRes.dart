import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_foots/widgets/ResturuntCardWidgetDelete.dart';

import '../../const/colors.dart';
import '../../dao/ResturantItemDao.dart';
import '../../model/ResturantItem.dart';
import '../../utils/Utill.dart';
import '../../widgets/CustomNavBar.dart';
import '../../widgets/ResturuntCardWidget.dart';
import '../../widgets/SearchText.dart';
import 'ResturantScreen.dart';

class DeleteRes extends StatefulWidget {
  static const routeName = '/deleteRestaurants';
  static const screenName = "Restaurants Delete";
  const DeleteRes({Key key}) : super(key: key);

  @override
  State<DeleteRes> createState() => _DeleteResState();
}

class _DeleteResState extends State<DeleteRes> {

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
                  child: ResturuntCardWidgetDelete(
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
