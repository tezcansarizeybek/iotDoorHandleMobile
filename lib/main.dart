import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotmobile/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          appBarTheme: AppBarTheme(backgroundColor: Colors.orange.shade200)),
      darkTheme: ThemeData.dark(useMaterial3: true),
      title: 'Kapı Açma Uygulaması',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
