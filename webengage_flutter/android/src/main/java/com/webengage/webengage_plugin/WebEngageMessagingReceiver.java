package com.webengage.webengage_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

public class WebEngageMessagingReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        RemoteMessage remoteMessage = new RemoteMessage(intent.getExtras());

        Map<String, String> data = remoteMessage.getData();
        if (data != null) {
            if (data.containsKey("source") && "webengage".equals(data.get("source"))) {
                Intent onBackgroundIntent = new Intent(context, WebEngageBackgroundService.class);
                onBackgroundIntent.putExtra(Constants.NOTIFICATION, remoteMessage);
                WebEngageBackgroundService.enqueueMessageProcessing(context, onBackgroundIntent);
            }
        }
    }
}
