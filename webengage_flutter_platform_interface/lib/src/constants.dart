const String METHOD_NAME_REQUEST_PERMISSION = "requestPermission";
const String METHOD_NAME_SET_FOREGROUND_NOTIFICATION_PRESENTATION_OPTIONS =
    "setForegroundNotificationPresentationOptions";
const String METHOD_NAME_SET_USER_LOGIN = "userLogin";
const String METHOD_NAME_SET_USER_LOGOUT = "userLogout";
const String METHOD_NAME_SET_USER_FIRST_NAME = "setUserFirstName";
const String METHOD_NAME_SET_USER_LAST_NAME = "setUserLastName";
const String METHOD_NAME_SET_USER_EMAIL = "setUserEmail";
const String METHOD_NAME_SET_USER_HASHED_EMAIL = "setUserHashedEmail";
const String METHOD_NAME_SET_USER_PHONE = "setUserPhone";
const String METHOD_NAME_SET_USER_HASHED_PHONE = "setUserHashedPhone";
const String METHOD_NAME_SET_USER_COMPANY = "setUserCompany";
const String METHOD_NAME_SET_USER_BIRTHDATE = "setUserBirthDate";
const String METHOD_NAME_SET_USER_GENDER = "setUserGender";
const String METHOD_NAME_SET_USER_OPT_IN = "setUserOptIn";
const String METHOD_NAME_SET_USER_LOCATION = "setUserLocation";
const String METHOD_NAME_SET_USER_ATTRIBUTE = "setUserAttribute";
const String METHOD_NAME_SET_USER_MAP_ATTRIBUTE = "setUserMapAttribute";
const String METHOD_NAME_TRACK_EVENT = "trackEvent";
const String METHOD_NAME_TRACK_SCREEN = "trackScreen";
const String METHOD_NAME_ON_PUSH = "onPush";
const String METHOD_NAME_ON_IN_APP = "onInApp";
const String METHOD_NAME_ON_DEEP_LINK = "onDeepLink";

const String DATA = 'data';
const String LINK = 'link';
const String STATE = 'state';
const String TITLE = 'title';
const String MESSAGE = 'message';

enum InAppMessageState {
  prepared,
  shown,
  dissmissed,
  clicked,
}

enum PushNotificationState {
  shown,
  dissmissed,
  clicked,
}

const String CHANNEL = "channel";
const String OPTIN = "optIn";

enum OptInChannel {
  push,
  sms,
  email,
  in_app,
  whatsapp,
}

enum Gender {
  male,
  female,
  other,
}

const String LAT = "lat";
const String LNG = "lng";
const String EVENT_NAME = "eventName";
const String SCREEN_NAME = "screenName";
const String SCREEN_DATA = "screenData";
const String ATTRIBUTES = "attributes";
const String ATTRIBUTE_NAME = "attributeName";
