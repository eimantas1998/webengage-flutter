#import <WebEngage/WebEngage.h>

#import "WebEngagePlugin.h"
#import "WebEngageConstants.h"

NSString *const kMessagingPresentationOptionsUserDefaults =
@"webengage_flutter_presentation_options";

@implementation WebEngagePlugin {
    FlutterMethodChannel *_channel;
}

- (instancetype)initWithFlutterMethodChannel:(FlutterMethodChannel *)channel andFlutterPluginRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _channel = channel;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    NSLog(@"[WebEngagePlugin] registerWithRegistrar");
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:WEBENGAGE_PLUGIN binaryMessenger:[registrar messenger]];
    id instance = [[WebEngagePlugin alloc] initWithFlutterMethodChannel:channel andFlutterPluginRegistrar:registrar];
    [WebEngage sharedInstance].pushNotificationDelegate = instance;
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"[WebEngagePlugin] didFinishLaunchingWithOptions");
    return [[WebEngage sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions notificationDelegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    NSLog(@"[WebEngagePlugin] continueUserActivity");
    [[[WebEngage sharedInstance] deeplinkManager] getAndTrackDeeplink:userActivity.webpageURL callbackBlock:^(id location){
        [self trackDeeplinkURLCallback:location];
    }];
    return YES;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([METHOD_NAME_REQUEST_PERMISSION isEqualToString:call.method]) {
        [self messagingRequestPermission:call withResult:result];
    } else if ([METHOD_NAME_SET_FOREGROUND_NOTIFICATION_PRESENTATION_OPTIONS isEqualToString:call.method]) {
        [self messagingSetForegroundNotificationPresentationOptions:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_LOGIN isEqualToString:call.method]) {
        [self userLogin:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_LOGOUT isEqualToString:call.method]) {
        [self userLogout:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_FIRST_NAME isEqualToString:call.method]) {
        [self setUserFirstName:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_LAST_NAME isEqualToString:call.method]) {
        [self setUserLastName:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_EMAIL isEqualToString:call.method]) {
        [self setUserEmail:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_HASHED_EMAIL isEqualToString:call.method]) {
        [self setUserHashedEmail:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_PHONE isEqualToString:call.method]) {
        [self setUserPhone:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_HASHED_PHONE isEqualToString:call.method]) {
        [self setUserHashedPhone:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_COMPANY isEqualToString:call.method]) {
        [self setUserCompany:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_BIRTHDATE isEqualToString:call.method]) {
        [self setUserBirthDate:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_GENDER isEqualToString:call.method]) {
        [self setUserGender:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_OPT_IN isEqualToString:call.method]) {
        [self setUserOptIn:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_LOCATION isEqualToString:call.method]) {
        [self setUserLocation:call withResult:result];
    } else if ([METHOD_NAME_TRACK_EVENT isEqualToString:call.method]) {
        [self trackEvent:call withResult:result];
    } else if ([METHOD_NAME_TRACK_SCREEN isEqualToString:call.method]) {
        [self trackScreen:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_ATTRIBUTE isEqualToString:call.method]) {
        [self setUserAttribute:call withResult:result];
    } else if ([METHOD_NAME_SET_USER_MAP_ATTRIBUTE isEqualToString:call.method]) {
        [self setUserAttributes:call withResult:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void) messagingRequestPermission:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionNone;
    
    if ([call.arguments[@"alert"] isEqual:@(YES)]) {
        options |= UNAuthorizationOptionAlert;
    }
    
    if ([call.arguments[@"badge"] isEqual:@(YES)]) {
        options |= UNAuthorizationOptionBadge;
    }
    
    if ([call.arguments[@"sound"] isEqual:@(YES)]) {
        options |= UNAuthorizationOptionSound;
    }
    
    if ([call.arguments[@"provisional"] isEqual:@(YES)]) {
        if (@available(iOS 12.0, *)) {
            options |= UNAuthorizationOptionProvisional;
        }
    }
    
    if ([call.arguments[@"announcement"] isEqual:@(YES)]) {
        if (@available(iOS 13.0, *)) {
            options |= UNAuthorizationOptionAnnouncement;
        }
    }
    
    if ([call.arguments[@"carPlay"] isEqual:@(YES)]) {
        options |= UNAuthorizationOptionCarPlay;
    }
    
    if ([call.arguments[@"criticalAlert"] isEqual:@(YES)]) {
        if (@available(iOS 12.0, *)) {
            options |= UNAuthorizationOptionCriticalAlert;
        }
    }
    
    id handler = ^(BOOL granted, NSError *_Nullable error) {
        if (error != nil) {
            result(@(NO));
        } else {
            [center getNotificationSettingsWithCompletionHandler:^(
                                                                   UNNotificationSettings *_Nonnull settings) {
                result(@(YES));
            }];
        }
    };
    
    [center requestAuthorizationWithOptions:options completionHandler:handler];
}

- (void)messagingSetForegroundNotificationPresentationOptions:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSMutableDictionary *persistedOptions = [NSMutableDictionary dictionary];
    if ([call.arguments[@"alert"] isEqual:@(YES)]) {
        persistedOptions[@"alert"] = @YES;
    }
    if ([call.arguments[@"badge"] isEqual:@(YES)]) {
        persistedOptions[@"badge"] = @YES;
    }
    if ([call.arguments[@"sound"] isEqual:@(YES)]) {
        persistedOptions[@"sound"] = @YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:persistedOptions
                                              forKey:kMessagingPresentationOptionsUserDefaults];
    result(nil);
}


- (void) userLogin:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * userId = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser login:userId];
    result(nil);
}

