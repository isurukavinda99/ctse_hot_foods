import 'package:flutter/material.dart';
import 'package:hot_foods/screens/menu/BeverageScreen.dart';
import 'package:hot_foods/screens/menu/PromotionScreen.dart';
import 'package:hot_foods/screens/menu/ResturantScreen.dart';
import 'package:hot_foods/screens/other/MyPastOrders.dart';

import './screens/spashScreen.dart';
import './screens/landingScreen.dart';
import 'screens/login/loginScreen.dart';
import 'screens/login/signUpScreen.dart';
import 'screens/menu/menuScreen.dart';
import 'screens/other/MoreScreen.dart';
import './screens/profileScreen.dart';
import 'screens/menu/DessertsScreen.dart';
import 'screens/other/individualItem.dart';
import 'screens/other/paymentScreen.dart';
import 'screens/other/aboutScreen.dart';
import 'screens/other/MyOrderScreen.dart';
import 'screens/other/checkoutScreen.dart';
import './const/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hot Foods',
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColor.base,
            ),
            shape: MaterialStateProperty.all(
              StadiumBorder(),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              AppColor.base,
            ),
          ),
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            color: AppColor.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headline5: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          headline6: TextStyle(
            color: AppColor.primary,
            fontSize: 25,
          ),
          bodyText2: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        MenuScreen.routeName: (context) => MenuScreen(),
        PromotionScreen.routeName: (context) => PromotionScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        MoreScreen.routeName: (context) => MoreScreen(),
        DessertsScreen.routeName: (context) => DessertsScreen(),
        IndividualItem.routeName: (context) => IndividualItem(),
        PaymentScreen.routeName: (context) => PaymentScreen(),
        AboutScreen.routeName: (context) => AboutScreen(),
        MyOrderScreen.routeName: (context) => MyOrderScreen(),
        CheckoutScreen.routeName: (context) => CheckoutScreen(),
        BeverageScreen.routeName: (context) => BeverageScreen(),
        RestruantScreen.routeName: (context) => RestruantScreen(),
        MyPastOrders.routeName: (context) => MyPastOrders(),
      },
    );
  }
}
