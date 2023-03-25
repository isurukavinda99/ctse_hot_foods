import 'package:flutter/material.dart';
import 'package:hot_foods/const/LogginConst.dart';
import 'package:hot_foods/screens/menu/menuScreen.dart';
import 'package:hot_foods/screens/other/MyOrderScreen.dart';
import '../../const/colors.dart';
import '../../utils/Utill.dart';
import '../../widgets/CustomTextInput.dart';
import 'package:hot_foots/screens/menu/menuAdminScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_foots/screens/login/signUpScreen.dart';
import '../menu/PromotionScreen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";

  var emailValidationController = TextEditingController();
  var passwordValidationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Utill.getScreenHeight(context),
        width: Utill.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: Utill.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Add your details to login'),
                Spacer(),
                CustomTextInput(
                  hintText: "Your email",
                  controller: emailValidationController,
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "password",
                  controller: passwordValidationController,
                  isPassword: true,
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      var email = emailValidationController.text.trim();
                      var password = passwordValidationController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        // show error toast
                        print("please fill email and password");
                        return;
                      }

                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        LoginConst.user = userCredential;
                        LoginConst.uid = userCredential.user?.uid;

                        if (userCredential.user != null) {
                          if(email == "hotfoods@gmail.com" && password == "admin1234"){
                             Navigator.of(context)
                              .pushReplacementNamed(MenuAdminScreen.routeName);
                          }
                          else {
                            Navigator.of(context)
                              .pushReplacementNamed(MenuScreen.routeName);
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print("User not found");
                        } else if (e.code == 'wrong-password') {
                          print("Wrong password");
                        }
                      } catch (e) {
                        print('Connection error');
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Text("or Login With"),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFF367FC0,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Utill.getAssetName(
                            "fb.png",
                            "staticIcons",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Facebook")
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFFDD4B39,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Utill.getAssetName(
                            "google.png",
                            "staticIcons",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Google")
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.base,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
