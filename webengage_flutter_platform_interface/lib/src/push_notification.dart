import 'constants.dart';

class PushNotification {
  const PushNotification({
    required this.link,
    required this.data,
  });

  /// Constructs a [PushNotification] from a raw Map.
  factory PushNotification.fromMap(Map<String, dynamic> map) {
    print(map);
    var data = Map<String, dynamic>.from(map[DATA] ?? {});
    return PushNotification(
      link: map[LINK],
      data: data,
    );
  }

  /// The notification deeplink.
  final String? link;

  /// The notification data.
  final Map<String, dynamic> data;
}
