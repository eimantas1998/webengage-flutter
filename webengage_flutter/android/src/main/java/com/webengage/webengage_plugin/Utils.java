package com.webengage.webengage_plugin;

import android.app.ActivityManager;
import android.app.KeyguardManager;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.webengage.sdk.android.actions.render.PushNotificationData;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static com.webengage.webengage_plugin.Constants.PARAM.MESSAGE;
import static com.webengage.webengage_plugin.Constants.PARAM.TITLE;
import static com.webengage.webengage_plugin.Constants.PARAM.DATA;
import static com.webengage.webengage_plugin.Constants.PARAM.STATE;

public class Utils {
    static Map<String, Object> notificationToMap(PushNotificationData pushNotificationData, String state) {
        Map<String, Object> map = new HashMap<String, Object>() {{
            put(STATE, state);
            put(TITLE, pushNotificationData.getTitle());
            put(MESSAGE, pushNotificationData.getContentText());
        }};
        Map<String, Object> data = new HashMap<String, Object>();
        Bundle bundle = pushNotificationData.getCustomData();
        Set<String> keys = bundle.keySet();
        for (String key : keys) {
            Object value = bundle.get(key);
            if (value != null) {
                data.put(key, value);
            }
        }
        map.put(DATA, data);
        return map;
    }

    static Map<String, Object> jsonObjectToMap(JSONObject jsonObject) {
        Map<String, Object> stringObjectMap = new HashMap<>();
        String key;
        Object value;

        if (jsonObject != null) {
            Iterator iterator = jsonObject.keys();
            while (iterator.hasNext()) {
                key = iterator.next().toString();
                try {
                    value = jsonObject.get(key);
                } catch (JSONException ex) {
                    Log.e("WebengageError", "JSON to Map error", ex);
                    return stringObjectMap;
                }
                stringObjectMap.put(key, value.toString());
            }
        }
        return stringObjectMap;
    }
}
