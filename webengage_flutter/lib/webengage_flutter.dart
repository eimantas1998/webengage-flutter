library webengage_flutter;

import 'dart:async';

import 'package:webengage_flutter_platform_interface/webengage_flutter_platform_interface.dart';

export 'package:webengage_flutter_platform_interface/webengage_flutter_platform_interface.dart'
    show
        Gender,
        OptInChannel,
        PushNotification,
        InAppMessage,
        InAppMessageState;

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

  Future<void> setUserGender(Gender gender) async {
    await _platfomInstace.setUserGender(gender);
  }

  Future<void> setUserOptIn(OptInChannel channel, bool optIn) async {
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
}
