import 'package:clean_architecture_and_solid_principles/movie%20app/core/services/service_locator.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/controller/movie_controller.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/screens/movie_detail_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationController(FirebaseMessaging messaging) : _messaging = messaging;
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Reactive state variables
  /// FCM: abbreviation to Firebase Cloud Messaging
  RxString fcmToken = ''.obs;
  RxBool isPermissionGranted = false.obs;

  // Define high-priority channel for Android
  static const AndroidNotificationChannel _importanceChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: "This channel is used for important notifications",
        importance: Importance.max,
      );

  @override
  void onInit() {
    super.onInit();
    _initLocalNotifications();
    setupFCM();
    _initNotificationListeners();
  }

  Future<void> setupFCM() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      isPermissionGranted.value = true;
      print('User granted notification permissions');
      _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      // Automatically subscribe every app user to general announcements
      await subscribeToTopic('all_users');

      String? token = await _messaging.getToken();
      if (token != null) {
        fcmToken.value = token;
        print('========================================');
        print('YOUR FCM TOKEN: $token');
        print('========================================');
      }
      _messaging.onTokenRefresh.listen((newToken) {
        fcmToken.value = newToken;
        print('FCM Token Refreshed: $newToken');
      });
    } else {
      isPermissionGranted.value = false;
      print('User declined or has not accepted notification permissions');
    }
    // Display alert banners even when app is in foreground (iOS/Android 13+)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// Handling Notification States
  void _initNotificationListeners() {
    // -------------------------------------------------------------
    // 1. FOREGROUND STATE
    // Called when a push notification arrives while app is open.
    // By default, Android DOES NOT show banner alerts in foreground.
    // -------------------------------------------------------------
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground notification received: ${message.notification?.title}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        _localNotifications.show(
          id: notification.hashCode,
          body: notification.body,
          title: notification.title,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              _importanceChannel.id,
              _importanceChannel.name,
              channelDescription: _importanceChannel.description,
              icon: androidNotification.smallIcon ?? '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: message.data.toString(),
        );
      }
      // OPTIONAL: Display in-app snack bar or banner
      // if (message.notification != null) {
      //   Get.snackbar(
      //     message.notification!.title ?? 'New Message',
      //     message.notification!.body ?? '',
      //     snackPosition: SnackPosition.TOP,
      //   );
      // }
    });
    // -------------------------------------------------------------
    // 2. BACKGROUND STATE (App opened from notification click)
    // Called when the app is running in background and user taps the notification.
    // -------------------------------------------------------------
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background via notification: ${message.data}');
      _handleNotificationNavigation(message.data);
    });
    // -------------------------------------------------------------
    // 3. TERMINATED STATE (App opened from dead state)
    // Checks if the app was launched by tapping a notification while killed.
    // -------------------------------------------------------------
    _checkInitialMessage();
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    MovieController controller = getIt<MovieController>();
    if (data.containsKey('movieId')) {
      controller.fetchMovieDetails(data['movieId'].toInt());
      Get.to(MovieDetailScreen());
      print('Data: $data');
      print('Navigating to Movie ID: ${data['movieId']}');
    }
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? initMessage = await _messaging.getInitialMessage();
    if (initMessage != null) {
      print(
        'App launched from terminated state via notification: ${initMessage.data}',
      );
      _handleNotificationNavigation(initMessage.data);
    }
  }

  /// Handling Local Notifications Banners & High-Priority Heads-Up Alerts.
  Future<void> _initLocalNotifications() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );
    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle local notification click
        print('Local Notification Payload: ${response.payload}');
      },
    );
    //create channel on android device
    final AndroidFlutterLocalNotificationsPlugin? androidImplementations =
        _localNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidImplementations?.createNotificationChannel(_importanceChannel);
  }

  /// Topic Subscription

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print("Subscribed to topic: $topic");
    } catch (e) {
      print("Error subscribing to topic: $e");
    }
  }

  Future<void>unSubscribeToTopic(String topic)async{
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print("Subscribed to topic: $topic");
    } catch (e) {
      print("Error subscribing to topic: $e");
    }
  }
}
