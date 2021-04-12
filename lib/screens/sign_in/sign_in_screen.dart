import 'package:cafe_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:cafe_management/size_config.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Sign In',
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Body(),
    );
  }
}
