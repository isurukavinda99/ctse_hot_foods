import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../screens/menu/PromotionScreen.dart';
import '../screens/menu/menuScreen.dart';
import '../screens/other/MoreScreen.dart';
import '../screens/profileScreen.dart';
import '../utils/Utill.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool offer;
  final bool profile;
  final bool more;

  const CustomNavBar(
      {Key key,
      this.home = false,
      this.menu = false,
      this.offer = false,
      this.profile = false,
      this.more = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Utill.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipShadow(
              boxShadow: [
                BoxShadow(
                  color: AppColor.placeholder,
                  offset: Offset(
                    0,
                    -5,
                  ),
                  blurRadius: 10,
                ),
              ],
              clipper: CustomNavBarClipper(),
              child: Container(
                height: 80,
                width: Utill.getScreenWidth(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!menu) {
                          Navigator.of(context)
                              .pushReplacementNamed(MenuScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          menu
                              ? Image.asset(
                                  Utill.getAssetName(
                                      "more_filled.png", "staticIcons"),
                                )
                              : Image.asset(
                                  Utill.getAssetName("more.png", "staticIcons"),
                                ),
                          menu
                              ? Text("Menu",
                                  style: TextStyle(color: AppColor.base))
                              : Text("Menu"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!offer) {
                          Navigator.of(context)
                              .pushReplacementNamed(PromotionScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          offer
                              ? Image.asset(
                                  Utill.getAssetName(
                                      "bag_filled.png", "staticIcons"),
                                )
                              : Image.asset(
                                  Utill.getAssetName("bag.png", "staticIcons"),
                                ),
                          offer
                              ? Text("Offers",
                                  style: TextStyle(color: AppColor.base))
                              : Text("Offers"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!profile) {
                          Navigator.of(context)
                              .pushReplacementNamed(ProfileScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profile
                              ? Image.asset(
                                  Utill.getAssetName(
                                      "user_filled.png", "staticIcons"),
                                )
                              : Image.asset(
                                  Utill.getAssetName("user.png", "staticIcons"),
                                ),
                          profile
                              ? Text("Profile",
                                  style: TextStyle(color: AppColor.base))
                              : Text("Profile"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!more) {
                          Navigator.of(context)
                              .pushReplacementNamed(MoreScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          more
                              ? Image.asset(
                                  Utill.getAssetName(
                                      "menu_filled.png", "staticIcons"),
                                )
                              : Image.asset(
                                  Utill.getAssetName("menu.png", "staticIcons"),
                                ),
                          more
                              ? Text("Profile",
                                  style: TextStyle(color: AppColor.base))
                              : Text("More"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0.1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
