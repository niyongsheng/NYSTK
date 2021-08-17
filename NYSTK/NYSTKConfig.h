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

/// content font.
/// Default:[UIFont systemFontOfSize:15]
@property (strong, nonatomic, nullable) UIFont *contentFont;
/// content text color.
/// Default:[UIColor whiteColor]
@property (strong, nonatomic, nullable) UIColor *contentTextColor;
/// content background corner radius.
/// Default:7.0f
@property (assign, nonatomic) CGFloat contentBgCornerRadius;

/// auto dismiss duration time.
/// Default:1.0f
@property (assign, nonatomic) float autoDismissDuration;

/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetFromCenter;

/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForLabel;

/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForCloseBtn;

/// negative for left or up
/// Default:  0, 0
@property (assign, nonatomic) UIOffset offsetForInfoBtn;

/// Default:  NO
@property (assign, nonatomic) BOOL isHiddenInfoBtn;

/// Default:  NO
@property (assign, nonatomic) BOOL isHiddenCloseBtn;

@property(assign, nonatomic) UIViewContentMode bgImageViewContentMode;

/// 弹框主题色
@property (strong, nonatomic, nullable) UIColor *tintColor;

@property (copy, nonatomic, nullable) NSString *closeBtnImageName;

#pragma mark - 清除默认设置
- (void)clearDefaultValue;

/// Singleton Config instance
+ (instancetype)defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
