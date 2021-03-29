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
const String METHOD_NAME_SET_USER_STRING_ATTRIBUTE = "setUserStringAttribute";
const String METHOD_NAME_SET_USER_MAP_ATTRIBUTE = "setUserMapAttribute";
const String METHOD_NAME_TRACK_EVENT = "trackEvent";
const String METHOD_NAME_TRACK_SCREEN = "trackScreen";

const String METHOD_NAME_ON_PUSH = "onPush";
const String METHOD_NAME_ON_IN_APP = "onInApp";
const String METHOD_NAME_ON_DEEP_LINK = "onDeepLink";

const String LINK = 'link';
const String DATA = 'data';
const String STATE = 'state';

enum InAppMessageState {
  prepared,
  shown,
  dissmissed,
  clicked,
}

const String SELECTED_ACTION_ID = 'selectedActionId';

const String TITLE = 'title';
const String BODY = 'body';
const String ACTION = 'action';

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
const String ATTRIBUTES = "attributes";
const String ATTRIBUTE_NAME = "attributeName";
const String SCREEN_NAME = "screenName";
const String SCREEN_DATA = "screenData";
const String DEEPLINK = "deeplink";
const String PAYLOAD = "payload";
const String URI = "uri";
