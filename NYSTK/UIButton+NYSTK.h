//
//  UIButton+NYSTK.h
//  NYSTK
//
//  Created by niyongsheng on 2021/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickActionBlock) (id obj);

@interface UIButton (NYSTK)

- (void)addTapBlock:(ClickActionBlock)clickBlock withEvent:(UIControlEvents)event;

@end

NS_ASSUME_NONNULL_END
