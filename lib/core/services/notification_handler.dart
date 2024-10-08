import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:dawaa24/core/data/enums/notification_type_enum.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../../di/injection.dart';
import '../data/model/push_notification/recived_push_notification.dart';
import '../data/model/push_notification/selected_push_notification.dart';
import '../data/repository/push_notification_repository.dart';

@singleton
class NotificationHandler {
  void listenForReceivedNotification() {
    PushNotificationRepository repository = getIt<PushNotificationRepository>();
    repository.receivedNotificationStreamController.stream
        .listen((ReceivedPushNotification event) {
      String jsonString = jsonEncode(event.data);
      _showNotification(event.title, event.body, jsonString);
    });
  }

  void listenForSelectedNotification() {
    PushNotificationRepository repository = getIt<PushNotificationRepository>();
    repository.selectedNotificationStreamController.stream
        .listen((SelectedPushNotification event) {
      log("selected notification with payload: ${event.payload}");
    });
  }

  void handleMessageOnBackground(BuildContext context) async {
    PushNotificationRepository repository = getIt<PushNotificationRepository>();

    //This method will call when the app is in kill state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null && message.data.isNotEmpty) {
        log("message when the app is in kill state");
        try {
          NotificationModel notificationModel =
              NotificationModel.fromJson(message.data);
          routControllerNotificationTypeEnum(
              notificationModel.type ?? NotificationTypeEnum.unKnown,
              notificationModel.entityId ?? '1',
              notificationModel.id ?? '1',
              context);
        } catch (f) {
          log("error is::$f");
        }
      }
    });

    //This method will call when the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        log("message when the app is in background state");
        try {
          NotificationModel notificationModel =
              NotificationModel.fromJson(message.data);
          routControllerNotificationTypeEnum(
              notificationModel.type ?? NotificationTypeEnum.unKnown,
              notificationModel.entityId ?? '1',
              notificationModel.id ?? '1',
              context);
        } catch (f) {
          log("error is::$f");
        }
      }
    });

    //This method will call when the app is in foreground state
    await flutterLocalNotificationsPlugin.initialize(
      repository.getLocalNotificationInitialization(),
      onDidReceiveNotificationResponse: (details) {
        try {
          log("message when the app is in foreground state");
          Map<String, dynamic> jsonData = jsonDecode(details.payload ?? '');

          NotificationModel notificationModel =
              NotificationModel.fromJson(jsonData);
          routControllerNotificationTypeEnum(
              notificationModel.type ?? NotificationTypeEnum.unKnown,
              notificationModel.entityId ?? '1',
              notificationModel.id ?? '1',
              context);
        } catch (f) {
          log("error is::$f");
        }
      },
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log("Handling a background message: ${message.messageId}");
}

final random = math.Random();

Future<void> _showNotification(
    String title, String body, String? payload) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(PushNotificationRepository.channelId,
          PushNotificationRepository.channelName,
          channelDescription:
              'Notification with high priority will be received with this channel',
          importance: Importance.max,
          priority: Priority.high,
          icon: "@drawable/ic_launcher",
          ticker: 'ticker');
  const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true);

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: darwinNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    random.nextInt(1000000),
    title,
    body,
    payload: payload,
    platformChannelSpecifics,
  );
}
