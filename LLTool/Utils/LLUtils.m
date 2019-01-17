//
//  LLUtils.m
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLUtils.h"
#import <sys/sysctl.h>
#import <objc/runtime.h>

CGFloat SCREEN_WIDTH;
CGFloat SCREEN_HEIGHT;
float SYSTEM_VERSION;
NSString* APP_VERSION;

@implementation LLUtils {
    NETWORK_TYPE _previousNetworkStatusFromBar;
}

#define TYPENCODING_FOR_INSTANCE(clsname, selName) \
method_getTypeEncoding( class_getInstanceMethod([clsname class], @selector(selName)) )
#define TYPENCODING_FOR_Class(clsname, selName) \
method_getTypeEncoding( class_getClassMethod([clsname class], @selector(selName)) )

+ (void)load {
    SYSTEM_VERSION = [UIDevice currentDevice].systemVersion.floatValue;
    APP_VERSION = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (void)initialLoad {
    // iPad等可能会改变这个值, 所以不能在load加载, 需要启动后显示调用
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (screenSize.width > screenSize.height) {
        SCREEN_WIDTH = screenSize.height;
        SCREEN_HEIGHT = screenSize.width;
    } else {
        SCREEN_WIDTH = screenSize.width;
        SCREEN_HEIGHT = screenSize.height;
    }
}

SGR_DEF_SINGLETION()

- (CGRect)screenBounds {
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (bounds.size.width > bounds.size.height) {
        // portrait, height > width
        return (CGRect){bounds.origin, {bounds.size.height, bounds.size.width}};
    } else {
        return bounds;
    }
}

- (CGRect)interfaceBounds {
    return [self interfaceBoundsForOrientation:
            [UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)interfaceBoundsForOrientation:(UIInterfaceOrientation)orientation {
    CGRect bounds = [UIScreen mainScreen].bounds;
    if ((UIInterfaceOrientationIsLandscape(orientation) &&
         bounds.size.width < bounds.size.height) ||
        (UIInterfaceOrientationIsPortrait(orientation) &&
         bounds.size.height < bounds.size.width))
    {   // landscape width should larger than height
        // portrait height should larger than width
        // so exchange it.
        return (CGRect){bounds.origin, {bounds.size.height, bounds.size.width}};
    } else {
        // if landscape and width > height: Right
        // if portrait and height > width: Right
        return bounds;
    }
}

static NETWORK_TYPE networkTypeFromStatusBar() {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = nil;
    @try {
        subviews = [[app valueForKeyPath:@"statusBar.foregroundView"] subviews];
    } @catch (NSException *exception) {
        NSLog(@"==%@",exception);
        return NETWORK_TYPE_NONE;
    }
    
    
    
    Class predicateClass = NSClassFromString(@"UIStatusBarDataNetworkItemView");
    
    UIView *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:predicateClass]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num) {
        switch( [num intValue] ){
            case 0: {
                return NETWORK_TYPE_NONE;
            }
            case 1: {
                return NETWORK_TYPE_2G;
            }
            case 2: case 4: {
                return NETWORK_TYPE_3G;
            }
            case 3: {
                return NETWORK_TYPE_4G;
            }
            default: { return NETWORK_TYPE_WIFI; }
        }
    }
    return NETWORK_TYPE_NONE;
}

- (NETWORK_TYPE)networkTypeFromStatusBar {
    // FIX: call subview on background thread may crash
    @weakify(self);
    if (![NSThread isMainThread]) {
        @strongify(self);
        // 该方法调用频道高, 同步等待耗时太长了.
        // 而这状态基本不怎么变, 所以返回缓存, 延迟更新.
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_previousNetworkStatusFromBar = networkTypeFromStatusBar();
        });
    } else {
        _previousNetworkStatusFromBar = networkTypeFromStatusBar();
    }
    return _previousNetworkStatusFromBar;
}

- (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = alloca(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
    });
    return model;
}

