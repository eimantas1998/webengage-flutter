package com.webengage.webengage_plugin;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.webengage.sdk.android.WebEngage;

import java.util.Map;

public class WebEngageMessagingService extends FirebaseMessagingService {
    @Override
    public void onNewToken(String token) {
        WebEngage.get().setRegistrationID(token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Map<String, String> data = remoteMessage.getData();
        if (data != null) {
            if (data.containsKey("source") &&
                    "webengage".equals(data.get("source"))) {
                WebEngage.get().receive(data);
            }
        }
    }
}