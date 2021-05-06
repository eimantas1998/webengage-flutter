package com.webengage.webengage_plugin;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.JobIntentService;

import com.google.firebase.messaging.RemoteMessage;
import com.webengage.sdk.android.WebEngage;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class WebEngageBackgroundService extends JobIntentService {
    private static final List<Intent> messagingQueue =
            Collections.synchronizedList(new LinkedList<>());

    @Override
    protected void onHandleWork(@NonNull Intent intent) {
        synchronized (messagingQueue) {
            if (WebEngagePlugin.isInitialised) {
                handleIntent(intent);
            } else {
                messagingQueue.add(intent);
            }
        }
    }

    public static void enqueueMessageProcessing(Context context, Intent messageIntent) {
        enqueueWork(
                context,
                WebEngageBackgroundService.class,
                Constants.JOB_ID,
                messageIntent);
        if (!WebEngagePlugin.isInitialised) {
            WebEngagePlugin.initialize(context);
        }
    }

    static void onInitialized() {
        synchronized (messagingQueue) {
            // Handle all the message events received before the Dart isolate was
            // initialized, then clear the queue.
            for (Intent intent : messagingQueue) {
                handleIntent(intent);
            }
            messagingQueue.clear();
        }
    }

    private static void handleIntent(Intent intent) {
        RemoteMessage remoteMessage = intent.getParcelableExtra(Constants.NOTIFICATION);
        WebEngage.get().receive(remoteMessage.getData());
    }
}
