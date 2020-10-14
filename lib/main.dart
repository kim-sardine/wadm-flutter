import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/wadm_list_screen.dart';
import './screens/wadm_detail_screen.dart';
import './providers/wadms.dart';

Map<int, Color> primaryColorCodes = {
  50: Color.fromRGBO(0, 29, 111, .1),
  100: Color.fromRGBO(0, 29, 111, .2),
  200: Color.fromRGBO(0, 29, 111, .3),
  300: Color.fromRGBO(0, 29, 111, .4),
  400: Color.fromRGBO(0, 29, 111, .5),
  500: Color.fromRGBO(0, 29, 111, .6),
  600: Color.fromRGBO(0, 29, 111, .7),
  700: Color.fromRGBO(0, 29, 111, .8),
  800: Color.fromRGBO(0, 29, 111, .9),
  900: Color.fromRGBO(0, 29, 111, 1),
};

MaterialColor primaryColor = MaterialColor(0XFF001d6f, primaryColorCodes);

Map<int, Color> accentColorCodes = {
  50: Color.fromRGBO(255, 193, 59, .1),
  100: Color.fromRGBO(255, 193, 59, .2),
  200: Color.fromRGBO(255, 193, 59, .3),
  300: Color.fromRGBO(255, 193, 59, .4),
  400: Color.fromRGBO(255, 193, 59, .5),
  500: Color.fromRGBO(255, 193, 59, .6),
  600: Color.fromRGBO(255, 193, 59, .7),
  700: Color.fromRGBO(255, 193, 59, .8),
  800: Color.fromRGBO(255, 193, 59, .9),
  900: Color.fromRGBO(255, 193, 59, 1),
};

MaterialColor accentColor = MaterialColor(0XFFffc13b, accentColorCodes);


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Wadms(),
      child: MaterialApp(
        title: 'wadm!',
        theme: ThemeData(
          primaryColor: primaryColor, // TODO: Please... Change the color
          accentColor: accentColor,
          fontFamily: 'Lato',
        ),
        home: WadmListScreen(),
        routes: {
          WadmListScreen.routeName: (ctx) => WadmListScreen(),
          WadmDetailScreen.routeName: (ctx) => WadmDetailScreen(),
        },
      ),
    );
  }
}
