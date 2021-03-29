import 'constants.dart';

class InAppMessage {
  const InAppMessage({
    required this.state,
    required this.data,
  });

  /// Constructs a [InAppMessage] from a raw Map.
  factory InAppMessage.fromMap(Map<String, dynamic> map) {
    var data = Map<String, dynamic>.from(map[DATA] ?? {});
    return InAppMessage(
      state: InAppMessageState.values.firstWhere(
        (element) => element.toString().split('.').last == map['state'],
        orElse: () => InAppMessageState.prepared,
      ),
      data: data,
    );
  }

  /// The in app message title.
  final InAppMessageState state;

  /// The in app message data.
  final Map<String, dynamic>? data;
}
