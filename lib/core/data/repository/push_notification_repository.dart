import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dawaa24/core/data/model/push_notification/recived_push_notification.dart';
import 'package:dawaa24/core/services/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../model/push_notification/selected_push_notification.dart';

@singleton
class PushNotificationRepository {
  static const String channelName = 'Sound Channel';

  // if you change this you should change it also in the AndroidManifest.xml file
  static const String channelId = 'sound_channel';

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  PushNotificationRepository() {
    init();
  }

  Future<String> getFireBaseTokenString() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
  }

  StreamController<SelectedPushNotification>
      selectedNotificationStreamController =
      StreamController<SelectedPushNotification>();

  StreamController<ReceivedPushNotification>
      receivedNotificationStreamController =
      StreamController<ReceivedPushNotification>();

  Future<void> init() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationStreamController.add(
          SelectedPushNotification.fromNotificationDetails(
              notificationAppLaunchDetails!));
    }

    // await flutterLocalNotificationsPlugin.initialize(
    //   _getLocalNotificationInitialization(), /*
    //   onDidReceiveNotificationResponse:(details) {
    //     print("najati is the king::${details.payload}");
    //   },*/
    // );

    _createNotificationChannel(channelId, channelName);

// Request Notification Permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');

        receivedNotificationStreamController.add(
            ReceivedPushNotification.fromRemoteNotification(
                message.notification!, message.data));

        // showNotification(message.notification!.title.toString(),
        //     message.notification!.body.toString(), message.data.toString());
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    log('Firebase Token: ${await FirebaseMessaging.instance.getToken()}');
    // log('Firebase Subscribe: ${FirebaseMessaging.instance.subscribeToTopic("topic")}');
  }

  InitializationSettings getLocalNotificationInitialization() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    return initializationSettings;
  }

  Future<void> _createNotificationChannel(String id, String name) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = AndroidNotificationChannel(id, name,
        importance: Importance.max, playSound: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}
