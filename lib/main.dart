import 'package:clean_architecture_and_solid_principles/movie%20app/control_view.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'movie app/core/services/binding.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // 2. Initialize the GetIt Service Locator configuration graph
  setupServiceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie app',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey
            .shade900,
      ),
      initialBinding: InitialBinding(),
      home: const ControlView(),
    );
  }
}
