import 'package:get/get.dart';
import 'package:iotmobile/data/services/api_service.dart';
import 'package:iotmobile/model/temp_hum_model.dart';
import 'package:iotmobile/modules/home/home_controller.dart';

class DoorApi {
  openDoor() async {
    ApiService apiService = ApiService();
    final response = await apiService
        .get('${Get.find<HomeController>().address.value}/?command=open');
    if (response.statusCode == 200) {
      return 'Kapı açıldı!';
    } else {
      return 'Kapı açılamadı!';
    }
  }

  getTempHum() async {
    ApiService apiService = ApiService();
    final response = await apiService
        .get("${Get.find<HomeController>().address.value}/?command=getTempHum");
    if (response.statusCode == 200) {
      return TempHumModel.fromJson(response.data);
    } else {
      throw Exception("Hata");
    }
  }
}
