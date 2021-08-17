//
//  UIView+NYSTK.h
//  NYSTK
//
//  Created by niyongsheng on 2021/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NYSTK)
@property (nonatomic, assign) void(^block)(NSInteger tag);

- (void)addTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void(^)(NSInteger tag))block;

@end

NS_ASSUME_NONNULL_END
