//
//  NYSTKEmitterUtil.h
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NYSTKEmitterAnimationType) {
    NYSTKEmitterAnimationTypeNone,
    /** 彩带*/
    NYSTKEmitterAnimationTypeColourbar,
    /** 雪花*/
    NYSTKEmitterAnimationTypeSnow,
    /** 雨水*/
    NYSTKEmitterAnimationTypeRain,
    /** 烟花*/
    NYSTKEmitterAnimationTypeFireworks
};

@interface NYSTKEmitterUtil : NSObject
/// 开启粒子效果
/// @param type 类型
/// @param view 作用域
/// @param times 持续时间
+ (void)showEmitterType:(NYSTKEmitterAnimationType)type onView:(UIView *)view durationTime:(float)times;
@end

NS_ASSUME_NONNULL_END
