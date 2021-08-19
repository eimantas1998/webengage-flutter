import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'webengage_flutter.dart';

/// Signature for a function that extracts a screen name from [RouteSettings].
///
/// Usually, the route name is not a plain string, and it may contains some
/// unique ids that makes it difficult to aggregate over them in WebEngage.
typedef ScreenNameExtractor = String? Function(RouteSettings settings);

String? defaultNameExtractor(RouteSettings settings) => settings.name;

/// A [NavigatorObserver] that sends events to WebEngage when the
/// currently active [PageRoute] changes.
///
/// When a route is pushed or popped, [nameExtractor] is used to extract a name
/// from [RouteSettings] of the now active route and that name is sent to
/// WebEngage.
///
/// The following operations will result in sending a screen view event:
/// ```dart
/// Navigator.pushNamed(context, '/contact/123');
///
/// Navigator.push<void>(context, MaterialPageRoute(
///   settings: RouteSettings(name: '/contact/123'),
///   builder: (_) => ContactDetail(123)));
///
/// Navigator.pushReplacement<void>(context, MaterialPageRoute(
///   settings: RouteSettings(name: '/contact/123'),
///   builder: (_) => ContactDetail(123)));
///
/// Navigator.pop(context);
/// ```
///
/// To use it, add it to the `navigatorObservers` of your [Navigator], e.g. if
/// you're using a [MaterialApp]:
/// ```dart
/// MaterialApp(
///   home: MyAppHome(),
///   navigatorObservers: [
///     WebEngageObserver(webengage: webengage),
///   ],
/// );
/// ```
///
/// You can also track screen views within your [PageRoute] by implementing
/// [PageRouteAware] and subscribing it to [WebEngageObserver]. See the
/// [PageRouteObserver] docs for an example.
class WebEngageObserver extends RouteObserver<PageRoute<dynamic>> {
  /// Creates a [NavigatorObserver] that sends events to [WebEngagePlugin].
  ///
  /// When a route is pushed or popped, [nameExtractor] is used to extract a
  /// name from [RouteSettings] of the now active route and that name is sent to
  /// Firebase. Defaults to `defaultNameExtractor`.
  ///
  /// If a [PlatformException] is thrown while the observer attempts to send the
  /// active route to [analytics], `onError` will be called with the
  /// exception. If `onError` is omitted, the exception will be printed using
  /// `debugPrint()`.
  WebEngageObserver({
    this.nameExtractor = defaultNameExtractor,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  final ScreenNameExtractor nameExtractor;
  final void Function(PlatformException error)? _onError;

  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenName = nameExtractor(route.settings);
    if (screenName != null) {
      WebEngagePlugin.trackScreen(screenName).catchError(
        (Object error) {
          final _onError = this._onError;
          if (_onError == null) {
            debugPrint('$WebEngageObserver: $error');
          } else {
            _onError(error as PlatformException);
          }
        },
        test: (Object error) => error is PlatformException,
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}