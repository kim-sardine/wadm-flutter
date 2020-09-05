import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/wadm_list_screen.dart';
import './screens/wadm_detail_screen.dart';
import './providers/wadms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Wadms(),
      child: MaterialApp(
        title: 'WADM',
        theme: ThemeData(
          primarySwatch: Colors.purple, // TODO: Please... Change the color
          accentColor: Colors.deepOrange,
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
