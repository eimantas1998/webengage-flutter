class PushNotification {
  const PushNotification({
    this.title,
    this.body,
    this.link,
    this.action,
    this.payload,
  });

  /// Constructs a [PushNotification] from a raw Map.
  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      title: map['title'],
      body: map['body'],
      link: map['link'],
      action: map['action'],
      payload: map['payload'] != null
          ? Map<String, dynamic>.from(map['payload'])
          : null,
    );
  }

  /// The notification title.
  final String? title;

  /// The notification body content.
  final String? body;

  /// The notification deeplink.
  final String? link;

  /// The notification action.
  final String? action;

  /// The notification payload.
  final Map<String, dynamic>? payload;
}
