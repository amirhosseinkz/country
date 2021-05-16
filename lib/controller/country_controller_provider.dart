
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appq/model/country_model.dart';
import 'package:http/http.dart' as http;


class CountryControllerProvider extends ChangeNotifier{

  bool isLoading = false;
  var countryList = List<CountryModel>();


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
      var  jsonResponse = json.decode(response.body);
      var encod = json.encode(jsonResponse['data']['countries']);
      return countryModelFromJson(encod);
    }else{
      print("error");
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


}