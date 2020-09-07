//
//  NYSTKImageView.h
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTKImageView : UIImageView <NSURLConnectionDelegate>
{
    NSURLConnection* connection;
    NSMutableData* data;
}

/// 异步加载网络图片
/// @param imageURL url
/// @param placeholder 占位图
- (void)setImageWithURL:(nullable NSURL *)imageURL placeholder:(nullable UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_END
