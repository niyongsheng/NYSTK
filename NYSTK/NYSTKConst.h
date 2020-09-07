//
//  NYSTKConst.h
//  NYSTK
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#ifndef NYSTKConst_h
#define NYSTKConst_h

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#define NYSTK_ScreenWidth           [[UIScreen mainScreen] bounds].size.width
#define NYSTK_ScreenHeight          [[UIScreen mainScreen] bounds].size.height
#define NYSTK_RealValue(x)          (x*(NYSTK_ScreenWidth/375.0))

#define NYSTK_WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define NYSTK_SS(strongSelf) __strong __typeof(&*self)strongSelf = self;

#define NYSTK_Application           [UIApplication sharedApplication]
#define NYSTK_AppWindow             [UIApplication sharedApplication].delegate.window
#define NYSTK_RootViewController    [UIApplication sharedApplication].delegate.window.rootViewController

#define NYSTK_RandomColor           KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

#define FrameworkURL                @"https://github.com/niyongsheng/NYSTK"
#define NYSTKThemeColor             [UIColor colorWithRed:0.25 green:0.51 blue:0.93 alpha:1.00]

#ifdef DEBUG
#define NYSTK_Log(format, ...) printf("NYSTK_Log:\n^^Class Name:<Address:%p Controller:%s:(line:%d) > \n^^Method:%s \n^^Content:%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NYSTK_Log(...)
#endif

UIKIT_EXTERN const CGFloat NYSTKBackgroundAlpha;
UIKIT_EXTERN const CGFloat NYSTKBackgroundCornerRadius;
UIKIT_EXTERN const CGFloat NYSTKAutoDismissDuration;
UIKIT_EXTERN const CGFloat NYSTKEmitterAnimationDuration;

UIKIT_EXTERN NSString *const NYSTKInfoText;
UIKIT_EXTERN NSString *const NYSTKIKnowText;
UIKIT_EXTERN NSString *const NYSTKCancelText;
UIKIT_EXTERN NSString *const NYSTKCloseText;

#endif /* NYSTKConst_h */
