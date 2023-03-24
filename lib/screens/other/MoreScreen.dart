import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/screens/other/aboutScreen.dart';
import 'package:hot_foods/screens/other/paymentScreen.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';

import 'MyPastOrders.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = "/moreScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Utill.getScreenHeight(context),
              width: Utill.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More",
                        style: Utill.getTheme(context).headline5,
                      ),
                      Image.asset(
                        Utill.getAssetName("cart.png", "staticIcons"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Utill.getAssetName("income.png", "staticIcons"),
                    ),
                    name: "Payment Details",
                    handler: () {
                      Navigator.of(context).pushNamed(PaymentScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Utill.getAssetName("shopping_bag.png", "staticIcons"),
                    ),
                    name: "My Orders",
                    handler: () {
                      Navigator.of(context).pushNamed(MyPastOrders.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      Utill.getAssetName("info.png", "staticIcons"),
                    ),
                    name: "About Us",
                    handler: () {
                      Navigator.of(context).pushNamed(AboutScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              more: true,
            ),
          )
        ],
      ),
    );
  }
}

class MoreCard extends StatelessWidget {
  const MoreCard({
    Key key,
    String name,
    Image image,
    bool isNoti = false,
    Function handler,
  })  : _name = name,
        _image = image,
        _isNoti = isNoti,
        _handler = handler,
        super(key: key);

  final String _name;
  final Image _image;
  final bool _isNoti;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handler,
      child: Container(
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColor.placeholderBg,
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColor.placeholder,
                      ),
                      child: _image),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _name,
                    style: TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColor.placeholderBg,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.secondary,
                  size: 17,
                ),
              ),
            ),
            if (_isNoti)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(
                    right: 50,
                  ),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
