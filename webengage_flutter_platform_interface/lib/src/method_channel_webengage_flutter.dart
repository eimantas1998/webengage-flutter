import 'dart:async';

import 'package:flutter/services.dart';

import 'constants.dart';
import 'in_app_message.dart';
import 'platform_interface_webengage_flutter.dart';
import 'push_notification.dart';

/// An implementation of [WebEngagePlatform] that uses method channels.
class MethodChannelWebEngageFlutter extends WebEngageFlutterPlatform {
  static const MethodChannel _channel = MethodChannel('webengage_flutter');

  static bool _initialized = false;

  MethodChannelWebEngageFlutter() {
    if (_initialized) return;
    _channel.setMethodCallHandler((MethodCall call) async {
      print("methodCallHandler call ${call.method} ${call.arguments}");
      switch (call.method) {
        case METHOD_NAME_ON_PUSH:
          Map<String, dynamic> pushMap =
              Map<String, dynamic>.from(call.arguments);
          WebEngageFlutterPlatform.onPush
              .add(PushNotification.fromMap(pushMap));
          break;
        case METHOD_NAME_ON_IN_APP:
          Map<String, dynamic> inAppMap =
              Map<String, dynamic>.from(call.arguments);
          WebEngageFlutterPlatform.onInApp.add(InAppMessage.fromMap(inAppMap));
          break;
        case METHOD_NAME_ON_DEEP_LINK:
          var deepLink = call.arguments as String;
          WebEngageFlutterPlatform.onDeepLink.add(deepLink);
          break;
        default:
          throw UnimplementedError('${call.method} has not been implemented');
      }
    });
    _initialized = true;
  }

  @override
  Future<void> userLogin(String userId) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_LOGIN, userId);
  }

  @override
  Future<void> userLogout() {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_LOGOUT);
  }

  @override
  Future<void> setUserFirstName(String firstName) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_FIRST_NAME, firstName);
  }

  @override
  Future<void> setUserLastName(String lastName) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_LAST_NAME, lastName);
  }

  @override
  Future<void> setUserEmail(String email) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_EMAIL, email);
  }

  @override
  Future<void> setUserHashedEmail(String email) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_HASHED_EMAIL, email);
  }

  @override
  Future<void> setUserPhone(String phone) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_PHONE, phone);
  }

  @override
  Future<void> setUserHashedPhone(String phone) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_HASHED_PHONE, phone);
  }

  @override
  Future<void> setUserCompany(String company) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_COMPANY, company);
  }

  @override
  Future<void> setUserBirthDate(String birthDate) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_BIRTHDATE, birthDate);
  }

  @override
  Future<void> setUserGender(String gender) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_GENDER, gender);
  }

  @override
  Future<void> setUserOptIn(String channel, bool optIn) {
    return _channel.invokeMethod(
        METHOD_NAME_SET_USER_OPT_IN, {CHANNEL: channel, OPTIN: optIn});
  }

  @override
  Future<void> setUserLocation(double lat, double lng) {
    return _channel
        .invokeMethod(METHOD_NAME_SET_USER_LOCATION, {LAT: lat, LNG: lng});
  }

  @override
  Future<void> trackEvent(String eventName,
      [Map<String, dynamic>? attributes]) {
    return _channel.invokeMethod(METHOD_NAME_TRACK_EVENT,
        {EVENT_NAME: eventName, ATTRIBUTES: attributes});
  }

  @override
  Future<void> setUserAttributes(Map userAttributeValue) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_MAP_ATTRIBUTE,
        {ATTRIBUTE_NAME: "attributeName", ATTRIBUTES: userAttributeValue});
  }

  @override
  Future<void> setUserAttribute(
      String attributeName, dynamic userAttributeValue) {
    return _channel.invokeMethod(METHOD_NAME_SET_USER_ATTRIBUTE,
        {ATTRIBUTE_NAME: attributeName, ATTRIBUTES: userAttributeValue});
  }

  @override
  Future<void> trackScreen(String eventName,
      [Map<String, dynamic>? screenData]) {
    return _channel.invokeMethod(METHOD_NAME_TRACK_SCREEN,
        {SCREEN_NAME: eventName, SCREEN_DATA: screenData});
  }
}
