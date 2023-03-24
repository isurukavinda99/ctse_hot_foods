import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    @required String hintText,
    EdgeInsets padding = const EdgeInsets.only(left: 40),
    TextEditingController controller,
    bool isPassword = false,
    Key key,
  })  : _hintText = hintText,
        _padding = padding,
        _controller = controller,
        _isPassword = isPassword,
        super(key: key);

  final String _hintText;
  final EdgeInsets _padding;
  final TextEditingController _controller;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        controller: _controller,
        obscureText: _isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
            color: AppColor.placeholder,
          ),
          contentPadding: _padding,
        ),
      ),
    );
  }
}

