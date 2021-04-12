import 'package:flutter/material.dart';
import 'package:cafe_management/size_config.dart';

const kPrimaryColor = Color(0xFF492E7D);
const kGreenColor = Color(0xFF388E3C);
const kWhiteColor = Colors.white;
const hexColor = Color(0xFFf5f4f4);
const kOfferColor = Color(0xFFE3E9F5);
const kOfferBackColor = Color(0xFFF5F9FC);
const kProfileColor = Color(0xFF2B2B2B);
const kTextFieldColor = Color(0xFF12A89D);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
