//
//  NYSTKConfig.h
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTKConfig : NSObject

@property (copy, nonatomic, nullable) NSString *langStr;

/// Singleton Config instance
+ (instancetype)defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
