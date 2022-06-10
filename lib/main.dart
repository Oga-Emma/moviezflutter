import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/di/app_module.dart';
import 'package:moviezflutter/ui/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Moviez',
      initialBinding: AppBindings(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
