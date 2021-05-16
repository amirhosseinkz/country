


import 'package:get/get.dart';


import 'country_controller.dart';

class Binding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CountryController>(() => CountryController());
  }
}