- (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        
        NSDictionary *dic = @{
#if TARGET_OS_WATCH
                              @"Watch1,1" : @"Apple Watch (A1553)",
                              @"Watch1,2" : @"Apple Watch (A1554|A1638)",
#endif
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2G",
                              @"iPod3,1" : @"iPod touch 3G",
                              @"iPod4,1" : @"iPod touch 4G",
                              @"iPod5,1" : @"iPod touch 5G",
                              @"iPod7,1" : @"iPod touch 6G",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (A1332)",
                              @"iPhone3,2" : @"iPhone 4 (A1332 8GB)",
                              @"iPhone3,3" : @"iPhone 4 (A1349)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5 (A1428)",
                              @"iPhone5,2" : @"iPhone 5 (A1429|A1442)",
                              @"iPhone5,3" : @"iPhone 5c (A1456|A1532)",
                              @"iPhone5,4" : @"iPhone 5c (A1507|A1516|A1526|A1529)",
                              @"iPhone6,1" : @"iPhone 5s (A1453|A1533)",
                              @"iPhone6,2" : @"iPhone 5s (A1457|A1518|A1528|A1530)",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              @"iPhone10,1" : @"iPhone 8",
                              @"iPhone10,2" : @"iPhone 8 Plus",
                              @"iPhone10,3" : @"iPhone X",
                              @"iPhone10,4" : @"iPhone 8",
                              @"iPhone10,5" : @"iPhone 8 Plus",
                              @"iPhone10,6" : @"iPhone X",
                              
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (A1395)",
                              @"iPad2,2" : @"iPad 2 (A1396)",
                              @"iPad2,3" : @"iPad 2 (A1397)",
                              @"iPad2,4" : @"iPad 2 (A1395 NewChip)",
                              @"iPad2,5" : @"iPad mini 1 (A1432)",
                              @"iPad2,6" : @"iPad mini 1 (A1454)",
                              @"iPad2,7" : @"iPad mini 1 (A1455)",
                              @"iPad3,1" : @"iPad 3 (A1416)",
                              @"iPad3,2" : @"iPad 3 (A1403)",
                              @"iPad3,3" : @"iPad 3 (A1430)",
                              @"iPad3,4" : @"iPad 4 (A1458)",
                              @"iPad3,5" : @"iPad 4 (A1459)",
                              @"iPad3,6" : @"iPad 4 (A1460)",
                              @"iPad4,1" : @"iPad Air (A1474)",
                              @"iPad4,2" : @"iPad Air (A1475)",
                              @"iPad4,3" : @"iPad Air (A1476)",
                              @"iPad4,4" : @"iPad mini 2 (A1489)",
                              @"iPad4,5" : @"iPad mini 2 (A1490)",
                              @"iPad4,6" : @"iPad mini 2 (A1491)",
                              @"iPad4,7" : @"iPad mini 3 (A1599)",
                              @"iPad4,8" : @"iPad mini 3 (A1600)",
                              @"iPad4,9" : @"iPad mini 3 (A1601)",
                              @"iPad5,1" : @"iPad mini 4 (A1538)",
                              @"iPad5,2" : @"iPad mini 4 (A1550)",
                              @"iPad5,3" : @"iPad Air 2 (A1566)",
                              @"iPad5,4" : @"iPad Air 2 (A1567)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch A1584)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch A1652)",
                              @"iPad6,3" : @"iPad Pro (9.7 inch A1673)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch A1674|A1675)",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              
#if TARGET_OS_TV
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
#endif
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

- (NSString *)appName { return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]; }
- (NSString *)appIdentifier { return [[NSBundle mainBundle] bundleIdentifier]; }
- (NSString *)appVersion { return APP_VERSION; }
- (NSString *)appBuildVersion { return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"]; }
- (NSString *)userAgent {
#if TARGET_OS_IOS
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
#elif TARGET_OS_WATCH
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    return [NSString stringWithFormat:@"%@/%@ (%@; watchOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[WKInterfaceDevice currentDevice] model], [[WKInterfaceDevice currentDevice] systemVersion], [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    return [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
}

- (BOOL)isJailbroken {
    static bool isJailbroken;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        isJailbroken = ^bool{
            
            if ( IS_SIMULATOR ) return NO; // Dont't check simulator
            
            // iOS9 URL Scheme query changed ...
            // NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package"];
            // if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
            
            NSArray *paths = @[@"/Applications/Cydia.app",
                               @"/private/var/lib/apt/",
                               @"/private/var/lib/cydia",
                               @"/private/var/stash"];
            for (NSString *path in paths) {
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
            }
            
            FILE *bash = fopen("/bin/bash", "r");
            if (bash != NULL) {
                fclose(bash);
                return YES;
            }
            
            return NO;
        }();
    });
    return isJailbroken;
}

@end

