
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appq/db/database.dart';
import 'package:flutter_appq/model/country_model.dart';
import 'package:http/http.dart' as http;


class CountryControllerProvider extends ChangeNotifier{

  bool isData = true;
  bool isLoading = false;
  var countryList = List<CountryModel>();
  DatabaseHelper dataBaseHelper = DatabaseHelper.instance;


  Future<List<CountryModel>> getCountry() async {
    Map<String, String> queryParams = {
      'token': 'NeRreatrfpEAEiNuR5RYuxOxgigp6PFX'
    };

    isData = false;
    Uri url = Uri.parse('http://37.156.29.51:4450/api/countries');
    var response;
    try {
      response = await http.get(
          url,
          headers: queryParams
      );
    } catch (e) {
      checkDataBase();
    }


    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var encod = json.encode(jsonResponse['data']['countries']);
      addToDataBase();
      isData = true;
      return countryModelFromJson(encod);
    } else {
      var db = await dataBaseHelper.queryAllRows();
      if (db.isNotEmpty && db != null) {
        checkDataBase();
      }
    }
    }

    fetchdata() async {
      isLoading = true;
      try {
        var data = await getCountry();
        if (data != null) {
          countryList.addAll(data);
          notifyListeners();
        } else {
          countryList = new List();
          notifyListeners();
        }
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
    addToDataBase() async {
      var db = await dataBaseHelper.queryAllRows();
      if (db.isEmpty || db == null) {
        countryList.forEach((element) {
          dataBaseHelper.insert({
            DatabaseHelper.columnCountryName: element.name,
            DatabaseHelper.columnCountryId: element.countryId,
          });
          notifyListeners();
        });
      }
    }


    checkDataBase() async {
      var db = await dataBaseHelper.queryAllRows();
      db.forEach((element) {
        countryList.add(CountryModel(
            id: element[DatabaseHelper.columnId], countryId:
        element[DatabaseHelper.columnCountryId],
            name: element[DatabaseHelper.columnCountryName]));
        notifyListeners();
      });
      isData = true;
    }

}