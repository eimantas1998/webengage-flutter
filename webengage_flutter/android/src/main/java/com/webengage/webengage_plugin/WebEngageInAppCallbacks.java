package com.webengage.webengage_plugin;

import android.content.Context;

import com.webengage.sdk.android.actions.render.InAppNotificationData;
import com.webengage.sdk.android.callbacks.InAppNotificationCallbacks;

import org.json.JSONArray;
import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;

import static com.webengage.webengage_plugin.Constants.PARAM.*;
import static com.webengage.webengage_plugin.Constants.MethodName.METHOD_NAME_ON_IN_APP;

public class WebEngageInAppCallbacks implements InAppNotificationCallbacks {
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
    public void onInAppNotificationDismissed(Context context, InAppNotificationData inAppNotificationData) {
        Map<String, Object> data = Utils.jsonObjectToMap(inAppNotificationData.getData());
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_DISMISSED);
            put(DATA, data);
        }};
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
    }

    @Override
    public boolean onInAppNotificationClicked(Context context, InAppNotificationData inAppNotificationData, String actionId) {
        JSONObject jsonObject = inAppNotificationData.getData();
        Map<String, Object> data = Utils.jsonObjectToMap(jsonObject);
        Map<String, Object> payload = new HashMap<String, Object>() {{
            put(STATE, IN_APP_STATE_CLICKED);
            put(DATA, data);

        }};
        JSONArray actions = jsonObject.optJSONArray("actions");
        if (actions != null && actionId != null) {
            for(int i = 0; i < actions.length(); ++i) {
                JSONObject action = actions.optJSONObject(i);
                if (action != null) {
                    if (actionId.equals(action.optString("actionEId"))) {
                        payload.put(LINK, action.optString("actionLink"));
                    }
                }
            }
        }
        WebEngagePlugin.sendOrQueueCallback(METHOD_NAME_ON_IN_APP, payload);
        return false;
    }
}