- (void) userLogout:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser logout];
    result(nil);
}

- (void) setUserFirstName:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * firstName = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setFirstName:firstName];
    result(nil);
}

- (void) setUserLastName:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * lastName = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setLastName:lastName];
    result(nil);
}

- (void) setUserEmail:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * email = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setEmail:email];
    result(nil);
}

- (void) setUserHashedEmail:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * hashedEmail = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setHashedEmail:hashedEmail];
    result(nil);
}

- (void) setUserPhone:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * phone = call.arguments;
    WEGUser* weUser = [WebEngage sharedInstance].user;
    [weUser setPhone:phone];
    result(nil);
}

- (void) setUserHashedPhone:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * hashedPhone = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setHashedPhone:hashedPhone];
    result(nil);
}

- (void) setUserCompany:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * company = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setCompany:company];
    result(nil);
}

- (void) setUserBirthDate:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * birthDate = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setBirthDateString:birthDate];
    result(nil);
}

- (void) setUserGender:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * gender = call.arguments;
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setGender:gender];
    result(nil);
}

- (void) setUserOptIn:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * channel = call.arguments[CHANNEL];
    NSLocale* locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSString* ch = [channel lowercaseStringWithLocale:locale];
    
    BOOL status;
    
    if ([call.arguments[OPTIN] isEqual:@(YES)]) {
        status = YES;
    } else {
        status = NO;
    }
    
    WEGUser * weUser = [WebEngage sharedInstance].user;
    
    if ([ch isEqualToString:PUSH]) {
        [weUser setOptInStatusForChannel:WEGEngagementChannelPush status:status];
        result(nil);
    } else if ([ch isEqualToString:SMS]) {
        [weUser setOptInStatusForChannel:WEGEngagementChannelSMS status:status];
        result(nil);
    } else if ([ch isEqualToString:EMAIL]) {
        [weUser setOptInStatusForChannel:WEGEngagementChannelEmail status:status];
        result(nil);
    } else if ([ch isEqualToString:IN_APP]) {
        [weUser setOptInStatusForChannel:WEGEngagementChannelInApp status:status];
        result(nil);
    } else if ([ch isEqualToString:WHATSAPP]) {
        [weUser setOptInStatusForChannel:WEGEngagementChannelWhatsapp status:status];
        result(nil);
    } else {
        NSString * msg = [NSString stringWithFormat:@"Invalid channel: %@. Must be one of [push, sms, email, in_app, whatsapp].", ch];
        result([FlutterError errorWithCode:@"WebEngagePlugin" message:msg details:nil]);
    }
}

