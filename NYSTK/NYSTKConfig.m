//
//  NYSTKConfig.m
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NYSTKConfig.h"

@implementation NYSTKConfig

static NYSTKConfig *nystk_config = nil;

+ (instancetype)defaultConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nystk_config = [[self alloc] init];
    });
    return nystk_config;
}

@end
