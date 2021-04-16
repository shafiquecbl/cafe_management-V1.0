import 'package:cafe_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'Add Amount in Student Fund/add_amount.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        staggeredTiles: [
          StaggeredTile.extent(2, 120),
        ],
        children: [
          addAmountInStudentFund(context),
        ],
      ),
    );
  }

  addAmountInStudentFund(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddAmount.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Add Amount In Student Fund",
              textAlign: TextAlign.center,
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }
}
