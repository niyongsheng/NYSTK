//
//  UIImage+NYSTK.m
//  NYSTK
//
//  Created by niyongsheng on 2021/8/16.
//

#import "UIImage+NYSTK.h"

@implementation UIImage (NYSTK)
- (UIImage *)nystk_imageByTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
