import 'dart:io';
import 'dart:math';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../lib.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Request notification permissions from the user
  void requestNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Handle different authorization statuses
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  // Retrieve the device's FCM token
  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    debugPrint('Device Token: $token');
    return token;
  }

  // Listen for token refresh events
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      debugPrint('Device Token Refresh: $event');
    });
  }

  // Function to initialize the local notifications plugin
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    // Android initialization settings using the app's launcher icon
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS initialization settings
    var iosInitializationSettings = const DarwinInitializationSettings();
    // Create initialization settings combining Android and iOS settings
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    // Initialize the local notifications plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      // Callback triggered when a notification response is received
      onDidReceiveNotificationResponse: (payloud) {
        // handleMessage(context, message); // Handle notification response
      },
    );
  }

  // Initialize Firebase Foreground Messaging
  void firebaseInit(BuildContext context) {
    // Listen for incoming messages
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('Message: ${message.data.toString()}');
      // Handle the notification differently for Android and iOS
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        debugPrint('platform');
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  // Function to display a local notification based on a Firebase message
  Future<void> showNotification(RemoteMessage message) async {
    // Create an Android notification channel with high importance
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );

    // Create Android notification details
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    // Create notification details for both Android and iOS platforms
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Create a `NotificationDetails` object to consolidate platform-specific notification settings:
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    // Ensure notification is displayed immediately
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        //unique ID
        -1,
        // Set the notification title
        message.data['title'].toString(),
        // Set the notification body
        message.data['body'].toString(),
        // Set the notification details
        notificationDetails,
        // Provide a callback function to handle notification tap events:
        // payload: message.data, // Optional payload data
        // androidAllowWhileIdle:
        //     true, // Optional: allow notification in Doze mode
        // onTap: (payload) async {
        //   // Handle notification tap here
        // },
      );
    });
  }

  //Go to message screen when function is called when the app receives a message while in the foreground
  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msg') {
      debugPrint('Same as msg');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageScreen(
            id: message.data['id'],
          ),
        ),
      );
    }
  }

  // This function uses the `FirebaseMessaging` class to receive messages.
  Future<void> setupInteractMessage(BuildContext context) async {
    // When the app is terminated `handleMessage` function is called
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //When app is in background the `handleMessage`
    // function is called
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }
}
