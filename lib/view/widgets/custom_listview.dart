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

  return state.isLoading || !state.isData ?
      Center(
       child: CircularProgressIndicator(),
     ): state.countryList.isEmpty ?
     Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             'لطفا اینترنت خود را روشن کنید',
             style: listViewTitleStyle,
           ),
           TextButton(
               onPressed: () {
                 state.fetchdata();
               },
               child: Text('تلاش مجدد'))
         ],
       ),
     ):
   ListView.builder(
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
                   padding: const EdgeInsets.symmetric(vertical: 8),
                   child: AutoSizeText(
                     'Country_id:' +
                         state.countryList[index].countryId.toString(),
                     style: listViewSubStyle,
                   ),
                 ),
               ),
             ),
           )));
     },
     itemCount: state.countryList.length,
   );
}
