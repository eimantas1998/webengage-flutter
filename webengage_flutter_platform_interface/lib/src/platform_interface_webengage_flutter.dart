import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'in_app_message.dart';
import 'method_channel_webengage_flutter.dart';
import 'push_notification.dart';

/// The interface that implementations of webengage_flutter must implement.
///
/// Platform implementations should extend this class rather than implement it as `webengage_flutter`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [WebEngageFlutterPlatform] methods.
///
/// Defines an interface to work with WebEngage on web and mobile.
abstract class WebEngageFlutterPlatform extends PlatformInterface {
  /// Constructs a WebEngageFlutterPlatform.
  WebEngageFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebEngageFlutterPlatform _instance = MethodChannelWebEngageFlutter();

  /// The default instance of [WebEngageFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebEngageFlutter].
  static WebEngageFlutterPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [WebEngageFlutterPlatform] when they register themselves.
  static set instance(WebEngageFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> userLogin(String userId) {
    throw UnimplementedError('userLogin() has not been implemented.');
  }

  Future<void> userLogout() {
    throw UnimplementedError('userLogout() has not been implemented.');
  }

  Future<void> setUserFirstName(String firstName) {
    throw UnimplementedError('setUserFirstName() has not been implemented.');
  }

  Future<void> setUserLastName(String lastName) {
    throw UnimplementedError('setUserLastName() has not been implemented.');
  }

  Future<void> setUserEmail(String email) {
    throw UnimplementedError('setUserEmail() has not been implemented.');
  }

  Future<void> setUserHashedEmail(String email) {
    throw UnimplementedError('setUserHashedEmail() has not been implemented.');
  }

  Future<void> setUserPhone(String phone) {
    throw UnimplementedError('setUserPhone() has not been implemented.');
  }

  Future<void> setUserHashedPhone(String phone) {
    throw UnimplementedError('setUserHashedPhone() has not been implemented.');
  }

  Future<void> setUserCompany(String company) {
    throw UnimplementedError('setUserCompany() has not been implemented.');
  }

  Future<void> setUserBirthDate(String birthDate) {
    throw UnimplementedError('setUserBirthDate() has not been implemented.');
  }

  Future<void> setUserGender(String gender) {
    throw UnimplementedError('setUserGender() has not been implemented.');
  }

  Future<void> setUserOptIn(String channel, bool optIn) {
    throw UnimplementedError('setUserOptIn() has not been implemented.');
  }

  Future<void> setUserLocation(double lat, double lng) {
    throw UnimplementedError('setUserLocation() has not been implemented.');
  }

  Future<void> trackEvent(String eventName,
      [Map<String, dynamic>? attributes]) {
    throw UnimplementedError('trackEvent() has not been implemented.');
  }

  Future<void> setUserAttributes(Map userAttributeValue) {
    throw UnimplementedError('setUserAttributes() has not been implemented.');
  }

  Future<void> setUserAttribute(
      String attributeName, dynamic userAttributeValue) {
    throw UnimplementedError('setUserAttribute() has not been implemented.');
  }

  Future<void> trackScreen(String eventName,
      [Map<String, dynamic>? screenData]) {
    throw UnimplementedError('trackScreen() has not been implemented.');
  }

  // ignore: close_sinks
  static StreamController<PushNotification>? _onPushStreamController;

  static StreamController<PushNotification> get onPush {
    return _onPushStreamController ??=
        StreamController<PushNotification>.broadcast();
  }

  // ignore: close_sinks
  static StreamController<InAppMessage>? _onInAppStreamController;

  static StreamController<InAppMessage> get onInApp {
    return _onInAppStreamController ??=
        StreamController<InAppMessage>.broadcast();
  }

  // ignore: close_sinks
  static StreamController<String>? _onDeepLinkStreamController;

  static StreamController<String> get onDeepLink {
    return _onDeepLinkStreamController ??= StreamController<String>.broadcast();
  }
}
