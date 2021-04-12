import 'package:cafe_management/main.dart';
import 'package:cafe_management/screens/Home_Screen/components/Buy%20Now/buy_now.dart';
import 'package:cafe_management/screens/Home_Screen/components/History/history.dart';
import 'package:flutter/widgets.dart';
import 'package:cafe_management/screens/Faculty%20Home%20Screen/faculty_homeScreen.dart';
import 'package:cafe_management/screens/forgot_password/forgot_password_screen.dart';
import 'package:cafe_management/screens/sign_in/sign_in_screen.dart';
import 'package:cafe_management/screens/Home_Screen/home_screen.dart';

import 'screens/Faculty Home Screen/components/Add Amount in Student Fund/add_amount.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  FHomeScreen.routeName: (context) => FHomeScreen(),
  AddAmount.routeName: (context) => AddAmount(),
  History.routeName: (context) => History(),
  BuyNow.routeName: (context) => BuyNow(),
  Home.routeName: (context) => Home(),
};
