//
//  LLUtils.h
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#if defined(__cplusplus)
extern "C" {
#endif
    /** this file is use to hold miscellaneous helper functions */
    
    /*************************************************************/
#pragma mark - System
    /*************************************************************/
    
    extern float SYSTEM_VERSION; ///< current system version
    extern NSString* APP_VERSION;
    
    static inline bool AT_LEAST_IOS(float version) { return SYSTEM_VERSION >= version; }
#define AT_LEAST_IOS7  (SYSTEM_VERSION >= 7.0)
#define AT_LEAST_IOS8  (SYSTEM_VERSION >= 8.0)
#define AT_LEAST_IOS9  (SYSTEM_VERSION >= 9.0)
#define AT_LEAST_IOS10 (SYSTEM_VERSION >= 10.0)
#define AT_LEAST_IOS11 (SYSTEM_VERSION >= 11.0)
#define AT_LEAST_IOS12 (SYSTEM_VERSION >= 12.0)
    
    static inline bool IS_IPAD() {
        return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    }
    
#define IS_MINIPAD      ([[LLUtils sharedInstance].machineModelName hasPrefix:@"iPad mini"])
#define IS_IPOD         ([[LLUtils sharedInstance].machineModel hasPrefix:@"iPod"])
#define IS_SIMULATOR    TARGET_OS_SIMULATOR
#define IS_IPHONEX      (812==SCREEN_HEIGHT)
    
    
    /*************************************************************/
#pragma mark - Interface & Screen
    /*************************************************************/
    
    extern CGFloat SCREEN_WIDTH; ///< SCREEN_WIDTH when portrait
    extern CGFloat SCREEN_HEIGHT; ///< SCREEN_HEIGHT when portrait
    
    static inline CGFloat screenWidthForOrentation(UIInterfaceOrientation orientation) {
        return UIInterfaceOrientationIsLandscape(orientation)? SCREEN_HEIGHT : SCREEN_WIDTH;
    }
    
    static inline CGFloat screenHeightForOrentation(UIInterfaceOrientation orientation) {
        return UIInterfaceOrientationIsLandscape(orientation)? SCREEN_WIDTH : SCREEN_HEIGHT;
    }
    
    /** NOTE: when window bounds change, statusBarOrientation may still not change.
     * if adjust layout by bounds change, may not depend on orientation */
#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
#define IS_PORTRAIT (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    
#define INTERFACE_WIDTH  screenWidthForOrentation([UIApplication sharedApplication].statusBarOrientation)
#define INTERFACE_HEIGHT screenHeightForOrentation([UIApplication sharedApplication].statusBarOrientation)
    
#define APP_WINDOW ([UIApplication sharedApplication].delegate.window)
    
    
    /*************************************************************/
#pragma mark - Helper Function
    /*************************************************************/
    
#define UNUSED(var) (void)(var)
    
#define SGR_SINGLETION(...)                                         \
+ (instancetype)sharedInstance NS_SWIFT_NAME(shared());
    
#define SGR_DEF_SINGLETION(...)                                     \
+ (instancetype)sharedInstance                                      \
{                                                                   \
static dispatch_once_t once;                                        \
static id __singletion;                                             \
dispatch_once(&once,^{__singletion = [[self alloc] init];});        \
return __singletion;                                                \
}
    
    /** Example
     *
     * WEAKIFY(self);
     * [self do:^{
     *      STRONGIFY(self);
     *      if (!self) return;
     * }];
     */
#define WEAK_VAR(_obj_) weak##_##_obj_
#if __has_feature(objc_arc)
#define WEAKIFY(_obj_) __weak __typeof__(_obj_) weak##_##_obj_ = _obj_;
#else
#define WEAKIFY(_obj_) __block __typeof__(_obj_) weak##_##_obj_ = _obj_;
#endif
#define STRONGIFY(_obj_) __strong __typeof__(weak##_##_obj_) _obj_ = weak##_##_obj_;
#define STRONGIFY_OR_RET(_obj_) STRONGIFY(_obj_); if (!_obj_) return;
    
#define IS_CLASS(obj, cls) [obj isKindOfClass:[cls class]]
    static inline id _Nullable __DYNAMIC_CAST(id _Nullable obj, Class cls) NS_SWIFT_UNAVAILABLE("") {
        return [obj isKindOfClass:cls]?obj:nil;
    }
    
    /** return obj if it's the desired class, or return nil */
#define DYNAMIC_CAST(obj, cls) ((cls*)__DYNAMIC_CAST(obj, [cls class]))
    
    /** auto cleanup function when exit scope, like RAII in c++ */
    static inline void __invoke_block(__unsafe_unretained dispatch_block_t _Nonnull * _Nonnull block) NS_SWIFT_UNAVAILABLE("") { (*block)(); }
    /** Defer syntax, usage: Defer = ^{ defer block when exit scope } */
#define Defer __unsafe_unretained dispatch_block_t OS_CONCAT(__defer, __COUNTER__) __attribute__((cleanup(__invoke_block), unused))
    
    static inline void __unlock_semaphore(dispatch_semaphore_t _Nonnull * _Nonnull semaphore) NS_SWIFT_UNAVAILABLE("") { (void)dispatch_semaphore_signal(*semaphore); }
#define dispatch_scope_lock(semaphore) \
dispatch_semaphore_t OS_CONCAT(__semaphore, __LINE__) __attribute__((cleanup(__unlock_semaphore))) = semaphore; \
(void)dispatch_semaphore_wait( OS_CONCAT(__semaphore, __LINE__), DISPATCH_TIME_FOREVER)
    
#define NotificationCenter [NSNotificationCenter defaultCenter]
#define REG_NOTIFY(keyname, callback)                           \
[NotificationCenter                                         \
addObserver: self                                           \
selector: @selector(callback)                            \
name: keyname                                        \
object: nil ]
    
#define REG_NOTIFY_WITH_OBJ(keyname, callback, obj)             \
[NotificationCenter                                         \
addObserver: self                                           \
selector: @selector(callback)                            \
name: keyname                                        \
object: obj ]
    
    /** Submits a block for execution on a main queue and waits until the block completes. */
    static inline void dispatch_sync_on_main_queue(__unsafe_unretained dispatch_block_t NS_NOESCAPE block) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    }
    
    /** check and ensure block execute on main thread. may delay it. */
    static inline void dispatch_on_main_queue(__unsafe_unretained dispatch_block_t block) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), block);
        }
    }
    
    static inline void dispatch_on_global_queue(dispatch_block_t block) {
        dispatch_async(dispatch_get_global_queue(0, 0), block);
    }
    
    /** exe block after delay seconds */
    static inline void dispatch_delay(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, block);
    }
    
    /** exe block after delay seconds */
    static inline void dispatch_delay_on_main_queue(NSTimeInterval delay, dispatch_block_t block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    }
    
    /** exe block after delay seconds */
    static inline void dispatch_delay_on_global_queue(NSTimeInterval delay, dispatch_block_t block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), block);
    }
    
    
    static inline NSString* SAFE_STRING(id _Nullable str) {
        return [str isKindOfClass:[NSString class]]?str:@"";
    }
    
    static inline bool IS_NONNULL_STRING(id _Nullable str) {
        return [str isKindOfClass:[NSString class]] && [str length] > 0;
    }
    static inline bool IS_NULL_STRING(id _Nullable str) { return (!IS_NONNULL_STRING(str)); }
    
    
    /*************************************************************/
