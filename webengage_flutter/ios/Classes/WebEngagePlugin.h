#import <Flutter/Flutter.h>
#import <WebEngage/WebEngage.h>
#import <UserNotifications/UserNotifications.h>

@interface WebEngagePlugin : NSObject<FlutterPlugin,WEGAppDelegate,WEGInAppNotificationProtocol>
@end
