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
    self.contentFont = nil;
    self.contentTextColor = nil;
    self.contentBgCornerRadius = 0;
    
    self.autoDismissDuration = 0;
    self.offsetFromCenter = UIOffsetMake(0, 0);
    self.offsetForLabel = UIOffsetMake(0, 0);
    self.offsetForInfoBtn = UIOffsetMake(0, 0);
    self.offsetForCloseBtn = UIOffsetMake(0, 0);
    
    self.isHiddenInfoBtn = NO;
    self.isHiddenCloseBtn = NO;
    
    self.tintColor = NYSTKThemeColor;
    self.closeBtnImageName = nil;
    
    self.bgImageViewContentMode = UIViewContentModeScaleToFill;
}

@end
