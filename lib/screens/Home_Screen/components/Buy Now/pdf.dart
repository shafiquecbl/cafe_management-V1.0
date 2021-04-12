import 'package:cafe_management/constants.dart';
import 'package:cafe_management/screens/Home_Screen/components/Buy%20Now/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;
  final pdf;
  final String reason;
  final int amount;

  PdfPreviewScreen({this.path, this.pdf, this.reason, this.amount});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: kPrimaryColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Confirm Details',
            style: GoogleFonts.teko(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: hexColor,
        actions: [
          RaisedButton(
            child: Text('Print'),
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
          ),
          RaisedButton(
            child: Text('Buy Now'),
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => Loading(
                            reason: reason,
                            amount: amount,
                            context: context,
                          )));
            },
          )
        ],
      ),
      path: path,
    );
  }
}
