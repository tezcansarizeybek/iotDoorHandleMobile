import 'dart:async';

import 'package:get/get.dart';
import 'package:iotmobile/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() async {
    var c = Get.put(HomeController(), permanent: true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    c.address.value = prefs.getString("address") ?? "";
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (c.address.value.isNotEmpty) {
        c.getTempHum();
      }
    });
  }
}
