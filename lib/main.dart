
import 'package:flutter/material.dart';
import 'package:flutter_appq/view/home_screen.dart';

import 'package:get/get.dart';


import 'controller/binding.dart';
import 'controller/country_controller.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CountryController countryController = Get.put(CountryController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
