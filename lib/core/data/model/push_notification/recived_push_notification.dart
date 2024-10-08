import 'package:firebase_messaging/firebase_messaging.dart';

class ReceivedPushNotification {
  String title, body;
  Map<String, dynamic> data;

  ReceivedPushNotification(
      {required this.title, required this.body, required this.data});

  factory ReceivedPushNotification.fromRemoteNotification(
      RemoteNotification remoteNotification, Map<String, dynamic> data) {
    return ReceivedPushNotification(
        title: remoteNotification.title ?? '',
        body: remoteNotification.body ?? '',
        data: data);
  }
}
