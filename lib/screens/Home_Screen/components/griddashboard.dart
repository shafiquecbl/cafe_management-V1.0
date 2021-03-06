import 'package:cafe_management/constants.dart';
import 'package:cafe_management/screens/Home_Screen/components/Buy%20Now/buy_now.dart';
import 'package:cafe_management/screens/Home_Screen/components/History/history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      staggeredTiles: [
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
      ],
      children: [
        buy(context),
        history(context),
      ],
    );
  }

  buy(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BuyNow.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: hexColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart_outlined,
              color: kIconColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Buy Now",
              textAlign: TextAlign.center,
              style: GoogleFonts.teko(
                  color: kTextColor, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  history(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, History.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: hexColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.history_outlined,
              color: kIconColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "History",
              textAlign: TextAlign.center,
              style: GoogleFonts.teko(
                  color: kTextColor, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
