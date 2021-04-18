import 'package:cafe_management/constants.dart';
import 'package:cafe_management/screens/sign_in/sign_in_screen.dart';
import 'package:cafe_management/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'griddashboard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/curve.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 20, top: 20),
                        title: Text(
                          FirebaseAuth.instance.currentUser.displayName,
                          style: GoogleFonts.teko(
                              color: hexColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          "Teacher",
                          style: GoogleFonts.teko(
                              color: Colors.deepOrangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                          alignment: Alignment.topCenter,
                          icon: Icon(
                            Icons.logout,
                            color: hexColor,
                          ),
                          onPressed: () {
                            confirmSignout(context);
                          },
                        )),
                    Expanded(child: GridDashboard()),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

confirmSignout(BuildContext context) {
  // set up the button
  Widget yes = CupertinoDialogAction(
    child: Text("Yes"),
    onPressed: () {
      FirebaseAuth.instance.signOut().whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      }).catchError((e) {
        Snack_Bar.show(context, e.message);
      });
    },
  );

  Widget no = CupertinoDialogAction(
    child: Text("No"),
    onPressed: () {
      Navigator.maybePop(context);
    },
  );

  // set up the AlertDialog
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text("Signout"),
    content: Text("Do you want to signout?"),
    actions: [yes, no],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
