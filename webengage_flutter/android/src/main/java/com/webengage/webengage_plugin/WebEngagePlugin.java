package com.webengage.webengage_plugin;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.content.pm.PackageManager;
import android.os.Bundle;

import com.google.firebase.messaging.FirebaseMessaging;
import com.webengage.sdk.android.Channel;
import com.webengage.sdk.android.LocationTrackingStrategy;
import com.webengage.sdk.android.WebEngage;
import com.webengage.sdk.android.WebEngageConfig;
import com.webengage.sdk.android.utils.Gender;

import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import static com.webengage.webengage_plugin.Constants.ARGS.*;
import static com.webengage.webengage_plugin.Constants.MethodName.*;
import static com.webengage.webengage_plugin.Constants.WEBENGAGE_PLUGIN;
import static com.webengage.webengage_plugin.Constants.TAG;

public class WebEngagePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static MethodChannel channel;
    private static final Map<String, Map<String, Object>> messageQueue =
            Collections.synchronizedMap(new LinkedHashMap<>());
    public static boolean isInitialised = false;
    public static boolean isAttachedToEngine = false;

    private Activity activity;

    public static String getPackageName(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(
                    context.getPackageName(), 0).packageName;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getMetadata(Context context, String key) {
        try {
            Bundle metaData = context.getPackageManager()
                    .getApplicationInfo(context.getPackageName(),
                            PackageManager.GET_META_DATA).metaData;
            return metaData.get(key).toString();
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        this.channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), WEBENGAGE_PLUGIN);
        channel.setMethodCallHandler(this);
        this.isAttachedToEngine = true;
        if (!isInitialised) {
            initialize(flutterPluginBinding.getApplicationContext());
        }
        FirebaseMessaging.getInstance().getToken().addOnSuccessListener(token -> WebEngage.get().setRegistrationID(token));
        synchronized (messageQueue) {
            // Handle all the messages received before the Dart isolate was
            // initialized, then clear the queue.
            for (Map.Entry<String, Map<String, Object>> entry :
                    messageQueue.entrySet()) {
                sendCallback(entry.getKey(), entry.getValue());
            }
            messageQueue.clear();
        }
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        this.isAttachedToEngine = false;
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case METHOD_NAME_SET_USER_LOGIN:
                userLogin(call, result);
                break;

            case METHOD_NAME_SET_USER_LOGOUT:
                userLogout(call, result);
                break;

            case METHOD_NAME_SET_USER_FIRST_NAME:
                setUserFirstName(call, result);
                break;

            case METHOD_NAME_SET_USER_LAST_NAME:
                setUserLastName(call, result);
                break;

            case METHOD_NAME_SET_USER_EMAIL:
                setUserEmail(call, result);
                break;

            case METHOD_NAME_SET_USER_HASHED_EMAIL:
                setUserHashedEmail(call, result);
                break;

            case METHOD_NAME_SET_USER_PHONE:
                setUserPhone(call, result);
                break;

            case METHOD_NAME_SET_USER_HASHED_PHONE:
                setUserHashedPhone(call, result);
                break;

            case METHOD_NAME_SET_USER_COMPANY:
                setUserCompany(call, result);
                break;

            case METHOD_NAME_SET_USER_BIRTHDATE:
                setUserBirthDate(call, result);
                break;

            case METHOD_NAME_SET_USER_GENDER:
                setUserGender(call, result);
                break;

            case METHOD_NAME_SET_USER_OPT_IN:
                setUserOptIn(call, result);
                break;

            case METHOD_NAME_SET_USER_LOCATION:
                setUserLocation(call, result);
                break;

            case METHOD_NAME_TRACK_EVENT:
                trackEvent(call, result);
                break;

            case METHOD_NAME_TRACK_SCREEN:
                trackScreen(call, result);
                break;

            case METHOD_NAME_SET_USER_ATTRIBUTE:
                setUserAttribute(call, result);
                break;

            case METHOD_NAME_SET_USER_MAP_ATTRIBUTE:
                setUserMapAttribute(call, result);
                break;

            default:
                result.notImplemented();
        }
    }

    public static void initialize(Context context) {
        WebEngage.registerPushNotificationCallback(new WebEngageNotificationCallbacks());
        WebEngage.registerInAppNotificationCallback(new WebEngageInAppCallbacks());
        WebEngageConfig config =
                new WebEngageConfig.Builder()
                        .setWebEngageKey(getMetadata(context, "com.webengage.sdk.android.key"))
                        .build();
        WebEngage.engage(context, config);
        isInitialised = true;
        WebEngageBackgroundService.onInitialized();
    }

    private void userLogin(MethodCall call, Result result) {
        String userId = call.arguments();
        WebEngage.get().user().login(userId);
        result.success(null);
    }

    private void userLogout(MethodCall call, Result result) {
        WebEngage.get().user().logout();
        result.success(null);
    }

    private void setUserFirstName(MethodCall call, Result result) {
        String firstName = call.arguments();
        WebEngage.get().user().setFirstName(firstName);
        result.success(null);
    }

    private void setUserLastName(MethodCall call, Result result) {
        String lastName = call.arguments();
        WebEngage.get().user().setLastName(lastName);
        result.success(null);
    }

    private void setUserEmail(MethodCall call, Result result) {
        String email = call.arguments();
        WebEngage.get().user().setEmail(email);
        result.success(null);
    }

    private void setUserHashedEmail(MethodCall call, Result result) {
        String hashedEmail = call.arguments();
        WebEngage.get().user().setHashedEmail(hashedEmail);
        result.success(null);
    }

    private void setUserPhone(MethodCall call, Result result) {
        String phone = call.arguments();
        WebEngage.get().user().setPhoneNumber(phone);
        result.success(null);
    }

    private void setUserHashedPhone(MethodCall call, Result result) {
        String hashedPhone = call.arguments();
        WebEngage.get().user().setHashedPhoneNumber(hashedPhone);
        result.success(null);
    }

    private void setUserCompany(MethodCall call, Result result) {
        String company = call.arguments();
        WebEngage.get().user().setCompany(company);
        result.success(null);
    }

    private void setUserBirthDate(MethodCall call, Result result) {
        String birthDate = call.arguments();
        WebEngage.get().user().setBirthDate(birthDate);
        result.success(null);
    }

    private void setUserGender(MethodCall call, Result result) {
        String gender = call.arguments();
        if (MALE.equalsIgnoreCase(gender)) {
            WebEngage.get().user().setGender(Gender.MALE);
        } else if (FEMALE.equalsIgnoreCase(gender)) {
            WebEngage.get().user().setGender(Gender.FEMALE);
        } else if (OTHER.equalsIgnoreCase(gender)) {
            WebEngage.get().user().setGender(Gender.OTHER);
        }
        result.success(null);
    }

    private void setUserOptIn(MethodCall call, Result result) {
        String channel = call.argument(CHANNEL);
        boolean status = call.argument(OPTIN);
        if (PUSH.equalsIgnoreCase(channel)) {
            WebEngage.get().user().setOptIn(Channel.PUSH, status);
        } else if (SMS.equalsIgnoreCase(channel)) {
            WebEngage.get().user().setOptIn(Channel.SMS, status);
        } else if (EMAIL.equalsIgnoreCase(channel)) {
            WebEngage.get().user().setOptIn(Channel.EMAIL, status);
        } else if (IN_APP.equalsIgnoreCase(channel)) {
            WebEngage.get().user().setOptIn(Channel.IN_APP, status);
        } else if (WHATSAPP.equalsIgnoreCase(channel)) {
            WebEngage.get().user().setOptIn(Channel.WHATSAPP, status);
        } else {
            result.error(TAG, "Invalid channel: " + channel + ". Must be one of [push, sms, email, in_app, whatsapp].", null);
        }
        result.success(null);
    }

    private void setUserLocation(MethodCall call, Result result) {
        double lat = call.argument(LAT);
        double lng = call.argument(LNG);
        WebEngage.get().user().setLocation(lat, lng);
        result.success(null);
    }

    private void setUserMapAttribute(MethodCall call, Result result) {
        Map<String, ? extends Object> attributes = call.argument(ATTRIBUTES);
        WebEngage.get().user().setAttributes(attributes);
        result.success(null);
    }

    private void setUserAttribute(MethodCall call, Result result) {
        if (call.argument(ATTRIBUTES) instanceof String) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            String attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else if (call.argument(ATTRIBUTES) instanceof Integer) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            int attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else if (call.argument(ATTRIBUTES) instanceof Double || call.argument(ATTRIBUTES) instanceof Float) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            double attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else if (call.argument(ATTRIBUTES) instanceof Date) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            Date attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else if (call.argument(ATTRIBUTES) instanceof List) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            List<? extends Object> attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else if (call.argument(ATTRIBUTES) instanceof Boolean) {
            String attributeName = call.argument(ATTRIBUTE_NAME);
            Boolean attributes = call.argument(ATTRIBUTES);
            WebEngage.get().user().setAttribute(attributeName, attributes);
        } else {
            Log.d(TAG, "No other type supported");
        }
        result.success(null);
    }

    private void trackEvent(MethodCall call, Result result) {
        String eventName = call.argument(EVENT_NAME);
        Map<String, Object> attributes = call.argument(ATTRIBUTES);
        WebEngage.get().analytics().track(eventName, attributes);
        result.success(null);
    }

    private void trackScreen(MethodCall call, Result result) {
        String screenName = call.argument(SCREEN_NAME);
        Map<String, Object> screenData = call.argument(SCREEN_DATA);
        if (screenData == null) {
            WebEngage.get().analytics().screenNavigated(screenName);
        } else {
            WebEngage.get().analytics().screenNavigated(screenName, screenData);
        }
        result.success(null);
    }

    static void sendOrQueueCallback(String methodName, Map<String, Object> message) {
        if (isAttachedToEngine) {
            sendCallback(methodName, message);
        } else {
            messageQueue.put(methodName, message);
        }
    }

    static void sendCallback(final String methodName, final Map<String, Object> message) {
        new Handler(Looper.getMainLooper()).post(() -> channel.invokeMethod(methodName, message));
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        WebEngage.get().analytics().start(activity);
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        WebEngage.get().analytics().stop(activity);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }
}
