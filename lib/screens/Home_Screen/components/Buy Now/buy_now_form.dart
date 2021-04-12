import 'package:cafe_management/screens/Home_Screen/components/Buy%20Now/pdf.dart';
import 'package:flutter/material.dart';
import 'package:cafe_management/components/default_button.dart';
import 'package:cafe_management/components/form_error.dart';
import 'package:cafe_management/size_config.dart';
import 'package:cafe_management/widgets/outline_input_border.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_auth/firebase_auth.dart';

class BuyNowForm extends StatefulWidget {
  @override
  _BuyNowFormState createState() => _BuyNowFormState();
}

class _BuyNowFormState extends State<BuyNowForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String reason;
  int amount;
  String regNo = FirebaseAuth.instance.currentUser.email.split('@').first;

  ///////
  final pdf = pw.Document();
  final PdfColor baseColor = PdfColors.teal;
  final PdfColor accentColor = PdfColors.blueGrey900;
  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;
  ///////

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          _buildHeader(context),
          _contentHeader(context),
        ];
      },
    ));
  }

  Future savePdf() async {
    List<Directory> documentDirectory = await getExternalStorageDirectories();
    String dir = documentDirectory.first.path;

    final file = File("$dir/example.pdf");

    file.writeAsBytesSync(await pdf.save());
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          buildReasonFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAmountFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                writeOnPdf();
                await savePdf();

                List<Directory> documentDirectory =
                    await getExternalStorageDirectories();
                String dir = documentDirectory.first.path;
                String fullPath = "$dir/example.pdf";

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfPreviewScreen(
                              pdf: pdf,
                              path: fullPath,
                              reason: reason,
                              amount: amount,
                            )));
              }
            },
          ),
        ]));
  }
  //////////////////////////////////////////////////////////////////////////////

  TextFormField buildAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => amount = int.parse(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Enter Amount');
        }
        amount = int.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Enter Amount');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Amount",
        hintText: "Enter Amount",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.attach_money),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////

  Container buildReasonFormField() {
    return Container(
      height: 150,
      child: TextFormField(
        expands: true,
        minLines: null,
        maxLines: null,
        onSaved: (newValue) => reason = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: 'Enter Description');
          }
          reason = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: 'Enter Description');
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            border: outlineBorder,
            labelText: "Description",
            hintText: "Enter Description",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.description_outlined)),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'CUI Sahiwal Campus',
            style: pw.TextStyle(
              color: PdfColors.blue,
              fontWeight: pw.FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'INVOICE',
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        pw.Container(
          decoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
            color: accentColor,
          ),
          padding: const pw.EdgeInsets.only(
              left: 40, top: 10, bottom: 10, right: 20),
          alignment: pw.Alignment.centerLeft,
          height: 50,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _accentTextColor,
              fontSize: 12,
            ),
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                pw.Text('Reg #'),
                pw.Text(regNo.toUpperCase()),
                pw.Text('Date:'),
                pw.Text(_formatDate(DateTime.now())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.yMMMd('en_US');
    return format.format(date);
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 15),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Invoice to: ${regNo.toUpperCase()}',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        pw.Table.fromTextArray(
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
              color: baseColor,
            ),
            headerHeight: 25,
            cellHeight: 40,
            headers: [
              'Description'
            ],
            data: [
              [reason]
            ]),
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 15),
          child: pw.Text(
            'Total: Rs.$amount',
            style: pw.TextStyle(
                color: baseColor, fontWeight: pw.FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