- (void) setUserLocation:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSNumber * lat = call.arguments[LAT];
    NSNumber * lng = call.arguments[LNG];
    WEGUser * weUser = [WebEngage sharedInstance].user;
    [weUser setUserLocationWithLatitude:lat andLongitude:lng];
    result(nil);
}

- (void) trackEvent:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * eventName = call.arguments[EVENT_NAME];
    NSDictionary * attributes = call.arguments[ATTRIBUTES];
    id<WEGAnalytics> weAnalytics = [WebEngage sharedInstance].analytics;
    if (attributes && ![attributes isKindOfClass:[NSNull class]]) {
        [weAnalytics trackEventWithName:eventName andValue:attributes];
    }
    else{
        [weAnalytics trackEventWithName:eventName];
    }
    result(nil);
}

- (void) trackScreen:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString * screenName = call.arguments[SCREEN_NAME];
    NSDictionary * screenData = call.arguments[SCREEN_DATA];
    id<WEGAnalytics> weAnalytics = [WebEngage sharedInstance].analytics;
    if (screenData && ![screenData isKindOfClass:[NSNull class]]) {
        [weAnalytics navigatingToScreenWithName:screenName andData:screenData];
    }
    else{
        [weAnalytics navigatingToScreenWithName:screenName];
    }
    result(nil);
}

- (void) setUserAttribute:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString* attributeName = call.arguments[ATTRIBUTE_NAME];
    id value = call.arguments[ATTRIBUTES];
    WEGUser * weUser = [WebEngage sharedInstance].user;
    if ([value isKindOfClass:[NSString class]]) {
        if ([value length] == 24) {
            NSDate * date = [self getDate:value];
            if (date != nil) {
                [weUser setAttribute:attributeName withDateValue:date];
            } else {
                [weUser setAttribute:attributeName withStringValue:value];
            }
        } else {
            [weUser setAttribute:attributeName withStringValue:value];
        }
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        [weUser setAttribute:attributeName withValue:value];
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        [weUser setAttribute:attributeName withArrayValue:value];
    }
    else if ([value isKindOfClass:[NSDate class]]) {
        [weUser setAttribute:attributeName withDateValue:value];
    }
    result(nil);
}

- (void) setUserAttributes:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSString* attributeName = call.arguments[ATTRIBUTE_NAME];
    id value = call.arguments[ATTRIBUTES];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [[WebEngage sharedInstance].user setAttribute:attributeName withDictionaryValue:value];
    }
    result(nil);
    
}

- (NSDate *)getDate:(NSString *)strValue {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate * date = [dateFormatter dateFromString:strValue];
    return date;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    if ([notification.request.content.userInfo[@"source"] isEqual:@"webengage"]) {
        NSLog(@"[WebEngagePlugin] willPresentNotification");
        NSMutableDictionary *customData = [[NSMutableDictionary alloc] init];
        for (NSDictionary* pair in notification.request.content.userInfo[@"customData"])
        {
            [customData setValue:pair[@"value"] forKey:pair[@"key"]];
        }
        NSDictionary *payload = @{
            TITLE: notification.request.content.title,
            MESSAGE: notification.request.content.body,
            STATE: NOTIFICATION_STATE_SHOWN,
            DATA: customData,
        };
        [_channel invokeMethod:METHOD_NAME_ON_PUSH arguments:payload];
    }
    
    UNNotificationPresentationOptions presentationOptions = UNNotificationPresentationOptionNone;
    NSDictionary *persistedOptions = [[NSUserDefaults standardUserDefaults]
                                      dictionaryForKey:kMessagingPresentationOptionsUserDefaults];
    if (persistedOptions != nil) {
        if ([persistedOptions[@"alert"] isEqual:@(YES)]) {
            presentationOptions |= UNNotificationPresentationOptionAlert;
        }
        if ([persistedOptions[@"badge"] isEqual:@(YES)]) {
            presentationOptions |= UNNotificationPresentationOptionBadge;
        }
        if ([persistedOptions[@"sound"] isEqual:@(YES)]) {
            presentationOptions |= UNNotificationPresentationOptionSound;
        }
    }
    completionHandler(presentationOptions);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    if ([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier] &&
        [response.notification.request.content.userInfo[@"source"] isEqual:@"webengage"]) {
        NSLog(@"[WebEngagePlugin] didReceiveNotificationResponse");
        NSMutableDictionary *customData = [[NSMutableDictionary alloc] init];
        for (NSDictionary* pair in response.notification.request.content.userInfo[@"customData"])
        {
            [customData setValue:pair[@"value"] forKey:pair[@"key"]];
        }
        NSDictionary *payload = @{
            TITLE: response.notification.request.content.title,
            MESSAGE: response.notification.request.content.body,
            STATE: NOTIFICATION_STATE_DISMISSED,
            DATA: customData,
        };
        [_channel invokeMethod:METHOD_NAME_ON_PUSH arguments:payload];
    }
    completionHandler();
}

