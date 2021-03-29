import 'webengage_interop.dart' as webengage_interop;
import 'utils.dart';

void track(String event, [Map<String, dynamic>? data]) {
  if (data != null) {
    webengage_interop.track(event, jsify(data));
  } else {
    webengage_interop.track(event);
  }
}

void screen([String? name, Map<String, dynamic>? data]) {
  if (data != null) {
    webengage_interop.screen(name, jsify(data));
  } else {
    webengage_interop.screen(name);
  }
}

WebEngageUser get user => WebEngageUser._fromJsObject(webengage_interop.user);

class WebEngageUser
    extends JsObjectWrapper<webengage_interop.WebEngageUserJsImpl> {
  WebEngageUser._fromJsObject(webengage_interop.WebEngageUserJsImpl jsObject)
      : super.fromJsObject(jsObject);

  void login(String userId) => jsObject.login(userId);
  void logout() => jsObject.logout();
  void setAttribute(String attribute, Object value) =>
      jsObject.setAttribute(attribute, jsify(value));
}

abstract class JsObjectWrapper<T> {
  /// JS object.
  final T jsObject;

  /// Creates a new JsObjectWrapper type from a [jsObject].
  JsObjectWrapper.fromJsObject(this.jsObject);
}
