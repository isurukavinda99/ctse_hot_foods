import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const/colors.dart';
import 'loginScreen.dart';
import '../../utils/Utill.dart';
import '../../widgets/CustomTextInput.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUpScreen';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordReController = TextEditingController();
  var userNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var addressController = TextEditingController();

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
                "Sign Up",
                style: Utill.getTheme(context).headline6,
              ),
              Spacer(),
              Text(
                "Add your details to sign up",
              ),
              Spacer(),
              CustomTextInput(hintText: "Name" , controller: userNameController,),
              Spacer(),
              CustomTextInput(
                hintText: "Email",
                controller: emailController,
              ),
              Spacer(),
              CustomTextInput(hintText: "Mobile No" , controller: mobileNumberController,),
              Spacer(),
              CustomTextInput(hintText: "Address" , controller: addressController,),
              Spacer(),
              CustomTextInput(
                hintText: "Password",
                controller: passwordController,
              ),
              Spacer(),
              CustomTextInput(
                hintText: "Confirm Password",
                controller: passwordReController,
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    var userName = userNameController.text.trim();
                    var email = emailController.text.trim();
                    var password = passwordController.text.trim();
                    var confirmPassword = passwordReController.text.trim();
                    var address = addressController.text.trim();
                    var phoneNumber = mobileNumberController.text.trim();

                    if (userName.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      print("Please fill required fields");
                      return;
                    }

                    if (password != confirmPassword) {
                      print("Passwords does not match");

                      return;
                    }

                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      if (userCredential.user != null) {
                        // store user information in Firestore database

                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;

                        String userId = userCredential.user?.uid;

                        firestore.collection('users').doc(userId).set({
                          'userId': userId,
                          'userName': userName,
                          'email': email,
                          'password': password,
                          'address' : address,
                          'phoneNumber' : phoneNumber
                        });

                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      } else {}
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
                  child: Text("Sign Up"),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account?"),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: AppColor.base,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
