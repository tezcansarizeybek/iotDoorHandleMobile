import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iotmobile/data/network/door_api.dart';
import 'package:iotmobile/model/temp_hum_model.dart';
import 'package:iotmobile/shared/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var address = "".obs;
  var humidity = (-999.0).obs;
  var temp = (-999.0).obs;

  getTempHum() async {
    if (address.value.isNotEmpty) {
      TempHumModel tempHumModel = await DoorApi().getTempHum();
      humidity.value = tempHumModel.humidity ?? 0;
      temp.value = tempHumModel.temperature ?? 0;
    }
  }

  openDoor() async {
    if (address.value.isNotEmpty) {
      try {
        await DoorApi().openDoor();
      } catch (e) {
        Get.snackbar(AppStrings.ALERT, AppStrings.ERROR);
        throw Exception(e);
      }
    }
  }

  setAddress(TextEditingController addTxt) async {
    var ad = addTxt.text;
    if (ad[0].isNumericOnly) {
      ad = "http://$ad";
    }
    Get.find<HomeController>().address.value = ad;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("address", ad);
  }
}
