@JS('webengage')
library webengage.webengage_interop;

import 'package:js/js.dart';

@JS()
external WebEngageUserJsImpl get user;

@JS()
external void track(String eventName, [Object? eventData]);

@JS()
external void screen([String? name, Object? data]);

@JS('WebEngageUser')
class WebEngageUserJsImpl {
  external void login(String userId);
  external void logout();
  external void setAttribute(String attribute, Object value);
}
