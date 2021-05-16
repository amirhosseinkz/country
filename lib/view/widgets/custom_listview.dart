import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appq/controller/country_controller_provider.dart';
import 'package:flutter_appq/view/style/colors.dart';
import 'package:flutter_appq/view/style/textstyle.dart';

import 'package:provider/provider.dart';

Widget customListView(BuildContext context) {


  final state = Provider.of<CountryControllerProvider>(context, listen: true);

  Size size = MediaQuery.of(context).size;

  state.fetchdata();

  return Stack(children: [
    Container(
      child: state.countryList.length > 0
          ? ListView.builder(
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
                            child: ListTile(
                              title: AutoSizeText(
                                state.countryList[index].name,
                                style: listViewTitleStyle,
                              ),
                              leading: Text(
                                state.countryList[index].id.toString() + '-',
                                style: listViewLeadStyle,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: AutoSizeText(
                                  'Country_id:' +
                                      state.countryList[index].countryId
                                          .toString(),
                                  style: listViewSubStyle,
                                ),
                              ),
                            ),
                          ),
                        )));
              },
              itemCount: state.countryList.length,
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.blue,
                ),
              ),
            ),
    ),
  ]);
}
