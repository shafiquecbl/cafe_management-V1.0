import 'package:cafe_management/screens/Home_Screen/components/Buy%20Now/buy_now_form.dart';
import 'package:cafe_management/size_config.dart';
import 'package:cafe_management/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:cafe_management/widgets/offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuyNow extends StatelessWidget {
  static String routeName = "/buy_now";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Container(child: connected ? body(context) : offline);
        },
        child: Container());
  }

  Widget body(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Buy Now"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null)
            return SpinKitRing(
              lineWidth: 5,
              color: Colors.blue,
            );
          if (snapshot.data['Remaining Dues'] >= 10000)
            return Center(
              child: Text(
                'Your are Defaulter!\nPlease visit challan office to pay previous Funds.',
                style: GoogleFonts.teko(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      Text(
                        "Enter Details",
                        style: GoogleFonts.teko(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      BuyNowForm()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
