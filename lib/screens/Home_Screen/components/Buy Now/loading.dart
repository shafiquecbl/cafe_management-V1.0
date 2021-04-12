import 'package:cafe_management/models/setData.dart';
import 'package:cafe_management/screens/Home_Screen/home_screen.dart';
import 'package:cafe_management/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  final String reason;
  final int amount;
  final BuildContext context;
  Loading(
      {@required this.reason, @required this.amount, @required this.context});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    addFund();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child:
          Scaffold(body: Center(child: isLoading == true ? load() : success())),
    );
  }

  Widget load() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Text('Please wait...')
      ],
    );
  }

  Widget success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/success.png',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Success!',
          style: GoogleFonts.teko(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Container(
          width: getProportionateScreenWidth(170),
          height: getProportionateScreenHeight(54),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            border: Border.all(width: 1.5, color: Colors.grey[300]),
          ),
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => MainScreen()),
                  (route) => false);
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(16),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  addFund() {
    SetData()
        .addFund(
            context: widget.context,
            regNo: FirebaseAuth.instance.currentUser.email.split('@').first,
            reason: widget.reason,
            amount: widget.amount)
        .then((value) => {
              setState(() {
                isLoading = false;
              })
            });
  }
}
