
import 'package:flutter_appq/db/country_db.dart';
import 'package:flutter_appq/db/database.dart';
import 'package:flutter_appq/model/country_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryController extends GetxController {
  var countryList = List<CountryModel>().obs;
  var isLoading = true.obs;
  var dataBaseHelper = DatabaseHelper.instance.obs;
  var saidbymehrzad = true.obs;

  Future<List<CountryModel>> getCountry() async {

    Map<String, String> queryParams = {
      'token':'NeRreatrfpEAEiNuR5RYuxOxgigp6PFX'
    };

    saidbymehrzad.value = false;
    Uri url = Uri.parse('http://37.156.29.51:4450/api/countries');
    var response;
    try{
       response = await http.get(
          url,
          headers: queryParams
      );

    }catch(e){

      mohammadi();

    }




    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var encod = jsonEncode(jsonResponse['data']['countries']);
      mehrzad();
      saidbymehrzad.value = true;
      return countryModelFromJson(encod);
    }else {

      var db = await dataBaseHelper.value.queryAllRows();
      if (db.isNotEmpty && db != null) {
        mohammadi();

      }
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

mehrzad() async {
    var db = await dataBaseHelper.value.queryAllRows();
    if (db.isEmpty || db == null ) {
      countryList.forEach((element) {
        dataBaseHelper.value.insert({
          DatabaseHelper.columnCountryName: element.name ,
          DatabaseHelper.columnCountryId: element.countryId ,

        });
      });
    }
}


mohammadi() async {
  var db = await dataBaseHelper.value.queryAllRows();
  db.forEach((element) {
    countryList.add(CountryModel(
        id: element[DatabaseHelper.columnId],countryId:
    element[DatabaseHelper.columnCountryId],
        name: element[DatabaseHelper.columnCountryName]));

  });
  saidbymehrzad.value = true;
}

}
