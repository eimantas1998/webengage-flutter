package com.webengage.webengage_plugin;

import android.content.Context;
import android.util.Log;

import com.webengage.sdk.android.actions.render.CallToAction;
import com.webengage.sdk.android.actions.render.PushNotificationData;
import com.webengage.sdk.android.callbacks.PushNotificationCallbacks;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static com.webengage.webengage_plugin.Constants.PARAM.*;
import static com.webengage.webengage_plugin.Constants.MethodName.*;

public class WebEngageNotificationCallbacks implements PushNotificationCallbacks {
    @Override
    public PushNotificationData onPushNotificationReceived(Context context, PushNotificationData pushNotificationData) {
        return pushNotificationData;
    }

    @Override
    public void onPushNotificationShown(Context context, PushNotificationData pushNotificationData) {
        Map<String, Object> payload = Utils.notificationToMap(pushNotificationData, NOTIFICATION_STATE_SHOWN);
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
    }

    @Override
    public void onPushNotificationDismissed(Context context, PushNotificationData pushNotificationData) {
        Map<String, Object> payload = Utils.notificationToMap(pushNotificationData, NOTIFICATION_STATE_DISMISSED);
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
    }

    @Override
    public boolean onPushNotificationClicked(Context context, PushNotificationData pushNotificationData) {
        Map<String, Object> payload = Utils.notificationToMap(pushNotificationData, NOTIFICATION_STATE_CLICKED);
        CallToAction callToAction = pushNotificationData.getPrimeCallToAction();
        if (callToAction != null) {
            String action = callToAction.getAction();
            payload.put(LINK, action);
        }
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
        return false;
    }

    @Override
    public boolean onPushNotificationActionClicked(Context context, PushNotificationData pushNotificationData, String actionId) {
        Map<String, Object> payload = Utils.notificationToMap(pushNotificationData, NOTIFICATION_STATE_CLICKED);
        if (actionId != null) {
            CallToAction callToAction = pushNotificationData.getCallToActionById(actionId);
            if (callToAction != null) {
                String action = callToAction.getAction();
                payload.put(LINK, action);
            }
        }
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_PUSH, payload);
        return false;
    }
}
