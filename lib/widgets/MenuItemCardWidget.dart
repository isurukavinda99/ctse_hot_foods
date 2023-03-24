import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../utils/Utill.dart';

class MenuItemCardWidget extends StatelessWidget {
  const MenuItemCardWidget({
    Key key,
    @required String name,
    @required String rating,
    @required String shop,
    @required Image image,
    @required String category,
  })  : _name = name,
        _rating = rating,
        _shop = shop,
        _image = image,
        _category = category,
        super(key: key);

  final String _name;
  final String _rating;
  final String _shop;
  final Image _image;
  final String _category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: _image,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: Utill.getTheme(context).headline4.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Utill.getAssetName("star_filled.png", "staticIcons"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _rating,
                        style: TextStyle(color: AppColor.base),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _shop,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          ".",
                          style: TextStyle(color: AppColor.base),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Desserts",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}