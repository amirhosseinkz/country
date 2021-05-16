
import 'package:flutter/material.dart';
import 'package:flutter_appq/controller/country_controller_provider.dart';
import 'package:flutter_appq/view/home_screen.dart';
import 'package:provider/provider.dart';


void main()  {
  runApp(ChangeNotifierProvider(
  child: MyApp(),
    create: (context) => CountryControllerProvider(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
