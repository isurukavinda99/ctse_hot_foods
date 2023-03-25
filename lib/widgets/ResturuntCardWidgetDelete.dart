import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_foots/screens/menu/menuScreen.dart';

import '../const/colors.dart';
import '../utils/Utill.dart';

class ResturuntCardWidgetDelete extends StatelessWidget {
  const ResturuntCardWidgetDelete({
    Key key,
    String name,
    Image image,
    String address,
  })  : _image = image,
        _name = name,
        _address = address,
        super(key: key);

  final String _name;
  final Image _image;
  final String _address;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 200, width: double.infinity, child: _image),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  _name,
                  style: Utill.getTheme(context)
                      .headline4
                      .copyWith(color: AppColor.primary),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  _address,
                  style: TextStyle(
                    color: AppColor.base,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30, width: double.infinity, child: ElevatedButton(
            onPressed: () async{
              final CollectionReference
              restuarantCol = FirebaseFirestore
                  .instance
                  .collection('restaurant');

              // await restuarantCol
              //     .doc(
              //     creditCard.cardNo)
              //     .delete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColor.success,
                  content: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        ' successfully deleted',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );

              Navigator.of(context)
                  .pushReplacementNamed(
                  MenuScreen.routeName);
            },
            child: Icon(Icons.delete),
          ), ),
        ],
      ),
    );
  }
}