#pragma mark - singleton helper class
    /*************************************************************/
    
    typedef NS_ENUM(NSInteger, NETWORK_TYPE) {
        NETWORK_TYPE_NONE NS_SWIFT_NAME(none) = 0,
        NETWORK_TYPE_WIFI NS_SWIFT_NAME(wifi) = 1,
        NETWORK_TYPE_3G                       = 2,
        NETWORK_TYPE_2G                       = 3,
        NETWORK_TYPE_4G                       = 5,
    };
    
    static inline CGFloat LLFloat(CGFloat ip6) { return (ip6 * (SCREEN_WIDTH / 375.0)); }
    static inline UIColor* RGBINT(uint32_t num) {
        return [UIColor colorWithRed: (float)((num>>16)&0xff) / 0xff
                               green: (float)((num>>8)&0xff)  / 0xff
                                blue: (float)((num)&0xff)     / 0xff
                               alpha: 1.0];
    }
    #define RGBHEX( num )       RGBINT( 0x##num )
    
#define LLUTIL [LLUtils sharedInstance]
    @interface LLUtils : NSObject

SGR_SINGLETION()
/** use this instead of +Load. because order is import. and some api may not work.
 ipad run iphone may also set screen after load */
+ (void)initialLoad;

#pragma mark SystemInfo

/** The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
 *  @see http://theiphonewiki.com/wiki/Models */
@property (nonatomic, readonly) NSString *machineModel;
/** The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
 *  @see http://theiphonewiki.com/wiki/Models */
@property (nonatomic, readonly) NSString *machineModelName;

/** the AppName, aka `CFBundleDisplayName` */
@property (nonatomic, readonly) NSString* appName;
/** the App Identifier, aka `CFBundleIdentifier` */
@property (nonatomic, readonly) NSString* appIdentifier;
/** the App short version, aka `CFBundleShortVersionString` */
@property (nonatomic, readonly) NSString* appVersion;
/** the build version, aka `CFBundleVersion` */
@property (nonatomic, readonly) NSString* appBuildVersion;
/** userAgent according to: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43 */
@property (nonatomic, readonly) NSString* userAgent;

/** always return portrait orientation bounds */
@property (nonatomic, readonly) CGRect screenBounds;
/** like screenBounds, but consider orientation */
@property (nonatomic, readonly) CGRect interfaceBounds;
/** like screenBounds, but consider pass in orientation */
- (CGRect)interfaceBoundsForOrientation:(UIInterfaceOrientation)orientation;

/** network type showing in status bar, invalid when not showing */
@property (nonatomic, readonly) NETWORK_TYPE networkTypeFromStatusBar;

/// Whether the device is jailbroken.
@property (nonatomic, readonly) BOOL isJailbroken;


@end
    
#if defined(__cplusplus)
}
#endif

NS_ASSUME_NONNULL_END
