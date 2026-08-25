import 'package:clean_architecture_and_solid_principles/movie%20app/control_view.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'movie app/core/services/binding.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized for background tasks
  await Firebase.initializeApp();
  print("Background message received: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 1. Initialize Firebase App
  await Firebase.initializeApp();

  // 2. Set Background Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // 2. Initialize the GetIt Service Locator configuration graph
  setupServiceLocator();
  runApp(const MyApp());
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