- (void)WEGHandleDeeplink:(NSString *)deeplink userData:(NSDictionary *)data {
    NSLog(@"[WebEngagePlugin] WEGHandleDeeplink");
    NSMutableDictionary *customData = [[NSMutableDictionary alloc] init];
    for (NSDictionary* pair in data[@"customData"])
    {
        [customData setValue:pair[@"value"] forKey:pair[@"key"]];
    }
    NSDictionary *payload = @{
        TITLE: data[@"aps"][@"alert"][@"title"],
        MESSAGE: data[@"aps"][@"alert"][@"body"],
        STATE: NOTIFICATION_STATE_CLICKED,
        DATA: customData,
        LINK: deeplink,
    };
    [_channel invokeMethod:METHOD_NAME_ON_PUSH arguments:payload];
}

- (NSDictionary *)notificationPrepared:(NSDictionary<NSString *,id> *)inAppNotificationData shouldStop:(BOOL *)stopRendering {
    NSLog(@"[WebEngagePlugin] notificationPrepared");
    NSDictionary *payload = @{
        STATE:IN_APP_STATE_PREPARED,
        DATA:inAppNotificationData,
    };
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
    return inAppNotificationData;
}

- (void)notificationShown:(NSDictionary<NSString *,id> *)inAppNotificationData {
    NSLog(@"[WebEngagePlugin] notificationShown");
    NSDictionary *payload = @{
        STATE:IN_APP_STATE_SHOWN,
        DATA:inAppNotificationData,
    };
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

- (void)notificationDismissed:(NSDictionary<NSString *,id> *)inAppNotificationData {
    NSLog(@"[WebEngagePlugin] notificationDismissed");
    NSDictionary *payload = @{
        STATE:IN_APP_STATE_DISMISSED,
        DATA:inAppNotificationData,
    };
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

- (void)notification:(NSMutableDictionary<NSString *,id> *)inAppNotificationData clickedWithAction:(NSString *)actionId {
    NSLog(@"[WebEngagePlugin] notification clickedWithAction");
    NSMutableDictionary *payload = [[NSMutableDictionary alloc] init];
    [payload setValue:IN_APP_STATE_CLICKED forKey:STATE];
    [payload setValue:inAppNotificationData forKey:DATA];
    if (actionId != (id)[NSNull null] && actionId.length > 0 ) {
        for (NSDictionary* action in inAppNotificationData[@"actions"])
        {
            if ([actionId isEqualToString:action[@"actionEId"]]) {
                [payload setValue:action[@"actionLink"] forKey:LINK];
            }
        }
    }
    
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

- (void)trackDeeplinkURLCallback:(NSString *)redirectLocationURL {
    NSLog(@"[WebEngagePlugin] trackDeeplinkURLCallback");
    [_channel invokeMethod:METHOD_NAME_ON_DEEP_LINK arguments:redirectLocationURL];
}

@end
