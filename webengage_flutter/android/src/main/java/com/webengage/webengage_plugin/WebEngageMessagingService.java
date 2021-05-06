package com.webengage.webengage_plugin;

import androidx.annotation.NonNull;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.webengage.sdk.android.WebEngage;

public class WebEngageMessagingService extends FirebaseMessagingService {
    @Override
    public void onNewToken(@NonNull String token) {
        WebEngage.get().setRegistrationID(token);
    }

    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        // messages are handled in receiver
    }
}
