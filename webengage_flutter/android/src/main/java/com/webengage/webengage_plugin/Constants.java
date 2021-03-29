package com.webengage.webengage_plugin;

public interface Constants {
    String WEBENGAGE_PLUGIN = "webengage_flutter";

    interface MethodName {
        String METHOD_NAME_SET_USER_LOGIN = "userLogin";
        String METHOD_NAME_SET_USER_LOGOUT = "userLogout";
        String METHOD_NAME_SET_USER_FIRST_NAME = "setUserFirstName";
        String METHOD_NAME_SET_USER_LAST_NAME = "setUserLastName";
        String METHOD_NAME_SET_USER_EMAIL = "setUserEmail";
        String METHOD_NAME_SET_USER_HASHED_EMAIL = "setUserHashedEmail";
        String METHOD_NAME_SET_USER_PHONE = "setUserPhone";
        String METHOD_NAME_SET_USER_HASHED_PHONE = "setUserHashedPhone";
        String METHOD_NAME_SET_USER_COMPANY = "setUserCompany";
        String METHOD_NAME_SET_USER_BIRTHDATE = "setUserBirthDate";
        String METHOD_NAME_SET_USER_GENDER = "setUserGender";
        String METHOD_NAME_SET_USER_OPT_IN = "setUserOptIn";
        String METHOD_NAME_SET_USER_LOCATION = "setUserLocation";
        String METHOD_NAME_SET_USER_ATTRIBUTE = "setUserAttribute";
        String METHOD_NAME_SET_USER_STRING_ATTRIBUTE = "setUserStringAttribute";
        String METHOD_NAME_SET_USER_MAP_ATTRIBUTE = "setUserMapAttribute";
        String METHOD_NAME_TRACK_EVENT = "trackEvent";
        String METHOD_NAME_TRACK_SCREEN = "trackScreen";
        String METHOD_NAME_ON_PUSH = "onPush";
        String METHOD_NAME_ON_IN_APP = "onInApp";
        String METHOD_NAME_ON_DEEP_LINK = "onDeepLink";
    }

    interface PARAM {
        String DATA = "data";
        String LINK = "link";
        String STATE = "state";
        String IN_APP_STATE_PREPARED = "prepared";
        String IN_APP_STATE_SHOWN = "shown";
        String IN_APP_STATE_DISSMISSED = "dissmissed";
        String IN_APP_STATE_CLICKED = "clicked";
        String SELECTED_ACTION_ID = "selectedActionId";
    }

    interface ARGS {
        String CHANNEL = "channel";
        String OPTIN = "optIn";
        String PUSH = "push";
        String SMS = "sms";
        String EMAIL = "email";
        String IN_APP = "in_app";
        String WHATSAPP = "whatsapp";
        String MALE = "male";
        String FEMALE = "female";
        String OTHER = "other";
        String LAT = "lat";
        String LNG = "lng";
        String EVENT_NAME = "eventName";
        String ATTRIBUTES = "attributes";
        String SCREEN_NAME = "screenName";
        String SCREEN_DATA = "screenData";
        String ATTRIBUTE_NAME = "attributeName";
    }
}
