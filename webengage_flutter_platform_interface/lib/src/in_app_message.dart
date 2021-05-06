import 'constants.dart';

class InAppMessage {
  const InAppMessage({
    required this.state,
    required this.data,
    required this.link,
  });

  /// Constructs a [InAppMessage] from a raw Map.
  factory InAppMessage.fromMap(Map<String, dynamic> map) => InAppMessage(
        state: InAppMessageState.values.firstWhere(
          (element) => element.toString().split('.').last == map[STATE],
          orElse: () => InAppMessageState.prepared,
        ),
        data: Map<String, dynamic>.from(map[DATA] ?? {}),
        link: map[LINK],
      );

  /// The in app message title.
  final InAppMessageState state;

  /// The in app message deeplink.
  final String? link;

  /// The in app message data.
  final Map<String, dynamic> data;
}
