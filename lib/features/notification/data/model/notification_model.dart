import 'package:dawaa24/core/data/enums/notification_type_enum.dart';

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.entityId,
    required this.isRead,
    required this.title,
    required this.content,
    required this.iconThumbnail,
    required this.createdOn,
    required this.type,
  });

  final String? id;
  final String? entityId;
  final bool? isRead;
  final String? title;
  final String? content;
  final String? iconThumbnail;
  final double? createdOn;
  final NotificationTypeEnum? type;

  NotificationModel copyWith({
    String? id,
    String? entityId,
    bool? isRead,
    String? title,
    String? content,
    String? iconThumbnail,
    double? createdOn,
    NotificationTypeEnum? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      entityId: entityId ?? this.entityId,
      isRead: isRead ?? this.isRead,
      title: title ?? this.title,
      content: content ?? this.content,
      iconThumbnail: iconThumbnail ?? this.iconThumbnail,
      createdOn: createdOn ?? this.createdOn,
      type: type ?? this.type,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? json["notificationId"],
      entityId: json["entityId"],
      isRead: json["isRead"],
      title: json["title"],
      content: json["content"],
      iconThumbnail: json["iconThumbnail"],
      createdOn: json["createdOn"],
      type: (json["type"] == 0 || json["type"] == "0")
          ? NotificationTypeEnum.order
          : NotificationTypeEnum.unKnown,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityId": entityId,
        "isRead": isRead,
        "title": title,
        "content": content,
        "iconThumbnail": iconThumbnail,
        "createdOn": createdOn,
        "type": type,
      };

  @override
  String toString() {
    return "$id, $entityId, $isRead, $title, $content, $iconThumbnail, $createdOn, $type, ";
  }
}
