import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hot_foots/const/LogginConst.dart';
import 'package:hot_foots/const/colors.dart';
import 'package:hot_foots/screens/login/loginScreen.dart';
import 'package:hot_foots/screens/menu/menuScreen.dart';
import 'package:hot_foots/utils/Utill.dart';
import 'package:hot_foots/widgets/CustomNavBar.dart';
import 'package:hot_foots/widgets/CustomTextInput.dart';

import '../menu/ResturantScreen.dart';

class ResturantEditScreen extends StatelessWidget {
  static const routeName = "/add_restaurant";

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var imageCpntroller = TextEditingController();


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
                            "Add Restaurant",
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
                            "Add Restaurant",
                            style: TextStyle(color: AppColor.base),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomTextInput(
                        hintText: "Restaurant Name",
                        controller: nameController,
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
                      CustomTextInput(
                        hintText: "Cover Image",
                        controller: imageCpntroller,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:  () async{
                            var restaruant = nameController.text.trim();
                            var imgUrl = imageCpntroller.text.trim();
                            var address = addressController.text.trim();

                            if (restaruant.isEmpty ||
                                imgUrl.isEmpty || address.isEmpty) {
                              print("Please fill required fields");
                              return;
                            }

                            try {
                              FirebaseFirestore rest = FirebaseFirestore.instance;

                              // store user information in Firestore database

                              rest.collection('restaurant').add({
                                'name': nameController.text,
                                'imgUrl': imageCpntroller.text,
                                'address': addressController.text,
                              }).then((value) {
                                print('Credit card added: ${value.id}');
                                Navigator.of(context).pushReplacementNamed(
                                    RestruantScreen.routeName);
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                    msg: "Restaurant add",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                );
                                print('Error adding credit card: $error');
                              });

                              Navigator.of(context).pop();
                            } on FirebaseFirestore catch (e) {
                              Fluttertoast.showToast(
                                  msg: "Restaurant add failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.black,
                                  fontSize: 16.0
                              );
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
