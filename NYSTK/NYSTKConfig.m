//
//  NYSTKConfig.m
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NYSTKConfig.h"
#import "NYSTKConst.h"

@implementation NYSTKConfig

static NYSTKConfig *nystk_config = nil;

+ (instancetype)defaultConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nystk_config = [[self alloc] init];
    });
    return nystk_config;
}

#pragma mark - 清除默认设置
- (void)clearDefaultValue {
    self.tintColor = nil;
    self.contentFont = nil;
    self.contentTextColor = nil;
    self.closeBtnImageName = nil;
    
    self.contentBgCornerRadius = 0;
    self.backgroundAlphaComponent = 0;
    
    self.transformDuration = 0;
    self.autoDismissDuration = 0;
    
    self.offsetFromCenter = UIOffsetMake(0, 0);
    self.offsetForLabel = UIOffsetMake(0, 0);
    self.offsetForInfoBtn = UIOffsetMake(0, 0);
    self.offsetForCloseBtn = UIOffsetMake(0, 0);
    
    self.isHiddenInfoBtn = NO;
    self.isHiddenCloseBtn = NO;
    self.isCloseBlurBg = NO;
    self.isCloseFeedback = NO;
    
    self.bgImageViewContentMode = UIViewContentModeScaleToFill;
}

#pragma mark - getter

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = NYSTKThemeColor;
    }
    return _tintColor;
}

- (UIFont *)contentFont {
    if (!_contentFont) {
        _contentFont = [UIFont systemFontOfSize:15.0f];
    }
    return _contentFont;
}

- (UIColor *)contentTextColor {
    if (!_contentTextColor) {
        _contentTextColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    }
    return _contentTextColor;
}

- (NSString *)closeBtnImageName {
    if (_closeBtnImageName) {
        _closeBtnImageName = @"alert_close_icon";
    }
    return _closeBtnImageName;
}

- (CGFloat)contentBgCornerRadius {
    if (_contentBgCornerRadius == 0) {
        _contentBgCornerRadius = 7.0f;
    }
    return _contentBgCornerRadius;
}

- (CGFloat)backgroundAlphaComponent {
    if (_backgroundAlphaComponent == 0) {
        _backgroundAlphaComponent = 0.7f;
    }
    return _backgroundAlphaComponent;
}

- (float)autoDismissDuration {
    if (_autoDismissDuration == 0) {
        _autoDismissDuration = 5.0f;
    }
    return _autoDismissDuration;
}

- (CGFloat)transformDuration {
    if (_transformDuration == 0) {
        _transformDuration = 0.25f;
    }
    return _transformDuration;
}

@end
