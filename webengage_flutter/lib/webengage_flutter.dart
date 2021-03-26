import 'dart:async';

import 'package:webengage_flutter_platform_interface/webengage_flutter_platform_interface.dart';

// typedef void MessageHandler(Map<String, dynamic> message);
// typedef void MessageHandlerInAppClick(Map<String, dynamic> message, String s);
// typedef void MessageHandlerPushClick(Map<String, dynamic> message, String s);

class WebEngagePlugin {
  final _platfomInstace = WebEngageFlutterPlatform.instance;

  static Stream<PushNotification> get onPush =>
      WebEngageFlutterPlatform.onPush.stream;
  static Stream<InAppMessage> get onInApp =>
      WebEngageFlutterPlatform.onInApp.stream;
  static Stream<String> get onDeepLink =>
      WebEngageFlutterPlatform.onDeepLink.stream;

  Future<void> userLogin(String userId) async {
    await _platfomInstace.userLogin(userId);
  }

  Future<void> userLogout() async {
    await _platfomInstace.userLogout();
  }

  Future<void> setUserFirstName(String firstName) async {
    await _platfomInstace.setUserFirstName(firstName);
  }

  Future<void> setUserLastName(String lastName) async {
    await _platfomInstace.setUserLastName(lastName);
  }

  Future<void> setUserEmail(String email) async {
    await _platfomInstace.setUserEmail(email);
  }

  Future<void> setUserHashedEmail(String email) async {
    await _platfomInstace.setUserHashedEmail(email);
  }

  Future<void> setUserPhone(String phone) async {
    await _platfomInstace.setUserPhone(phone);
  }

  Future<void> setUserHashedPhone(String phone) async {
    await _platfomInstace.setUserHashedPhone(phone);
  }

  Future<void> setUserCompany(String company) async {
    await _platfomInstace.setUserCompany(company);
  }

  Future<void> setUserBirthDate(String birthDate) async {
    await _platfomInstace.setUserBirthDate(birthDate);
  }

  Future<void> setUserGender(String gender) async {
    await _platfomInstace.setUserGender(gender);
  }

  Future<void> setUserOptIn(String channel, bool optIn) async {
    await _platfomInstace.setUserOptIn(channel, optIn);
  }

  Future<void> setUserLocation(double lat, double lng) async {
    await _platfomInstace.setUserLocation(lat, lng);
  }

  Future<void> trackEvent(String eventName,
      [Map<String, dynamic>? attributes]) async {
    await _platfomInstace.trackEvent(eventName, attributes);
  }

  Future<void> setUserAttributes(Map userAttributeValue) async {
    await _platfomInstace.setUserAttributes(userAttributeValue);
  }

  Future<void> setUserAttribute(
      String attributeName, dynamic userAttributeValue) async {
    await _platfomInstace.setUserAttribute(attributeName, userAttributeValue);
  }

  Future<void> trackScreen(String eventName,
      [Map<String, dynamic>? screenData]) async {
    await _platfomInstace.trackScreen(eventName, screenData);
  }

  // Future _platformCallHandler(MethodCall call) async {
  //   print("_platformCallHandler call ${call.method} ${call.arguments}");
  //   if (call.method == callbackOnPushClick ||
  //       call.method == callbackOnPushActionClick) {
  //     Map<String, dynamic> message = call.arguments.cast<String, dynamic>();
  //     if (Platform.isAndroid) {
  //       String deepLink = message[PAYLOAD][URI];
  //       Map<String, dynamic> newPayload =
  //           message[PAYLOAD].cast<String, dynamic>();
  //       PushPayload pushPayload = PushPayload();
  //       pushPayload.deepLink = deepLink;
  //       pushPayload.payload = newPayload;
  //       if (call.method == callbackOnPushClick) {
  //         _pushClickStream.sink.add(pushPayload);
  //         if (null != _onPushClick) {
  //           _onPushClick(newPayload, deepLink);
  //         }
  //       } else if (call.method == callbackOnPushActionClick) {
  //         _pushActionClickStream.sink.add(pushPayload);
  //         if (null != callbackOnPushActionClick) {
  //           _onPushActionClick(newPayload, deepLink);
  //         }
  //       }
  //     } else {
  //       String deepLink = message[DEEPLINK];
  //       Map<String, dynamic> newPayload =
  //           call.arguments.cast<String, dynamic>();
  //       PushPayload pushPayload = PushPayload();
  //       pushPayload.deepLink = deepLink;
  //       pushPayload.payload = newPayload;
  //       if (call.method == callbackOnPushClick) {
  //         _pushClickStream.sink.add(pushPayload);
  //       } else if (call.method == callbackOnPushActionClick) {
  //         _pushActionClickStream.sink.add(pushPayload);
  //       }
  //     }
  //   }

  //   if (call.method == callbackOnInAppClicked && _onInAppClick != null) {
  //     Map<String, dynamic> message = call.arguments.cast<String, dynamic>();
  //     if (Platform.isAndroid) {
  //       String selectedActionId = message[PAYLOAD][SELECTED_ACTION_ID];
  //       Map<String, dynamic> newPayload =
  //           message[PAYLOAD].cast<String, dynamic>();
  //       _onInAppClick(newPayload, selectedActionId);
  //     } else {
  //       String selectedActionId = message[SELECTED_ACTION_ID];
  //       _onInAppClick(call.arguments.cast<String, dynamic>(), selectedActionId);
  //     }
  //   }

  //   if (call.method == callbackOnInAppShown && _onInAppShown != null) {
  //     Map<String, dynamic> message = call.arguments.cast<String, dynamic>();
  //     if (Platform.isAndroid) {
  //       Map<String, dynamic> newPayload =
  //           message[PAYLOAD].cast<String, dynamic>();
  //       _onInAppShown(newPayload);
  //     } else {
  //       _onInAppShown(call.arguments.cast<String, dynamic>());
  //     }
  //   }

  //   if (call.method == callbackOnInAppDismissed && _onInAppDismiss != null) {
  //     Map<String, dynamic> message = call.arguments.cast<String, dynamic>();
  //     if (Platform.isAndroid) {
  //       Map<String, dynamic> newPayload =
  //           message[PAYLOAD].cast<String, dynamic>();
  //       _onInAppDismiss(newPayload);
  //     } else {
  //       _onInAppDismiss(call.arguments.cast<String, dynamic>());
  //     }
  //   }

  //   if (call.method == callbackOnInAppPrepared && _onInAppPrepared != null) {
  //     Map<String, dynamic> message = call.arguments.cast<String, dynamic>();
  //     if (Platform.isAndroid) {
  //       Map<String, dynamic> newPayload =
  //           message[PAYLOAD].cast<String, dynamic>();
  //       _onInAppPrepared(newPayload);
  //     } else {
  //       _onInAppPrepared(call.arguments.cast<String, dynamic>());
  //     }
  //   }

  //   if (call.method == METHOD_TRACK_DEEPLINK_URL) {
  //     String locationLink = call.arguments;
  //     _trackDeeplinkURLStream.sink.add(locationLink);
  //   }
  // }
}
