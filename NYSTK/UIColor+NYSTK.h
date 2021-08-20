//
//  UIColor+NYSTK.h
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NYSTK)

+ (instancetype)nystk_colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
