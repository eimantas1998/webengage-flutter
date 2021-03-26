import 'package:flutter/material.dart';

import 'package:webengage_flutter/webengage_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebEngagePlugin _webEngagePlugin;

  @override
  void initState() {
    super.initState();
    initWebEngage();
  }

  void initWebEngage() {
    _webEngagePlugin = WebEngagePlugin();
    WebEngagePlugin.onPush.listen((push) => print(push.toString()));
    WebEngagePlugin.onInApp.listen((inApp) => print(inApp.toString()));
    WebEngagePlugin.onDeepLink.listen(print);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: <Widget>[
              new ListTile(
                title: Text("Login"),
                onTap: () {
                  String s = "test" + randomString(6);
                  _webEngagePlugin.userLogin(s);
                  showToast("Login-" + s);
                },
              ),
              new ListTile(
                title: Text("Logout"),
                onTap: () {
                  _webEngagePlugin.userLogout();
                  showToast("Logout");
                },
              ),
              new ListTile(
                title: Text("Set FirstName"),
                onTap: () {
                  _webEngagePlugin.setUserFirstName('Sourabh');
                  showToast("User FirstName- Sourabh");
                },
              ),
              new ListTile(
                title: Text("Set LastName"),
                onTap: () {
                  _webEngagePlugin.setUserLastName('Gupta');
                  showToast("LastName Gupta");
                },
              ),
              new ListTile(
                title: Text("Set UserEmail"),
                onTap: () {
                  _webEngagePlugin.setUserEmail('ram@gmail.com');
                  showToast("Email - ram@gmail.com");
                },
              ),
              new ListTile(
                title: Text("Set UserHashedEmail"),
                onTap: () {
                  _webEngagePlugin
                      .setUserHashedEmail('144e0424883546e07dcd727057fd3b62');
                  showToast("HashedEmail - 144e0424883546e07dcd727057fd3b62");
                },
              ),
              new ListTile(
                title: Text("Set UserPhone"),
                onTap: () {
                  _webEngagePlugin.setUserPhone('+919999900000');
                  showToast("Phone - +919999900000");
                },
              ),
              new ListTile(
                title: Text("Set UserHashedPhone"),
                onTap: () {
                  _webEngagePlugin
                      .setUserHashedPhone('e0ec043b3f9e198ec09041687e4d4e8d');
                  showToast("HashedPhone - e0ec043b3f9e198ec09041687e4d4e8d");
                },
              ),
              new ListTile(
                title: Text("Set UserCompany"),
                onTap: () {
                  _webEngagePlugin.setUserCompany('WebEngage');
                  showToast("Company - WebEngage");
                },
              ),
              new ListTile(
                title: Text("Set UserBirthDate"),
                onTap: () {
                  _webEngagePlugin.setUserBirthDate('1994-05-24');
                  showToast("BirthDate - 1994-05-24");
                },
              ),
              new ListTile(
                title: Text("Set User Gender"),
                onTap: () {
                  _webEngagePlugin.setUserGender('male');
                  showToast("Gender - Male");
                },
              ),
              new ListTile(
                title: Text("Set User Location"),
                onTap: () {
                  _webEngagePlugin.setUserLocation(19.25, 72.45);
                  showToast("Location - 19.25, 72.45");
                },
              ),
              new ListTile(
                title: Text("Track Event with no attributes"),
                onTap: () {
                  _webEngagePlugin.trackEvent('Added to Cart');
                  showToast("Added to Cart tracked ");
                },
              ),
              new ListTile(
                title: Text("Opt-In  Push, InApp,email,sms"),
                onTap: () {
                  _webEngagePlugin.setUserOptIn('in_app', true);
                  _webEngagePlugin.setUserOptIn('sms', true);
                  _webEngagePlugin.setUserOptIn('push', true);
                  _webEngagePlugin.setUserOptIn('email', true);
                  showToast("Opt-In  Push, InApp,email,sms ");
                },
              ),
              new ListTile(
                title: Text("Opt-Out  Push, InApp,email,sms"),
                onTap: () {
                  _webEngagePlugin.setUserOptIn('in_app', false);
                  _webEngagePlugin.setUserOptIn('sms', false);
                  _webEngagePlugin.setUserOptIn('push', false);
                  _webEngagePlugin.setUserOptIn('email', false);
                  showToast("Opt-Out  Push, InApp,email,sms ");
                },
              ),
              new ListTile(
                title: Text("Track event with attributes"),
                onTap: () {
                  _webEngagePlugin
                      .trackEvent('Order Placed', {'Amount': 808.48});
                  showToast("Order Placed tracked Amount: 808.48");
                },
              ),
              new ListTile(
                title: Text("Track Screen"),
                onTap: () {
                  _webEngagePlugin.trackScreen('Home Page');
                  showToast("Track Screen :Home Page");
                },
              ),
              new ListTile(
                title: Text("Track Screen with data"),
                onTap: () {
                  _webEngagePlugin
                      .trackScreen('Product Page', {'Product Id': 'UHUH799'});
                  showToast(
                      "Track Screen :Product Page', {'Product Id': 'UHUH799'}");
                },
              ),
              new ListTile(
                title: Text("Set User attribute with string value "),
                onTap: () {
                  _webEngagePlugin.setUserAttribute(
                      "twitterusename", "saurav12994");
                  showToast("twitterusename:saurav12994");
                },
              ),
              // _webEngagePlugin.setUserAttribute("twitterusename", "saurav12994");
              // _webEngagePlugin.setUserAttribute("Subscribed to email", true);
              // _webEngagePlugin.setUserAttribute("Points earned", 2626);
              // _webEngagePlugin.setUserAttribute("Dollar Spent", 123.44);
              new ListTile(
                title: Text("Set User attribute with Double value "),
                onTap: () {
                  _webEngagePlugin.setUserAttribute("Dollar Spent", 123.44);
                  showToast("Dollar Spent:123.44");
                },
              ),
              new ListTile(
                title: Text("Set User attribute with Boolean value "),
                onTap: () {
                  _webEngagePlugin.setUserAttribute(
                      "Subscribed to email", true);
                  showToast("Subscribed to email:true");
                },
              ),
              new ListTile(
                title: Text("Set User attribute with Integer value "),
                onTap: () {
                  _webEngagePlugin.setUserAttribute("Points earned", 2626);
                  showToast("Points earned:2626");
                },
              ),
              new ListTile(
                title: Text("Set User attribute with Map value "),
                onTap: () {
                  var details = {'Usrname': 'tom', 'Passiword': 'pass@123'};

                  _webEngagePlugin.setUserAttributes(details);
                  showToast("Usrname':'tom','Passiword':'pass@123");
                },
              ),
              new ListTile(
                title: Text("Track Date"),
                onTap: () {
                  final DateTime now = DateTime.now();
                  final DateFormat formatter =
                      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
                  _webEngagePlugin.trackEvent(
                      'Register', {'Registered On': formatter.format(now)});
                  showToast("Track ${formatter.format(now)}");
                },
              ),
            ],
          )),
    );
  }

  void showToast(String msg) {
    print(msg);
  }
}
