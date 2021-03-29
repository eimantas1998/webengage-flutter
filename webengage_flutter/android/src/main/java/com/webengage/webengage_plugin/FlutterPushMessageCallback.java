package com.webengage.webengage_plugin;

import android.content.Context;

import com.webengage.sdk.android.actions.render.PushNotificationData;
import com.webengage.sdk.android.callbacks.PushNotificationCallbacks;

import java.util.HashMap;
import java.util.Map;

import static com.webengage.webengage_plugin.Constants.PARAM.*;
import static com.webengage.webengage_plugin.Constants.MethodName.*;

public class FlutterPushMessageCallback implements PushNotificationCallbacks {
    @Override
    public PushNotificationData onPushNotificationReceived(Context context, PushNotificationData pushNotificationData) {

        return pushNotificationData;
    }

    @Override
    public void onPushNotificationShown(Context context, PushNotificationData pushNotificationData) {

    }

    @Override
    public boolean onPushNotificationClicked(Context context, PushNotificationData pushNotificationData) {
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(LINK, pushNotificationData.getPrimeCallToAction().getAction());
            put(DATA, pushNotificationData.toString());
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
        return false;
    }

    @Override
    public void onPushNotificationDismissed(Context context, PushNotificationData pushNotificationData) {

    }

    @Override
    public boolean onPushNotificationActionClicked(Context context, PushNotificationData pushNotificationData, String s) {
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(LINK, pushNotificationData.getCallToActionById(s).getAction());
            put(DATA, pushNotificationData.toString());
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
        return false;
    }

}
