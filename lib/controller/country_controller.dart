
import 'package:flutter_appq/db/country_db.dart';
import 'package:flutter_appq/db/database.dart';
import 'package:flutter_appq/model/country_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryController extends GetxController {
  var countryList = List<CountryModel>().obs;
  var isLoading = true.obs;


  Future<List<CountryModel>> getCountry() async {



    Map<String, String> queryParams = {
      'token':'NeRreatrfpEAEiNuR5RYuxOxgigp6PFX'
    };


    Uri url = Uri.parse('http://37.156.29.51:4450/api/countries');
    final response = await http.get(
      url,
      headers: queryParams
      );



    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var encod = jsonEncode(jsonResponse['data']['countries']);
      return countryModelFromJson(encod);
    }
  }

  fetchdata() async {
    isLoading.value = true;
    try {
       var data = await getCountry();
        print(data.length.toString());
        if (data != null) {
          countryList(data);
        } else {
          countryList(new List());
        }
    } finally {
      isLoading(false);
    }
  }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //  // refreshCountry();
  // }
  //
  //  Future refreshCountry() async {
  //   isLoading.value = true;
  //   for(int i = 0; i< countryList.length ; i++)
  //   {
  //
  // Map < String, dynamic> record={
  //     DatabaseHelper.columnCountryId
  //   : countryList[i].countryId,
  //   DatabaseHelper.columnCountryName
  //       : countryList[i].name,
  //   }.obs;
  //   DatabaseHelper.insert(record);
  //  }
  // }
}
