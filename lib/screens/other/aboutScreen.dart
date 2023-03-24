import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = "/aboutScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          "About Us",
                          style: Utill.getTheme(context).headline5,
                        ),
                      ),
                      Image.asset(
                        Utill.getAssetName("cart.png", "staticIcons"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AboutCard(
                    text:
                      "Welcome to Hot Foots, the premier mobile app for food ordering on the go. Our mission is to make it easy for you to order delicious meals from your favorite restaurants, anytime and anywhere."),
                  SizedBox(
                    height: 20,
                  ),
                  AboutCard(
                    text:
                       "At Hot Foots, we believe that food is more than just sustenance. It's a way of life, a way to connect with others, and a way to experience the world's rich culinary traditions. That's why we've built a platform that celebrates food in all its forms and brings people together around the table."),
                  SizedBox(
                    height: 20,
                  ),
                  AboutCard(
                    text:
                  "Our app features a curated selection of restaurants, from classic American diners to trendy sushi bars and everything in between. We work closely with our partner restaurants to ensure that every dish is made with the freshest ingredients and the utmost care. Whether you're in the mood for comfort food or something a little more adventurous, Hot Foots has you covered."),
                   SizedBox(
                    height: 20,
                  ),
                  AboutCard(
                    text:
                      "At Hot Foods, we're more than just a food delivery app. We're a community of food lovers, passionate about sharing our love of good food with others. We're constantly updating our app with new features and offerings to make your experience even better. So whether you're a seasoned foodie or just looking for a quick bite, we invite you to join us and discover the best of what the culinary world has to offer.")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              menu: true,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final String text;

  const AboutCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: AppColor.base,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
