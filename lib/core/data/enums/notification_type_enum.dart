import 'dart:developer';

import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/parse_helpers/failure_parser.dart';
import 'package:dawaa24/features/notification/presentation/cubits/mark_notification_as_read_cubit/mark_notification_as_read_cubit.dart';
import 'package:dawaa24/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NotificationTypeEnum { order, unKnown }

void routControllerNotificationTypeEnum(NotificationTypeEnum type, String id,
    String notificationId, BuildContext context) async {
  MarkNotificationAsReadCubit markNotificationAsReadCubit =
      MarkNotificationAsReadCubit();
  bool markNotificationStatus =
      await markNotificationAsReadCubit.markNotification(notificationId);
  if (markNotificationStatus) {
    switch (type) {
      case NotificationTypeEnum.order:
        context.push(AppPaths.orderPaths.orderDetails, extra: id.toString());
        break;
      case NotificationTypeEnum.unKnown:
        break;
    }
  }
  else if (markNotificationAsReadCubit.state.failure != null) {
    FailureParser.mapFailureToString(
        failure: markNotificationAsReadCubit.state.failure!, context: context).showToast();
    context.push(AppPaths.mainPaths.notificationPage);
  }
}
