//
//  UIButton+NYSTK.m
//  NYSTK
//
//  Created by niyongsheng on 2021/8/17.
//

#import "UIButton+NYSTK.h"
#import <objc/runtime.h>

static id key;

@implementation UIButton (NYSTK)

- (void)addTapBlock:(ClickActionBlock)clickBlock withEvent:(UIControlEvents)event {

    objc_setAssociatedObject(self, &key, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

    [self addTarget:self action:@selector(goAction:) forControlEvents:event];
}

- (void)goAction:(UIButton *)sender {
    ClickActionBlock block = (ClickActionBlock)objc_getAssociatedObject(self, &key);

    if (block) {
        block(sender);
    }
}

@end
