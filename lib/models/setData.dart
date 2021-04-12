import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class SetData {
  User user = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  static DateTime now = DateTime.now();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(now);

  Future addFund(
      {context, @required regNo, @required reason, @required amount}) async {
    int dues;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .get()
        .then((value) => {dues = value['Remaining Dues']});
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .update({'Remaining Dues': dues + amount});
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .collection('Funds');
    return await ref.add({
      'Reason': reason,
      'Amount': amount,
      'Date': dateTime,
    });
  }
}
