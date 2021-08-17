//
//  UIView+NYSTK.m
//  NYSTK
//
//  Created by niyongsheng on 2021/8/17.
//

#import "UIView+NYSTK.h"
#import <objc/runtime.h>

@implementation UIView (NYSTK)

- (void)addTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void (^)(NSInteger))block {
    
    self.block = block;
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClick)];
    
    [self addGestureRecognizer:tag];
    
    if (tapGestureDelegate) {
        
        tag.delegate = tapGestureDelegate;
        
    }
    
    self.userInteractionEnabled = YES;
    
}

- (void)tagClick {
    
    if (self.block) {
        
        self.block(self.tag);
        
    }
    
}

- (void)setBlock:(void (^)(NSInteger tag))block {
    
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void(^)(NSInteger tag))block {
    
    return objc_getAssociatedObject(self, @selector(block));
    
}

@end
