//
//  NYSTKConfig.h
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTKConfig : NSObject

@property (copy, nonatomic, nullable) NSString *langStr;

/// 弹框主题色
@property (strong, nonatomic, nullable) UIColor *tintColor;

/// 是否关闭毛玻璃背景效果
/// Default:  NO
@property (assign, nonatomic) BOOL isCloseBlurBg;

/// 是否关闭震动反馈
/// Default:  NO
@property (assign, nonatomic) BOOL isCloseFeedback;

/// 内容显示方式
/// Default: UIViewContentModeScaleToFill
@property(assign, nonatomic) UIViewContentMode bgImageViewContentMode;

/// 动画执行时间
/// 关闭动画设置成：CGFLOAT_MIN
/// Default:0.25f
@property (assign, nonatomic) CGFloat transformDuration;

/// 内容字体
/// content font.
/// Default:[UIFont systemFontOfSize:15]
@property (strong, nonatomic, nullable) UIFont *contentFont;

/// 内容文字颜色
/// content text color.
/// Default:[UIColor whiteColor]
@property (strong, nonatomic, nullable) UIColor *contentTextColor;

/// 内容圆角半径
/// content background corner radius.
/// Default:7.0f
@property (assign, nonatomic) CGFloat contentBgCornerRadius;

/// 自动消失默认延时时长
/// auto dismiss duration time.
/// Default:5.0f
@property (assign, nonatomic) float autoDismissDuration;

/// 弹框中心偏移量
/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetFromCenter;

/// 文字偏移量
/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForLabel;

/// 右上角关闭按钮偏移量
/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForCloseBtn;

/// 查看详情按钮偏移量
/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForInfoBtn;

/// 是否隐藏查看详情按钮
/// Default:  NO
@property (assign, nonatomic) BOOL isHiddenInfoBtn;

/// 是否隐藏右上角关闭按钮
/// Default:  NO
@property (assign, nonatomic) BOOL isHiddenCloseBtn;

/// 自定义右上角关闭按钮图片名
@property (copy, nonatomic, nullable) NSString *closeBtnImageName;

#pragma mark - 清除默认设置
- (void)clearDefaultValue;

/// Singleton Config instance
+ (instancetype)defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
