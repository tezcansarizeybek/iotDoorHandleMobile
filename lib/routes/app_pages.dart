import 'package:get/get.dart';
import 'package:iotmobile/modules/home/home_binding.dart';
import 'package:iotmobile/modules/home/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAINPAGE;

  static final List<GetPage<dynamic>> routes = <GetPage>[
    // Auth Routes
    GetPage(
      name: Routes.MAINPAGE,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
