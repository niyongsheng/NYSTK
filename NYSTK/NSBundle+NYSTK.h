//
//  NSBundle+NYSTK.h
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (NYSTK)

+ (UIImage *)nystk_imageForKey:(NSString *)key;
+ (UIImage *)nystk_imageForKey:(NSString *)key type:(NSString *)type;

+ (NSString *)nystk_localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
+ (NSString *)nystk_localizedStringForKey:(NSString *)key;

+ (instancetype)nystk_refreshBundle;
@end

NS_ASSUME_NONNULL_END
