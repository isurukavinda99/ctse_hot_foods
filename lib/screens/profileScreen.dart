import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hot_foods/const/LogginConst.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/screens/login/loginScreen.dart';
import 'package:hot_foods/screens/menu/menuScreen.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';
import 'package:hot_foods/widgets/CustomTextInput.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profileScreen";

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Utill.getScreenHeight(context),
              width: Utill.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: Utill.getTheme(context).headline5,
                          ),
                          Image.asset(
                            Utill.getAssetName("cart.png", "staticIcons"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Utill.getAssetName("edit_filled.png", "staticIcons"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(color: AppColor.base),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                          child: Text("Sign Out")),
                      SizedBox(
                        height: 40,
                      ),
                      CustomTextInput(
                        hintText: "Name",
                        controller: userNameController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                        hintText: "Mobile No",
                        controller: mobileNumberController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                        hintText: "Address",
                        controller: addressController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:  () async{
                            var userName = userNameController.text.trim();
                            var email = emailController.text.trim();
                            var address = addressController.text.trim();
                            var phoneNumber = mobileNumberController.text.trim();

                            if (userName.isEmpty ||
                                email.isEmpty) {
                              print("Please fill required fields");
                              return;
                            }

                            try {
                              FirebaseAuth auth = FirebaseAuth.instance;

                                // store user information in Firestore database

                                FirebaseFirestore firestore =
                                    FirebaseFirestore.instance;

                                String userId = LoginConst.uid;

                                firestore.collection('users').doc(userId).set({
                                  'userId': userId,
                                  'userName': userName,
                                  'email': email,
                                  'address' : address,
                                  'phoneNumber' : phoneNumber
                                });

                                Navigator.of(context)
                                    .pushReplacementNamed(MenuScreen.routeName);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                print("Email is already in exist");
                              } else if (e.code == 'weak-password') {
                                print("Password is weak");
                              }
                            } catch (e) {
                              print("Connection error");
                            }
                          },
                          child: Text("Save"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              profile: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key key,
    String label,
    String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
