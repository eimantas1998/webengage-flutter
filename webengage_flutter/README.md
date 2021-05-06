# WebEngage Flutter SDK

For more information checkout our [website](https://webengage.com/) and [documentation](https://docs.webengage.com/docs).

## Installation

**Add WebEngage Flutter Plugin**

- Add webengage_flutter in your `pubspec.yaml` file.

```yml
dependencies:
webengage_flutter: 2.0.0
```

- Run `flutter packages get` to install the SDK

### Android

1. Open the `/android/app/src/main/AndroidManifest.xml` file.
2. Add the following meta-data element inside your application element (don't forget to add your licence code).

```xml
<meta-data
            android:name="com.webengage.sdk.android.key"
            android:value="YOUR_LICENCSE_CODE" />
```

### iOS

1. Open the `/ios/Runner/Info.plist` file.
2. Add the following key in your `<dict>...</dict>` element (don't forget to add your licence code).

```plist
<key>WEGLicenseCode</key>
<string>YOUR_LICENCSE_CODE</string>
```

**Push Notifications**

Add below subscribeToPushCallbacks() method in main.dart and call it from initMethod()

```dart
  void subscribeToPushCallbacks() {
      WebEngagePlugin.onPush.listen((message) {
        String title = message.title;
        String message = message.message;
        String? link = message.link;
        PushNotificationState state = message.state;
        Map<String, dynamic> data = message.data;
      });
  }
```

**Universal Link**

Add below subscribeToTrackUniversalLink() method in main.dart and call it from initMethod()

```dart
 void subscribeToTrackUniversalLink() {
    WebEngagePlugin.onDeepLink.listen((link) {
      print("onDeepLinkStream: " + link);
    });
  }
```

**Track Users**

```dart
import 'package:webengage_flutter/webengage_flutter.dart';
...
    // User login
    WebEngagePlugin.userLogin('3254');

    // User logout
    WebEngagePlugin.userLogout();

    // Set user first name
    WebEngagePlugin.setUserFirstName('John');

    // Set user last name
    WebEngagePlugin.setUserLastName('Doe');

    // Set user email
    WebEngagePlugin.setUserEmail('john.doe@gmail.com');

    // Set user hashed email
    WebEngagePlugin.setUserHashedEmail('144e0424883546e07dcd727057fd3b62');

    // Set user phone number
    WebEngagePlugin.setUserPhone('+551155256325');

    // Set user hashed phone number
    WebEngagePlugin.setUserHashedPhone('e0ec043b3f9e198ec09041687e4d4e8d');

    // Set user company
    WebEngagePlugin.setUserCompany('WebEngage');

    // Set user birth-date, supported format: 'yyyy-MM-dd'
    WebEngagePlugin.setUserBirthDate('1994-05-24');

    // Set user gender, allowed values are ['male', 'female', 'other']
    WebEngagePlugin.setUserGender('male');

    // Set user channel opt-in status
    WebEngagePlugin.setUserOptIn('in_app', false);

    // Set user location
    WebEngagePlugin.setUserLocation(19.25, 72.45);

    // Set User Attribute with  String value
    WebEngagePlugin.setUserAttribute("twitterusename", "saurav12994");

    // Set User Attribute with  Boolean value
    WebEngagePlugin.setUserAttribute("Subscribed to email", true);

    // Set User Attribute with  Integer value
    WebEngagePlugin.setUserAttribute("Points earned", 2626);

    // Set User Attribute with  Double value
    WebEngagePlugin.setUserAttribute("Dollar Spent", 123.44);

    // Set User Attribute with  Map value
    var details = {'Usrname':'tom','Passiword':'pass@123'};
    WebEngagePlugin.setUserAttributes(details);
```

**Track Events**

```dart
import 'package:webengage_flutter/webengage_flutter.dart';
...
    // Track simple event
      WebEngagePlugin.trackEvent('Added to Cart');

      // Track event with attributes
      WebEngagePlugin.trackEvent('Order Placed', {'Amount': 808.48});
```

**Track Screens**

```dart
import 'package:webengage_flutter/webengage_flutter.dart';
...
    // Track screen
    WebEngagePlugin.trackScreen('Home Page');

    // Track screen with data
    WebEngagePlugin.trackScreen('Product Page', {'Product Id': 'UHUH799'});
```

**In-app Notification Callbacks**

Add below subscribeToInAppCallbacks() method in main.dart and call it from initMethod()

```dart
  void subscribeToInAppCallbacks() {
      WebEngagePlugin.onInApp.listen((message) {
        String? link = message.link;
        InAppMessageState state = message.state;
        Map<String, dynamic> data = message.data;
      });
  }
```

## More Info

- Checkout the [Sample main.dart](https://github.com/WebEngage/webengage-flutter/blob/development_flutter_sdk/example/lib/main.dart) for the sample application.
- Checkout the [developer documentation](https://docs.webengage.com/docs)

## Questions?

Reach out to our [Support Team](https://webengage.com/) for further assistance.

## Plugin info

[WebEngage Flutter SDK](https://pub.dev/packages/webengage_flutter)
