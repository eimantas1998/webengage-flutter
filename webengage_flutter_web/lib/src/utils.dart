import 'package:js/js_util.dart' as util;

import 'js_interop.dart' as js;

dynamic jsifyList(Iterable list) => js.toJSArray(list.map(jsify).toList());

/// Returns the JS implementation from Dart Object.
dynamic jsify(Object? dartObject) {
  if (_isBasicType(dartObject)) {
    return dartObject;
  }

  if (dartObject is Iterable) {
    return jsifyList(dartObject);
  }

  if (dartObject is Map) {
    final jsMap = util.newObject();
    dartObject.forEach((key, value) {
      util.setProperty(jsMap, key, jsify(value));
    });
    return jsMap;
  }
  throw ArgumentError.value(dartObject, 'dartObject', 'Could not convert');
}

/// Returns `true` if the [value] is a very basic built-in type - e.g.
/// `null`, [num], [bool] or [String]. It returns `false` in the other case.
bool _isBasicType(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return true;
  }
  return false;
}
