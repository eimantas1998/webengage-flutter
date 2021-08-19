import 'package:webengage_flutter_platform_interface/webengage_flutter_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/event_names.dart';
import 'src/plugin.dart' as we;

/// Web implementation for [WebEngageFlutterPlatform]
class WebEngagePlugin extends WebEngageFlutterPlatform {
  /// returns true when webengage is initialized
  bool _initialized = false;

  /// Called by PluginRegistry to register this plugin for Flutter Web
  static void registerWith(Registrar registrar) {
    WebEngageFlutterPlatform.instance = WebEngagePlugin();
  }

  @override
  Future<void> userLogin(String userId) async {
    if (!_initialized) return null;

    return we.user.login(userId);
  }

  @override
  Future<void> userLogout() async {
    if (!_initialized) return null;

    return we.user.logout();
  }

  @override
  Future<void> setUserFirstName(String firstName) async {
    if (!_initialized) return null;

    return we.user.setAttribute(FIRST_NAME, firstName);
  }

  @override
  Future<void> setUserLastName(String lastName) async {
    if (!_initialized) return null;

    return we.user.setAttribute(LAST_NAME, lastName);
  }

  @override
  Future<void> setUserEmail(String email) async {
    if (!_initialized) return null;

    return we.user.setAttribute(EMAIL, email);
  }

  @override
  Future<void> setUserHashedEmail(String email) async {
    if (!_initialized) return null;

    return we.user.setAttribute(HASHED_EMAIL, email);
  }

  @override
  Future<void> setUserPhone(String phone) async {
    if (!_initialized) return null;

    return we.user.setAttribute(PHONE, phone);
  }

  @override
  Future<void> setUserHashedPhone(String phone) async {
    if (!_initialized) return null;

    return we.user.setAttribute(HASHED_PHONE, phone);
  }

  @override
  Future<void> setUserCompany(String company) async {
    if (!_initialized) return null;

    return we.user.setAttribute(COMPANY, company);
  }

  @override
  Future<void> setUserBirthDate(String birthDate) async {
    if (!_initialized) return null;

    return we.user.setAttribute(BIRTHDATE, birthDate);
  }

  @override
  Future<void> setUserGender(Gender gender) async {
    if (!_initialized) return null;

    return we.user.setAttribute(GENDER, gender.toString().split('.').last);
  }

  @override
  Future<void> setUserOptIn(OptInChannel channel, bool optIn) async {
    if (!_initialized) return null;

    switch (channel) {
      case OptInChannel.email:
        return we.user.setAttribute(OPTIN_EMAIL, optIn);
      case OptInChannel.sms:
        return we.user.setAttribute(OPTIN_SMS, optIn);
      case OptInChannel.whatsapp:
        return we.user.setAttribute(OPTIN_WHATSAPP, optIn);
      case OptInChannel.push:
        return we.user.setAttribute(OPTIN_PUSH, optIn);
      default:
        throw UnimplementedError(
            'setUserOptIn() does not have this channel on web.');
    }
  }

  @override
  Future<void> trackEvent(String eventName,
      [Map<String, dynamic>? attributes]) async {
    if (!_initialized) return null;

    return we.track(eventName, attributes);
  }

  @override
  Future<void> setUserAttributes(Map userAttributeValue) async {
    if (!_initialized) return null;

    return userAttributeValue
        .forEach((key, value) => setUserAttribute(key, value));
  }

  @override
  Future<void> setUserAttribute(
      String attributeName, dynamic userAttributeValue) async {
    if (!_initialized) return null;

    return we.user.setAttribute(attributeName, userAttributeValue);
  }

  @override
  Future<void> trackScreen(String eventName,
      [Map<String, dynamic>? screenData]) async {
    if (!_initialized) return null;

    return we.screen(eventName, screenData);
  }

  @override
  void webInitialize(String key) {
    we.init(key);
    _initialized = true;
  }
}
