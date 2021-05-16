
import 'package:flutter/material.dart';
import 'package:flutter_appq/view/style/colors.dart';
import 'package:flutter_appq/view/widgets/custom_listview.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: customListView(context));
  }
}