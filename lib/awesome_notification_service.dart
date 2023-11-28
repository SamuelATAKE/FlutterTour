// ignore_for_file: avoid_print

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelKey: 'high_importance_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white,
              playSound: true,
              enableVibration: true,
              importance: NotificationImportance.High,
              channelShowBadge: true,
              onlyAlertOnce: true,
              criticalAlerts: true)
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'grouped',
              channelGroupName: 'Grouped notifications')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onNotificationDismissedMethod);
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification created');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed');
  }

  static Future<void> onNotificationDismissedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification dismissed');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Action received');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      // MainApp.navigatorKey.currentState?.push();
      print(payload);
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    print('greaaat');
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'high_importance_channel',
            title: title,
            body: body,
            actionType: actionType,
            notificationLayout: notificationLayout,
            payload: payload,
            category: category,
            bigPicture: bigPicture,
            summary: summary,
            icon: 'resource://drawable/launch_background'),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true,
              )
            : null);
  }

  static Future<void> cancelNotification() async {
    print('want to cancel....');
    await AwesomeNotifications().cancel(1);
  }
}
