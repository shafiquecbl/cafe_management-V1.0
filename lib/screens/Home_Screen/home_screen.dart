import 'package:cafe_management/size_config.dart';
import 'package:cafe_management/widgets/offline.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/home_scrreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Container(child: connected ? Body() : offline);
              },
              child: Container()),
        ));
  }
}
