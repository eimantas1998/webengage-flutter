#import <WebEngage/WebEngage.h>

#import "WebEngagePlugin.h"
#import "WebEngageConstants.h"

NSString * const DATE_FORMAT = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
int const DATE_FORMAT_LENGTH = 24;

@implementation WebEngagePlugin {
    FlutterMethodChannel *_channel;
    NSObject<FlutterPluginRegistrar> *_registrar;
}

- (instancetype)initWithFlutterMethodChannel:(FlutterMethodChannel *)channel
                   andFlutterPluginRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _channel = channel;
        _registrar = registrar;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:WEBENGAGE_PLUGIN binaryMessenger:[registrar messenger]];
    id instance = [[WebEngagePlugin alloc] initWithFlutterMethodChannel:channel andFlutterPluginRegistrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[WebEngage sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions notificationDelegate:self];
    [WebEngage sharedInstance].pushNotificationDelegate = self;
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *_Nonnull))restorationHandler {
    [[[WebEngage sharedInstance] deeplinkManager] getAndTrackDeeplink:userActivity.webpageURL callbackBlock:^(id location){
        [self trackDeeplinkURLCallback:location];
    }];
    return YES;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([METHOD_NAME_SET_USER_LOGIN isEqualToString:call.method]) {
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
    
    BOOL status = call.arguments[OPTIN];
    
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
        if ([value length] == DATE_FORMAT_LENGTH) {
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
    [dateFormatter setDateFormat:DATE_FORMAT];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate * date = [dateFormatter dateFromString:strValue];
    return date;
}

-(void)WEGHandleDeeplink:(NSString *)deeplink userData:(NSDictionary *)data{
    NSDictionary *payload = @{LINK:deeplink,DATA:data};
    [_channel invokeMethod:METHOD_NAME_ON_PUSH arguments:payload];
}

-(NSDictionary *)notificationPrepared:(NSDictionary<NSString *,id> *)inAppNotificationData shouldStop:(BOOL *)stopRendering{
    NSDictionary *payload = @{STATE:IN_APP_STATE_PREPARED,DATA:inAppNotificationData};
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
    return inAppNotificationData;
}

-(void)notificationShown:(NSDictionary<NSString *,id> *)inAppNotificationData{
    NSDictionary *payload = @{STATE:IN_APP_STATE_SHOWN,DATA:inAppNotificationData};
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

-(void)notificationDismissed:(NSDictionary<NSString *,id> *)inAppNotificationData{
    NSDictionary *payload = @{STATE:IN_APP_STATE_DISSMISSED,DATA:inAppNotificationData};
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

-(void)notification:(NSMutableDictionary<NSString *,id> *)inAppNotificationData clickedWithAction:(NSString *)actionId{
    [inAppNotificationData setObject:actionId forKey:SELECTED_ACTION_ID];
    NSDictionary *payload = @{STATE:IN_APP_STATE_CLICKED,DATA:inAppNotificationData};
    [_channel invokeMethod:METHOD_NAME_ON_IN_APP arguments:payload];
}

- (void)trackDeeplinkURLCallback:(NSString *)redirectLocationURL {
    [_channel invokeMethod:METHOD_NAME_ON_DEEP_LINK arguments:redirectLocationURL];
}

@end
