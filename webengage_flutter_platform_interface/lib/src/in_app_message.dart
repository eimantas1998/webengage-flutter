class InAppMessage {
  const InAppMessage({
    required this.state,
    this.title,
    this.body,
    this.action,
  });

  /// Constructs a [InAppMessage] from a raw Map.
  factory InAppMessage.fromMap(Map<String, dynamic> map) {
    return InAppMessage(
      state: InAppMessageState.values.firstWhere(
        (element) => element.toString().split('.').last == map['state'],
        orElse: () => InAppMessageState.clicked,
      ),
      title: map['title'],
      body: map['body'],
      action: map['action'],
    );
  }

  /// The in app message title.
  final InAppMessageState state;

  /// The in app message title.
  final String? title;

  /// The in app message content.
  final String? body;

  /// The in app message action.
  final String? action;
}

enum InAppMessageState {
  prepared,
  shown,
  dissmissed,
  clicked,
}
