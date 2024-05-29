import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotmobile/modules/home/home_controller.dart';
import 'package:iotmobile/shared/constants/index.dart';
import 'package:iotmobile/shared/extensions/paddings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.APPDESC),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var add = prefs.getString("address");
                TextEditingController addTxt = TextEditingController(text: add);
                Get.dialog(Dialog(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: 8.padAll,
                          child: TextField(
                            controller: addTxt,
                            decoration: const InputDecoration(
                                labelText: AppStrings.ADDRESSDESC),
                          ),
                        ),
                        Padding(
                          padding: 8.padAll,
                          child: ElevatedButton(
                              onPressed: () async {
                                Get.find<HomeController>().setAddress(addTxt);
                                Get.back();
                              },
                              child: const Text(AppStrings.ACCEPT)),
                        )
                      ],
                    ),
                  ),
                ));
              },
              child: const Text(AppStrings.SELECTADDRESS)),
          Get.find<HomeController>().temp.value != -999 &&
                  Get.find<HomeController>().humidity.value != -999
              ? Obx(
                  () => Padding(
                    padding: 16.padAll,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Sıcaklık: ${Get.find<HomeController>().temp.value}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Nem: ${Get.find<HomeController>().humidity.value}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              : Container(),
          ElevatedButton(
            onPressed: () async {
              await Get.find<HomeController>().openDoor();
            },
            child: const Text(AppStrings.OPENDOOR),
          ),
        ],
      ),
    );
  }
}
