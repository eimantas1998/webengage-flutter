import 'constants.dart';

class PushNotification {
  const PushNotification({
    required this.title,
    required this.message,
    required this.state,
    required this.link,
    required this.data,
  });

  /// Constructs a [PushNotification] from a raw Map.
  factory PushNotification.fromMap(Map<String, dynamic> map) =>
      PushNotification(
        title: map[TITLE],
        message: map[MESSAGE],
        state: PushNotificationState.values.firstWhere(
          (element) => element.toString().split('.').last == map[STATE],
          orElse: () => PushNotificationState.shown,
        ),
        link: map[LINK],
        data: Map<String, dynamic>.from(map[DATA] ?? {}),
      );

  /// The notification title.
  final String title;

  /// The notification message.
  final String message;

  /// The notification state.
  final PushNotificationState state;

  /// The notification deeplink.
  final String? link;

  /// The notification additional data.
  final Map<String, dynamic> data;
}
