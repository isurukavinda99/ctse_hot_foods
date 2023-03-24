import 'package:flutter/cupertino.dart';

import '../const/colors.dart';
import '../utils/Utill.dart';

class ResturuntCardWidget extends StatelessWidget {
  const ResturuntCardWidget({
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
          )
        ],
      ),
    );
  }
}