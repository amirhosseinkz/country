import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appq/controller/country_controller.dart';
import 'package:flutter_appq/view/style/colors.dart';
import 'package:flutter_appq/view/style/textstyle.dart';
import 'package:get/get.dart';

Widget customListView(BuildContext context) {
  CountryController countryController = Get.find();

  Size size = MediaQuery.of(context).size;
  countryController.fetchdata();

  return Obx(() {
    if (countryController.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: customListViewContainerColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: size.height * 0.18,
                  width: size.width * 0.8,
                  child: Card(
                      elevation: 5,
                      child: Center(
                        child: Obx(
                          () => ListTile(
                            title: AutoSizeText(
                              countryController.countryList[index].name,
                              style: listViewTitleStyle,
                            ),
                            leading: Text(
                              countryController.countryList[index].id
                                      .toString() +
                                  '-',
                              style: listViewLeadStyle,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: AutoSizeText(
                                'Country_id: ' +
                                    countryController
                                        .countryList[index].countryId
                                        .toString(),
                                style: listViewSubStyle,
                              ),
                            ),
                          ),
                        ),
                      ))));
        },
        itemCount: countryController.countryList.length,
      );
    }
  });
}
