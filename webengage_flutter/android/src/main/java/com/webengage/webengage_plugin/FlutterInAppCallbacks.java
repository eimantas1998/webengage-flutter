package com.webengage.webengage_plugin;

import android.content.Context;

import com.webengage.sdk.android.actions.render.InAppNotificationData;
import com.webengage.sdk.android.callbacks.InAppNotificationCallbacks;

import java.util.HashMap;
import java.util.Map;

import static com.webengage.webengage_plugin.Constants.PARAM.*;
import static com.webengage.webengage_plugin.Constants.MethodName.*;


public class FlutterInAppCallbacks implements InAppNotificationCallbacks {
    @Override
    public InAppNotificationData onInAppNotificationPrepared(Context context, InAppNotificationData inAppNotificationData) {
        Map<String, Object> data = Utils.jsonObjectToMap(inAppNotificationData.getData());
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_PREPARED);
            put(DATA, data);
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
        return inAppNotificationData;
    }

    @Override
    public void onInAppNotificationShown(Context context, InAppNotificationData inAppNotificationData) {
        Map<String, Object> data = Utils.jsonObjectToMap(inAppNotificationData.getData());
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_SHOWN);
            put(DATA, data);
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
    }

    @Override
    public boolean onInAppNotificationClicked(Context context, InAppNotificationData inAppNotificationData, String s) {
        Map<String, Object> data = Utils.jsonObjectToMap(inAppNotificationData.getData());
        data.put(SELECTED_ACTION_ID, s);
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_CLICKED);
            put(DATA, data);
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
        return false;
    }

    @Override
    public void onInAppNotificationDismissed(Context context, InAppNotificationData inAppNotificationData) {
        Map<String, Object> data = Utils.jsonObjectToMap(inAppNotificationData.getData());
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_DISSMISSED);
            put(DATA, data);
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
    }
}
