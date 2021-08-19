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
  static final _platfomInstace = WebEngageFlutterPlatform.instance;

  static final _onPushController =
      StreamController<PushNotification>.broadcast(onListen: () {
    Stream<PushNotification> onPushStream =
        WebEngageFlutterPlatform.onPush.stream;

    onPushStream.pipe(_onPushController);
  });

  static Stream<PushNotification> get onPush => _onPushController.stream;

  static final _onInAppController =
      StreamController<InAppMessage>.broadcast(onListen: () {
    Stream<InAppMessage> onInAppStream =
        WebEngageFlutterPlatform.onInApp.stream;

    onInAppStream.pipe(_onInAppController);
  });

  static Stream<InAppMessage> get onInApp => _onInAppController.stream;

  static final _onDeepLinkController =
      StreamController<String>.broadcast(onListen: () {
    Stream<String> onDeepLinkStream =
        WebEngageFlutterPlatform.onDeepLink.stream;

    onDeepLinkStream.pipe(_onDeepLinkController);
  });

  static Stream<String> get onDeepLink => _onDeepLinkController.stream;

  /// Prompts the user for notification permissions.
  ///
  ///  - On iOS, a dialog is shown requesting the users permission.
  ///  - On Android, is it not required to call this method. If called however,
  ///    a boolean of value `true` will be returned.
  ///
  /// Note that on iOS, if [provisional] is set to `true`, silent notification permissions will be
  /// automatically granted. When notifications are delivered to the device, the
  /// user will be presented with an option to disable notifications, keep receiving
  /// them silently or enable prominent notifications.
  static Future<bool> requestPermission({
    /// Request permission to display alerts. Defaults to `true`.
    ///
    /// iOS/macOS only.
    bool alert = true,

    /// Request permission for Siri to automatically read out notification messages over AirPods.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool announcement = false,

    /// Request permission to update the application badge. Defaults to `true`.
    ///
    /// iOS/macOS only.
    bool badge = true,

    /// Request permission to display notifications in a CarPlay environment.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool carPlay = false,

    /// Request permission for critical alerts. Defaults to `false`.
    ///
    /// Note; your application must explicitly state reasoning for enabling
    /// critical alerts during the App Store review process or your may be
    /// rejected.
    ///
    /// iOS only.
    bool criticalAlert = false,

    /// Request permission to provisionally create non-interrupting notifications.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool provisional = false,

    /// Request permission to play sounds. Defaults to `true`.
    ///
    /// iOS/macOS only.
    bool sound = true,
  }) {
    return _platfomInstace.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound,
    );
  }

  /// Sets the presentation options for Apple notifications when received in
  /// the foreground.
  ///
  /// By default, on Apple devices notification messages are only shown when
  /// the application is in the background or terminated. Calling this method
  /// updates these options to allow customizing notification presentation behaviour whilst
  /// the application is in the foreground.
  ///
  /// Important: The requested permissions and those set by the user take priority
  /// over these settings.
  ///
  /// - [alert] Causes a notification message to display in the foreground, overlaying
  ///   the current application (heads up mode).
  /// - [badge] The application badge count will be updated if the application is
  ///   in the foreground.
  /// - [sound] The device will trigger a sound if the application is in the foreground.
  ///
  /// If all arguments are `false` or are omitted, a notification will not be displayed in the
  /// foreground, however you will still receive events relating to the notification.
  static Future<void> setForegroundNotificationPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  }) {
    return _platfomInstace.setForegroundNotificationPresentationOptions(
      alert: alert,
      badge: badge,
      sound: sound,
    );
  }

  static Future<void> userLogin(String userId) async {
    await _platfomInstace.userLogin(userId);
  }

  static Future<void> userLogout() async {
    await _platfomInstace.userLogout();
  }

  static Future<void> setUserFirstName(String firstName) async {
    await _platfomInstace.setUserFirstName(firstName);
  }

  static Future<void> setUserLastName(String lastName) async {
    await _platfomInstace.setUserLastName(lastName);
  }

  static Future<void> setUserEmail(String email) async {
    await _platfomInstace.setUserEmail(email);
  }

  static Future<void> setUserHashedEmail(String email) async {
    await _platfomInstace.setUserHashedEmail(email);
  }

  static Future<void> setUserPhone(String phone) async {
    await _platfomInstace.setUserPhone(phone);
  }

  static Future<void> setUserHashedPhone(String phone) async {
    await _platfomInstace.setUserHashedPhone(phone);
  }

  static Future<void> setUserCompany(String company) async {
    await _platfomInstace.setUserCompany(company);
  }

  static Future<void> setUserBirthDate(String birthDate) async {
    await _platfomInstace.setUserBirthDate(birthDate);
  }

  static Future<void> setUserGender(Gender gender) async {
    await _platfomInstace.setUserGender(gender);
  }

  static Future<void> setUserOptIn(OptInChannel channel, bool optIn) async {
    await _platfomInstace.setUserOptIn(channel, optIn);
  }

  static Future<void> setUserLocation(double lat, double lng) async {
    await _platfomInstace.setUserLocation(lat, lng);
  }

  static Future<void> trackEvent(String eventName,
      [Map<String, dynamic>? attributes]) async {
    await _platfomInstace.trackEvent(eventName, attributes);
  }

  static Future<void> setUserAttributes(Map userAttributeValue) async {
    await _platfomInstace.setUserAttributes(userAttributeValue);
  }

  static Future<void> setUserAttribute(
      String attributeName, dynamic userAttributeValue) async {
    await _platfomInstace.setUserAttribute(attributeName, userAttributeValue);
  }

  static Future<void> trackScreen(String eventName,
      [Map<String, dynamic>? screenData]) async {
    await _platfomInstace.trackScreen(eventName, screenData);
  }

  static void webInitialize(String key) {
    _platfomInstace.webInitialize(key);
  }
}
