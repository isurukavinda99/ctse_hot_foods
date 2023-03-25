import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../screens/menu/PromotionScreen.dart';
import '../../utils/Utill.dart';
import '../../widgets/CustomTextInput.dart';

class UpdatePromotionScreen extends StatelessWidget {
  static const routeName = '/UpdatePromotionScreen';

  var NameController = TextEditingController();
  var UrlController = TextEditingController();
  var DiscountController = TextEditingController();
  var ShopController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Utill.getScreenWidth(context),
      height: Utill.getScreenHeight(context),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            children: [
              Text(
                "Promotions",
                style: Utill.getTheme(context).headline6,
              ),
              Text(
                "Update Promotions here",
              ),
              Spacer(),
              CustomTextInput(hintText: "Name" , controller: NameController,),
              Spacer(),
              CustomTextInput(hintText: "Image Url" , controller: UrlController,),
              Spacer(),
              CustomTextInput(hintText: "Discount" , controller: DiscountController,),
              Spacer(),
              CustomTextInput(hintText: "Shop" , controller: ShopController,),
              Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    var Name = NameController.text.trim();
                    var Url = UrlController.text.trim();
                    var Discount = DiscountController.text.trim();
                    var Shop = ShopController.text.trim();

                    if (Name.isEmpty ||
                        Url.isEmpty) {
                      print("Please fill required fields");
                      return;
                    }
          
                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;

                        firestore.collection('promotion').doc(Name).set({
                          'discount': Discount,
                          'imgUrl': Url,
                          'name': Name,
                          'shop': Shop
                         
                        });

                        Navigator.of(context)
                            .pushReplacementNamed(PromotionScreen.routeName); 
                   
                  },
                  child: Text("Add"),
                ),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushReplacementNamed(PromotionScreen.routeName);
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text("Already have an Account?"),
              //       Text(
              //         "Login",
              //         style: TextStyle(
              //           color: AppColor.base,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    ));
  }
}
