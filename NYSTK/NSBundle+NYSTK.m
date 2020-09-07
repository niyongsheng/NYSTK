//
//  NSBundle+NYSTK.m
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NSBundle+NYSTK.h"
#import "NYSTKConfig.h"
#import "NYSTKAlert.h"

@implementation NSBundle (NYSTK)

+ (UIImage *)nystk_imageForKey:(NSString *)key {
    return [UIImage imageNamed:key inBundle:[self nystk_refreshBundle] compatibleWithTraitCollection:nil];
}

+ (UIImage *)nystk_imageForKey:(NSString *)key type:(NSString *)type {
    static UIImage *image = nil;
    if (image == nil) {
        image = [[UIImage imageWithContentsOfFile:[[self nystk_refreshBundle] pathForResource:key ofType:type]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
}

+ (NSString *)nystk_localizedStringForKey:(NSString *)key value:(nullable NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = NYSTKConfig.defaultConfig.langStr;
        // 如果配置中没有配置语言
        if (!language) {
            language = [NSLocale preferredLanguages].firstObject;
        }
        
        if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }

        bundle = [NSBundle bundleWithPath:[[NSBundle nystk_refreshBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *str = [bundle localizedStringForKey:key value:value table:nil];
    return str;
}

+ (NSString *)nystk_localizedStringForKey:(NSString *)key {
    return [self nystk_localizedStringForKey:key value:@"nil"];
}

+ (instancetype)nystk_refreshBundle {
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[NYSTKAlert class]] pathForResource:@"NYSTK" ofType:@"bundle"]];
    }
    return refreshBundle;
}

@end
