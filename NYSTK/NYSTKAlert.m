//
//  NYSAlert.m
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NYSTKAlert.h"

#import "NYSTKConst.h"
#import "NYSTKConfig.h"

#import "UIColor+NYSTK.h"
#import "NSBundle+NYSTK.h"
#import "UIView+NYSTK.h"
#import "UIButton+NYSTK.h"
#import "UIImage+NYSTK.h"
#import "NYSTKImageView.h"

@interface NYSTKAlert ()
/// 记录根视图
@property (nonatomic) UIView *backgroundView;
@end

@implementation NYSTKAlert

+ (NYSTKAlert*)sharedView {
    static dispatch_once_t once;
    
    static NYSTKAlert *sharedView;
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds]; });
    
    return sharedView;
}

/// 关闭弹框
/// @param delay 延时
/// @param completion 完成回调
- (void)dismissWithDelay:(NSTimeInterval)delay completion:(NYSTKAlertDismissCompletion)completion {
    __weak NYSTKAlert *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong NYSTKAlert *strongSelf = weakSelf;
        if (strongSelf) {
            
            __block void (^completionBlock)(void) = ^{

                if (self.backgroundView.alpha == 0.0f) {
                    [strongSelf.backgroundView removeFromSuperview];
                    [strongSelf removeFromSuperview];
                    
                    if (completion) {
                        completion();
                    }
                }
            };
            
            [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
                strongSelf.backgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                [strongSelf.backgroundView removeFromSuperview];
                if (completion) {
                    completion();
                }
            }];
        }
    }];
}

- (void)dealloc {
    if (_backgroundView) {
        self.backgroundView = nil;
    }
}

#pragma mark - 配置默认设置
+ (void)setDefaultValue {
    [NYSTKConfig defaultConfig].contentFont = [NYSTKConfig defaultConfig].contentFont ? [NYSTKConfig defaultConfig].contentFont : [UIFont systemFontOfSize:15];
    [NYSTKConfig defaultConfig].contentTextColor = [NYSTKConfig defaultConfig].contentTextColor ? [NYSTKConfig defaultConfig].contentTextColor : [UIColor whiteColor];
    [NYSTKConfig defaultConfig].contentBgCornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius == 0 ? 7.0f : [NYSTKConfig defaultConfig].contentBgCornerRadius;
    
    [NYSTKConfig defaultConfig].autoDismissDuration = [NYSTKConfig defaultConfig].autoDismissDuration == 0 ? 5.0f : [NYSTKConfig defaultConfig].autoDismissDuration;
    
    [NYSTKConfig defaultConfig].tintColor = [NYSTKConfig defaultConfig].tintColor ? [NYSTKConfig defaultConfig].tintColor : NYSTKThemeColor;
    [NYSTKConfig defaultConfig].closeBtnImageName = [NYSTKConfig defaultConfig].closeBtnImageName ? [NYSTKConfig defaultConfig].closeBtnImageName : @"sign_out";
    
    [NYSTKConfig defaultConfig].transformDuration = [NYSTKConfig defaultConfig].transformDuration == 0 ? 0.25f : [NYSTKConfig defaultConfig].transformDuration;
}

#pragma mark - Toast弹框

/// Toast弹框
/// @param message 内容信息
+ (void)showToastWithMessage:(NSString * _Nonnull)message {
    if (@available(iOS 13.0, *)) {
        [self showToastWithMessage:message themeModel:NYSTKThemeModelAuto];
    } else {
        [self showToastWithMessage:message themeModel:NYSTKThemeModelDark];
    }
}

/// Toast弹框
/// @param message 内容信息
/// @param theme 主题
+ (void)showToastWithMessage:(NSString * _Nonnull)message themeModel:(NYSTKThemeModel)theme {
    [self showToastWithMessage:message
                         image:nil
                          view:NYSTK_AppWindow
                    themeModel:theme];
}

/// Toast弹框
/// @param message 内容信息
/// @param imageName 自定义图片名
/// @param theme 主题
+ (void)showToastWithMessage:(NSString * _Nonnull)message image:(NSString * _Nonnull)imageName themeModel:(NYSTKThemeModel)theme {
    [self showToastWithMessage:message
                         image:imageName
                          view:NYSTK_AppWindow
                    themeModel:theme];
}

/// Toast弹框
/// @param message 内容信息
/// @param imageName 自定义图片名
/// @param view 作用域
/// @param theme 主题
+ (void)showToastWithMessage:(NSString * _Nonnull)message
                       image:(NSString *)imageName
                        view:(UIView * _Nonnull)view
                  themeModel:(NYSTKThemeModel)theme {
    [self setDefaultValue];
    
    if (@available(iOS 13.0, *) && theme == NYSTKThemeModelAuto) {
        if ([UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle == UIUserInterfaceStyleDark) {
            theme = NYSTKThemeModelDark;
        } else {
            theme = NYSTKThemeModelLight;
        }
    }
    
    // bg view
    UIView *bgView = [[UIView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgView;
    bgView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor lightGrayColor] colorWithAlphaComponent:NYSTKBackgroundAlpha] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    [view addSubview:bgView];
    bgView.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius;
    bgView.clipsToBounds = YES;
    
    // image
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgView addSubview:label];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [NYSTKConfig defaultConfig].contentFont;
    label.textColor = [NYSTKConfig defaultConfig].contentTextColor;
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.superview.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
        make.centerY.mas_equalTo(bgView.superview.mas_centerY).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
        make.width.mas_lessThanOrEqualTo(NYSTK_ScreenWidth*0.75);
        
        make.bottom.mas_equalTo(label.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(label).mas_offset(-10);
        make.right.mas_equalTo(label).mas_offset(10);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.superview.mas_centerX);
        make.top.mas_equalTo(imageView.superview.mas_top).mas_offset(imageName ? 10 : 0);
        make.size.mas_equalTo(imageName ? CGSizeMake(image.size.width, image.size.height) : CGSizeZero);
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label.superview.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(10);
    }];
    
    // 动画效果
    bgView.alpha = 0;
    bgView.transform = CGAffineTransformScale(bgView.transform, 0.1, 0.1);
    [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.alpha = 1.0;
        bgView.transform = CGAffineTransformIdentity;
    } completion:nil];

    // 自动移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([NYSTKConfig defaultConfig].autoDismissDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration animations:^{
            bgView.transform = CGAffineTransformScale(bgView.transform, 0.1, 0.1);
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}


#pragma mark - 图片弹框条

/// 图片弹框条
/// @param message 内容信息
+ (void)showImageBarWithMessage:(NSString *)message {
    [self showImageBarWithMessage:message
                attributedMessage:nil
                            image:nil
                             type:NYSTKColorfulToastTypeYellowCat
                        direction:NYSTKComeInDirectionDefault
                           onView:NYSTK_AppWindow
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:nil
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param attributedMessage 富文本信息
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage {
    [self showImageBarWithMessage:nil
                attributedMessage:attributedMessage
                            image:nil
                             type:NYSTKColorfulToastTypeYellowCat
                        direction:NYSTKComeInDirectionDefault
                           onView:NYSTK_AppWindow
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:nil
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param message 内容信息
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithMessage:(NSString *)message
                         onView:(UIView *)view
         infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageBarWithMessage:message
                attributedMessage:nil
                            image:nil
                             type:NYSTKColorfulToastTypeYellowCat
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param attributedMessage 富文本信息
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage
                                   onView:(UIView *)view
                   infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageBarWithMessage:nil
                attributedMessage:attributedMessage
                            image:nil
                             type:NYSTKColorfulToastTypeYellowCat
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param message 内容信息
/// @param type 弹框类型
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithMessage:(NSString *)message
                          image:(NSString *)imageName
                         onView:(UIView *)view
         infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageBarWithMessage:message
                attributedMessage:nil
                            image:imageName
                             type:NYSTKColorfulToastTypeCustom
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param attributedMessage 富文本信息
/// @param imageName 自定义图片名
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage
                                    image:(NSString *)imageName
                                   onView:(UIView *)view
                   infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageBarWithMessage:nil
                attributedMessage:attributedMessage
                            image:imageName
                             type:NYSTKColorfulToastTypeCustom
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:nil];
}

/// 图片弹框条
/// @param message 内容信息
/// @param type 弹框类型
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
/// @param closeButtonClickedBlock 关闭事件回调
+ (void)showImageBarWithMessage:(NSString *)message
                           type:(NYSTKColorfulToastType)type
                         onView:(UIView *)view
         infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
        closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    [self showImageBarWithMessage:message
                attributedMessage:nil
                            image:nil
                             type:type
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                      emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:closeButtonClickedBlock];
}

/// 图片弹框条
/// @param attributedMessage 富文本信息
/// @param type 弹框类型
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
/// @param closeButtonClickedBlock 关闭事件回调
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage
                                     type:(NYSTKColorfulToastType)type
                                   onView:(UIView *)view
                   infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
                  closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    [self showImageBarWithMessage:nil
                attributedMessage:attributedMessage
                            image:nil
                             type:type
                        direction:NYSTKComeInDirectionDefault
                           onView:view
                       emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:NYSTKThemeModelAuto
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:closeButtonClickedBlock];
    
}

/// 图片弹框条
/// @param message 内容信息
/// @param type 弹框类型
/// @param direction 进入方向
/// @param view 作用域
/// @param theme 主题
/// @param infoButtonClickedBlock 点击事件回调
/// @param closeButtonClickedBlock 关闭事件回调
+ (void)showImageBarWithMessage:(NSString *)message
                           type:(NYSTKColorfulToastType)type
                      direction:(NYSTKComeInDirection)direction
                         onView:(UIView *)view
                     themeModel:(NYSTKThemeModel)theme
         infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
        closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    [self showImageBarWithMessage:message
                attributedMessage:nil
                            image:nil
                             type:type
                        direction:direction
                           onView:view
                       emitterType:NYSTKEmitterAnimationTypeNone
                       themeModel:theme
           infoButtonClickedBlock:infoButtonClickedBlock
          closeButtonClickedBlock:closeButtonClickedBlock];
}

/// 图片弹框条
/// @param message 内容信息
/// @param attributedMessage 富文本信息
/// @param imageName 自定义图片名
/// @param type 弹框类型
/// @param direction 进入方向
/// @param view 作用域
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 点击事件回调
/// @param closeButtonClickedBlock 关闭事件回调
+ (void)showImageBarWithMessage:(NSString *)message
              attributedMessage:(NSAttributedString *)attributedMessage
                          image:(NSString *)imageName
                           type:(NYSTKColorfulToastType)type
                      direction:(NYSTKComeInDirection)direction
                         onView:(UIView *)view
                    emitterType:(NYSTKEmitterAnimationType)emitter
                     themeModel:(NYSTKThemeModel)theme
         infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
        closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    [self setDefaultValue];
    
    // bg view
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgImageView;
    bgImageView.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius;
    bgImageView.layer.masksToBounds = YES;
    switch (type) {
        case NYSTKColorfulToastTypeGreenBook:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_0_375x80_"];
            break;
            
        case NYSTKColorfulToastTypePurpleFlower:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_1_375x80_"];
            break;
            
        case NYSTKColorfulToastTypeBlueHand:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_2_375x80_"];
            break;
            
        case NYSTKColorfulToastTypeBlueFlower:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_3_375x80_"];
            break;
            
        case NYSTKColorfulToastTypeYellowCat:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_4_375x80_"];
            break;
            
        case NYSTKColorfulToastTypeGreenStar:
            bgImageView.image = [NSBundle nystk_imageForKey:@"group_banner_5_375x80_"];
            break;
            
        case NYSTKColorfulToastTypeCustom: {
            NSAssert(imageName, @"请检查imageName是否为nil");
            bgImageView.image = [UIImage imageNamed:imageName];
        }
            break;
            
        default:
            break;
    }
    bgImageView.userInteractionEnabled = YES;
    [view addTapGestureRecognizerWithDelegate:nil Block:^(NSInteger tag) {
        infoButtonClickedBlock ? infoButtonClickedBlock() : nil;
    }];
    [view addSubview:bgImageView];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    if (message) {
        label.text = message;
    }
    if (attributedMessage) {
        label.attributedText = attributedMessage;
    }
    [bgImageView addSubview:label];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [NYSTKConfig defaultConfig].contentFont;
    label.textColor = [NYSTKConfig defaultConfig].contentTextColor;
    
    // 关闭按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.hidden = [NYSTKConfig defaultConfig].isHiddenCloseBtn;
    [cancelButton setBackgroundImage:[NSBundle nystk_imageForKey:[NYSTKConfig defaultConfig].closeBtnImageName] forState:UIControlStateNormal];
    [cancelButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgImageView removeFromSuperview];
        }];
        closeButtonClickedBlock ? closeButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [bgImageView addSubview:cancelButton];

    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-NYSTKNormalSpace);
        make.centerY.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    // 设置背景view的约束
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(NYSTK_ScreenWidth * 0.75);
        make.height.mas_lessThanOrEqualTo(NYSTK_RealValue(70));
        
        switch (direction) {
            case NYSTKComeInDirectionDefault: {
                make.size.mas_equalTo(CGSizeZero);
                make.centerX.mas_equalTo(bgImageView.superview.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
                make.centerY.mas_equalTo(bgImageView.superview.mas_centerY).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
            }
                break;
                
            case NYSTKComeInDirectionUp: {
                make.centerX.mas_equalTo(bgImageView.superview.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
                make.top.mas_equalTo(bgImageView.superview.mas_top).mas_offset(-NYSTK_RealValue(70));
            }
                break;
                
            case NYSTKComeInDirectionDown: {
                make.centerX.mas_equalTo(bgImageView.superview.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
                make.bottom.mas_equalTo(bgImageView.superview.mas_bottom).mas_offset(NYSTK_RealValue(70));
            }
                break;
                
            case NYSTKComeInDirectionLeft: {
                make.right.mas_equalTo(bgImageView.superview.mas_left).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
                make.centerY.mas_equalTo(bgImageView.superview.mas_centerY).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
            }
                break;
                
            case NYSTKComeInDirectionRight: {
                make.left.mas_equalTo(bgImageView.superview.mas_right).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.horizontal);
                make.centerY.mas_equalTo(bgImageView.superview.mas_centerY).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
            }
                break;
                
            default:
                break;
        }
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.superview.mas_left).mas_offset(NYSTKNormalSpace);
        make.right.mas_equalTo(label.superview.mas_right).mas_offset(-60);
        make.centerY.mas_equalTo(label.superview.mas_centerY);
    }];
    
    [bgImageView.superview layoutIfNeeded];
    
    [bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        switch (direction) {
            case NYSTKComeInDirectionDefault: {
                make.size.mas_equalTo(CGSizeMake(NYSTK_ScreenWidth * 0.75, NYSTK_RealValue(70)));
            }
                break;
                
            case NYSTKComeInDirectionUp: {
                make.top.mas_equalTo(bgImageView.superview.mas_top).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
            }
                break;
                
            case NYSTKComeInDirectionDown: {
                make.bottom.mas_equalTo(bgImageView.superview.mas_bottom).mas_offset([NYSTKConfig defaultConfig].offsetFromCenter.vertical);
            }
                break;
                
            case NYSTKComeInDirectionLeft: {
                make.right.mas_equalTo(bgImageView.superview.mas_left).mas_offset(NYSTK_ScreenWidth * 0.875);
            }
                break;
                
            case NYSTKComeInDirectionRight: {
                make.left.mas_equalTo((NYSTK_ScreenWidth * 0.25)/2);
            }
                break;
                
            default:
                break;
        }
    }];
    
    [UIView animateWithDuration:0.77 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [bgImageView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 自动移除toast
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((closeButtonClickedBlock ? MAXFLOAT : [NYSTKConfig defaultConfig].autoDismissDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0f animations:^{
                bgImageView.alpha = 0;
            } completion:^(BOOL finished) {
                [bgImageView removeFromSuperview];
            }];
        });
    }];
    
    // 粒子效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:view durationTime:NYSTKEmitterAnimationDuration];
}

#pragma mark - 图片\签到弹框

/// 图片签到弹框
/// @param messageText 富文本信息
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
           infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageAlertWithMessage:messageText
                              image:nil
                           imageURL:nil
                             onView:NYSTK_AppWindow
                        emitterType:NYSTKEmitterAnimationTypeColourbar
                         themeModel:NYSTKThemeModelAuto
             infoButtonClickedBlock:infoButtonClickedBlock
            closeButtonClickedBlock:nil];
}

/// 图片弹框
/// @param messageText 富文本信息
/// @param imageURL 自定义弹框背景图url
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
                         imageURL:(NSURL *)imageURL
           infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageAlertWithMessage:messageText
                              image:nil
                           imageURL:imageURL
                             onView:NYSTK_AppWindow
                        emitterType:NYSTKEmitterAnimationTypeColourbar
                         themeModel:NYSTKThemeModelAuto
             infoButtonClickedBlock:infoButtonClickedBlock
            closeButtonClickedBlock:nil];
}

/// 图片弹框
/// @param messageText 富文本信息
/// @param imageName 自定义弹框背景图
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
                            image:(NSString *)imageName
           infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock {
    [self showImageAlertWithMessage:messageText
                              image:imageName
                           imageURL:nil
                             onView:NYSTK_AppWindow
                        emitterType:NYSTKEmitterAnimationTypeColourbar
                         themeModel:NYSTKThemeModelAuto
             infoButtonClickedBlock:infoButtonClickedBlock
            closeButtonClickedBlock:nil];
}


/// 图片\签到弹框
/// @param messageText 富文本信息
/// @param imageName 自定义弹框背景图
/// @param imageURL 自定义弹框背景图url
/// @param view 作用域
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 点击事件回调
/// @param closeButtonClickedBlock 关闭事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
                            image:(NSString *)imageName
                         imageURL:(NSURL *)imageURL
                           onView:(UIView *)view
                      emitterType:(NYSTKEmitterAnimationType)emitter
                       themeModel:(NYSTKThemeModel)theme
           infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
          closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    [self setDefaultValue];
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgView;
    if ([NYSTKConfig defaultConfig].isHiddenCloseBtn) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        closeButtonClickedBlock ? closeButtonClickedBlock() : nil;
    }
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
//    NSAssert(imageName || imageURL, @"imageURL和imageName不能同时为空");
    NYSTKImageView *bgImageView = [[NYSTKImageView alloc] init];
    bgImageView.contentMode = [NYSTKConfig defaultConfig].bgImageViewContentMode;
    bgImageView.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius;
    bgImageView.clipsToBounds = YES;
    if (!imageName && imageURL) {
        [bgImageView setImageWithURL:imageURL placeholder:[NSBundle nystk_imageForKey:@"placeholder_img"]];
    } else if (imageName && !imageURL) {
        bgImageView.image = [UIImage imageNamed:imageName];
    } else if (!imageName && !imageURL) {
        bgImageView.image = [NSBundle nystk_imageForKey:@"sign_yellow_bg"];
    }
    
    if ([NYSTKConfig defaultConfig].isHiddenInfoBtn) {
        [bgImageView addTapGestureRecognizerWithDelegate:nil Block:^(NSInteger tag) {
            [UIView animateWithDuration:0.5f animations:^{
                bgView.alpha = 0;
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
            }];
            infoButtonClickedBlock ? infoButtonClickedBlock() : nil;
        }];
    }
    
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        make.size.mas_equalTo(bgImageView.image.size);
    }];
    
    // 签到label
    UILabel *signLabel = [[UILabel alloc] init];
    [signLabel setNumberOfLines:0];
    signLabel.attributedText = messageText;
    signLabel.adjustsFontSizeToFitWidth = YES;
    signLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetForLabel.horizontal);
        make.centerY.mas_equalTo(bgImageView.mas_centerY).mas_offset([NYSTKConfig defaultConfig].offsetForLabel.vertical);
    }];
    
    // 查看详情按钮
    UIButton *infoButton = [[UIButton alloc] init];
    infoButton.hidden = [NYSTKConfig defaultConfig].isHiddenInfoBtn;
    [bgView addSubview:infoButton];
    infoButton.backgroundColor = [NYSTKConfig defaultConfig].tintColor;
    [infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [infoButton setTitle:[NSBundle nystk_localizedStringForKey:NYSTKInfoText] forState:UIControlStateNormal];
    infoButton.layer.cornerRadius = 6;
    infoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateNormal];
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateHighlighted];
    infoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    [infoButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        infoButtonClickedBlock ? infoButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX).mas_offset([NYSTKConfig defaultConfig].offsetForInfoBtn.horizontal);
        make.top.mas_equalTo(signLabel.mas_bottom).mas_offset([NYSTKConfig defaultConfig].offsetForInfoBtn.vertical);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    // 关闭按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.hidden = [NYSTKConfig defaultConfig].isHiddenCloseBtn;
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[NSBundle nystk_imageForKey:[NYSTKConfig defaultConfig].closeBtnImageName] forState:UIControlStateNormal];
    [cancelButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        closeButtonClickedBlock ? closeButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgImageView.mas_right).mas_offset([NYSTKConfig defaultConfig].offsetForCloseBtn.horizontal);
        make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset([NYSTKConfig defaultConfig].offsetForCloseBtn.vertical);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
  
    // 动画效果
    bgView.alpha = 0;
    infoButton.alpha = 0;
    cancelButton.alpha = 0;
    bgImageView.alpha = 0;
    bgImageView.transform = CGAffineTransformScale(bgImageView.transform, 0.5, 0.5);
    [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.alpha = 1.0;
        infoButton.alpha = 1.0;
        cancelButton.alpha = 1.0;
        bgImageView.alpha = 1.0;
        bgImageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    // 粒子效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

#pragma mark - 信息弹框(默认/成功/失败/警告)

/// 信息弹框
/// @param title 标题
/// @param message 信息
/// @param infoTitle 详情按钮标题
/// @param closeTitle 关闭按钮标题
/// @param view 作用域
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showMessageWithTitle:(NSString *)title
                     message:(NSAttributedString *)message
                   infoTitle:(NSString *)infoTitle
                  closeTitle:(NSString *)closeTitle
                      onView:(UIView *)view
                 emitterType:(NYSTKEmitterAnimationType)emitter
                  themeModel:(NYSTKThemeModel)theme
      infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    [self showMessageWithTitle:title
                       message:message
                     imageName:nil
                     infoTitle:infoTitle
                    closeTitle:closeTitle
                        onView:view
                          type:NYSTKMessageTypeDefault
                   emitterType:emitter
                    themeModel:theme
        infoButtonClickedBlock:infoButtonClickedBlock
       closeButtonClickedBlock:closeButtonClickedBlock];
}

/// 信息弹框
/// @param title 标题
/// @param message 信息
/// @param imageName 自定义图片名
/// @param infoTitle 详情按钮标题
/// @param closeTitle 关闭按钮标题
/// @param view 作用域
/// @param messageType 默认/成功/失败/警告
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showMessageWithTitle:(NSString *)title
                     message:(NSAttributedString *)message
                   imageName:(NSString *)imageName
                   infoTitle:(NSString *)infoTitle
                  closeTitle:(NSString *)closeTitle
                      onView:(UIView *)view
                        type:(NYSTKMessageType)messageType
                 emitterType:(NYSTKEmitterAnimationType)emitter
                  themeModel:(NYSTKThemeModel)theme
      infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    [self setDefaultValue];
    
    if (@available(iOS 13.0, *) && theme == NYSTKThemeModelAuto) {
        if ([UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle == UIUserInterfaceStyleDark) {
            theme = NYSTKThemeModelDark;
        } else {
            theme = NYSTKThemeModelLight;
        }
    }
    
    switch (messageType) {
        case NYSTKMessageTypeDefault:
            break;
            
        case NYSTKMessageTypeSuccess: {
            [NYSTKConfig defaultConfig].tintColor = [UIColor colorWithRed:0.24 green:0.74 blue:0.49 alpha:1.00];
        }
            break;
            
        case NYSTKMessageTypeWarning: {
            [NYSTKConfig defaultConfig].tintColor = [UIColor colorWithRed:0.98 green:0.55 blue:0.24 alpha:1.00];
        }
            break;
            
        case NYSTKMessageTypeEror: {
            [NYSTKConfig defaultConfig].tintColor = [UIColor colorWithRed:0.95 green:0.20 blue:0.25 alpha:1.00];
        }
            break;
            
        default:
            break;
    }
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgView;
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // bgView
    UIView *bgContentView = [[UIView alloc] init];
    [bgView addSubview:bgContentView];
    bgContentView.clipsToBounds = YES;
    bgContentView.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius;
    bgContentView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor whiteColor] colorWithAlphaComponent:NYSTKBackgroundAlpha] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    
    // 图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    UIImage *image = [[NSBundle nystk_imageForKey:@"alert_icon_bell_128x128"] nystk_imageByTintColor:[NYSTKConfig defaultConfig].tintColor];
    if (imageName) {
        image = [UIImage imageNamed:imageName];
    }
    iconImageView.image = image;
    [bgContentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgContentView);
        make.top.mas_equalTo(bgContentView.mas_top).mas_offset(NYSTKNormalSpace);
    }];
    
    // 标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgContentView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgContentView);
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_offset(NYSTKNormalSpace);
        make.left.mas_equalTo(bgContentView).mas_offset(NYSTKNormalSpace);
        make.right.mas_equalTo(bgContentView).mas_offset(-NYSTKNormalSpace);
    }];
    
    // 详细信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [bgContentView addSubview:messageLabel];
    messageLabel.attributedText = message;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(NYSTKNormalSpace);
        make.left.mas_equalTo(bgContentView).mas_offset(NYSTKNormalSpace);
        make.right.mas_equalTo(bgContentView).mas_offset(-NYSTKNormalSpace);
    }];
    
    // info按钮
    UIButton *infoButton = [[UIButton alloc] init];
    infoButton.clipsToBounds = YES;
    infoButton.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius * 0.75;
    infoButton.backgroundColor = [NYSTKConfig defaultConfig].tintColor;
    [bgContentView addSubview:infoButton];

    [infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [infoButton setTitle:infoTitle forState:UIControlStateNormal];
    [infoButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        infoButtonClickedBlock ? infoButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!closeTitle) {
            make.centerX.mas_equalTo(bgContentView.mas_centerX);
        } else {
            make.right.mas_equalTo(bgContentView.mas_centerX).mas_offset(-2*NYSTKNormalSpace);
        }
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_offset(NYSTKNormalSpace);
        make.size.mas_equalTo(infoTitle ? CGSizeMake(70, 35) : CGSizeZero);
    }];

    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.clipsToBounds = YES;
    cancelButton.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius * 0.75;
    cancelButton.layer.borderWidth = 1.0f;
    cancelButton.layer.borderColor = [NYSTKConfig defaultConfig].tintColor.CGColor;
    [bgContentView addSubview:cancelButton];

    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancelButton setTitle:closeTitle forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitleColor:[NYSTKConfig defaultConfig].tintColor forState:UIControlStateNormal];
    [cancelButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        closeButtonClickedBlock ? closeButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!closeTitle) {
            make.centerX.mas_equalTo(bgContentView.mas_centerX);
        } else {
            make.left.mas_equalTo(bgContentView.mas_centerX).mas_offset(2*NYSTKNormalSpace);
        }
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_offset(NYSTKNormalSpace);
        make.size.mas_equalTo(cancelButton ? CGSizeMake(70, 35) : CGSizeZero);
    }];
    
    [bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView);
        
        make.width.mas_equalTo(NYSTK_ScreenWidth * 0.75);
        make.bottom.mas_equalTo(infoButton.mas_bottom).mas_offset(10);
    }];
    
    // blurBg
    if (![NYSTKConfig defaultConfig].isCloseBlurBg) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:@available(iOS 13.0, *) ? UIBlurEffectStyleSystemChromeMaterialLight : UIBlurEffectStyleExtraLight];
        if (theme == NYSTKThemeModelDark) {
            blurEffect = @available(iOS 13.0, *) ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterialDark] : [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        bgContentView.alpha = 0;
        [bgContentView insertSubview:visualView atIndex:0];
        
        [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.centerY.mas_equalTo(bgView);
            
            make.width.mas_equalTo(NYSTK_ScreenWidth * 0.75);
            make.bottom.mas_equalTo(infoButton.mas_bottom).mas_offset(10);
        }];
    }
    
    // 动画震动效果
    bgView.alpha = 0;
    bgContentView.alpha = 0;
    bgContentView.transform = CGAffineTransformScale(bgContentView.transform, 0.7, 0.7);
    [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.alpha = 1.0;
        bgContentView.alpha = 1.0;
        bgContentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [NYSTKConfig defaultConfig].isCloseFeedback ? nil : [feedBackGenertor impactOccurred];
        
        CGFloat t = 2.0;
        CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
        CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
        iconImageView.transform = translateLeft;
        CGFloat duration = [NYSTKConfig defaultConfig].transformDuration == 0 ? 0 : 0.07;
        [UIView animateWithDuration:duration
                              delay:0.1 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                         animations:^{
            [UIView setAnimationRepeatCount:2.0];
            iconImageView.transform = translateRight;
        } completion:^(BOOL finished) {
            [NYSTKConfig defaultConfig].isCloseFeedback ? nil : [feedBackGenertor impactOccurred];
        }];
    }];
    
    // 彩带效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

#pragma mark - 提示弹框(取消/确定)

/// 提示弹框
/// @param title 标题
/// @param message 富文本信息
/// @param view 作用域
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSAttributedString *)message
                    onView:(UIView *)view
               emitterType:(NYSTKEmitterAnimationType)emitter
                themeModel:(NYSTKThemeModel)theme
    infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    [self showAlertWithTitle:title
                     message:message
                   infoTitle:nil
                  closeTitle:nil
                      onView:view
                 emitterType:emitter
                  themeModel:theme
      infoButtonClickedBlock:infoButtonClickedBlock
     closeButtonClickedBlock:closeButtonClickedBlock];
}

/// 提示弹框
/// @param title 标题
/// @param message 富文本信息
/// @param infoTitle 详情按钮标题
/// @param closeTitle 关闭按钮标题
/// @param view 作用域
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSAttributedString *)message
                 infoTitle:(NSString *)infoTitle
                closeTitle:(NSString *)closeTitle
                    onView:(UIView *)view
               emitterType:(NYSTKEmitterAnimationType)emitter
                themeModel:(NYSTKThemeModel)theme
    infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    [self setDefaultValue];
    
    if (@available(iOS 13.0, *) && theme == NYSTKThemeModelAuto) {
        if ([UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle == UIUserInterfaceStyleDark) {
            theme = NYSTKThemeModelDark;
        } else {
            theme = NYSTKThemeModelLight;
        }
    }
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgView;
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // bgView
    UIView *bgContentView = [[UIView alloc] init];
    [bgView addSubview:bgContentView];
    bgContentView.clipsToBounds = YES;
    bgContentView.layer.cornerRadius = [NYSTKConfig defaultConfig].contentBgCornerRadius;
    bgContentView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor whiteColor] colorWithAlphaComponent:NYSTKBackgroundAlpha] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    [bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(255);
        make.center.mas_equalTo(bgView);
    }];
    
    // blurBg
    if (![NYSTKConfig defaultConfig].isCloseBlurBg) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:@available(iOS 13.0, *) ? UIBlurEffectStyleSystemChromeMaterialLight : UIBlurEffectStyleExtraLight];
        if (theme == NYSTKThemeModelDark) {
            blurEffect = @available(iOS 13.0, *) ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterialDark] : [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        bgContentView.alpha = 0;
        [bgContentView insertSubview:visualView atIndex:0];
    
        [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(255);
            make.center.mas_equalTo(bgView);
        }];
    }
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgContentView addSubview:titleLabel];
    titleLabel.textColor = (theme == NYSTKThemeModelLight) ? [UIColor blackColor] : [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NYSTKNormalSpace);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(17);
    }];
    
    // 提示信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [bgContentView addSubview:messageLabel];
    messageLabel.attributedText = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgContentView).mas_offset(10);
        make.right.mas_equalTo(bgContentView).mas_offset(-10);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.hidden = [NYSTKConfig defaultConfig].isHiddenCloseBtn;
    [bgContentView addSubview:cancelButton];
    [cancelButton setTitle:closeTitle ? closeTitle : [NSBundle nystk_localizedStringForKey:NYSTKCancelText] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[NYSTKConfig defaultConfig].tintColor forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [cancelButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        closeButtonClickedBlock ? closeButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgContentView);
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(bgContentView.mas_centerX);
        make.height.mas_equalTo(43);
    }];
    
    // 详情按钮
    UIButton *infoButton = [[UIButton alloc] init];
    infoButton.hidden = [NYSTKConfig defaultConfig].isHiddenInfoBtn;
    [bgContentView addSubview:infoButton];
    [infoButton setTitle:infoTitle ? infoTitle : [NSBundle nystk_localizedStringForKey:NYSTKInfoText] forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [infoButton setTitleColor:[NYSTKConfig defaultConfig].tintColor forState:UIControlStateNormal];
    [infoButton addTapBlock:^(id  _Nonnull obj) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
        infoButtonClickedBlock ? infoButtonClickedBlock() : nil;
    } withEvent:UIControlEventTouchUpInside];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.mas_equalTo(cancelButton);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.bottom.mas_equalTo(bgContentView);
    }];
    
    // 横线灰色线
    UIView *grayLineView1 = [[UIView alloc] init];
    [bgContentView addSubview:grayLineView1];
    grayLineView1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    [grayLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_offset(10);
    }];
    
    // 竖向灰色线
    UIView *grayLineView2 = [[UIView alloc] init];
    [bgContentView addSubview:grayLineView2];
    grayLineView2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    [grayLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayLineView1.mas_bottom);
        make.bottom.mas_equalTo(bgContentView);
        make.centerX.mas_equalTo(bgContentView);
        make.width.mas_equalTo(1);
    }];
    
    // 动画效果
    bgView.alpha = 0;
    bgContentView.alpha = 0;
    bgContentView.transform = CGAffineTransformScale(bgContentView.transform, 0.9, 0.9);
    [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.alpha = 1.0;
        bgContentView.alpha = 1.0;
        bgContentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
    // 彩带效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:view durationTime:NYSTKEmitterAnimationDuration];
}

#pragma mark - 自定义View弹框

/// 自定义View弹框
/// @param customView 自定义view
/// @param view 作用域
/// @param emitter 粒子效果
+ (void)showCustomView:(UIView *)customView
                onView:(UIView *)view
           emitterType:(NYSTKEmitterAnimationType)emitter {
    [self setDefaultValue];
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [NYSTKAlert sharedView].backgroundView = bgView;
    [bgView addTapGestureRecognizerWithDelegate:nil Block:^(NSInteger tag) {
        [UIView animateWithDuration:0.5f animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    }];
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 自定义view
    [bgView addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(customView.bounds.size.width, customView.bounds.size.height));
    }];
  
    // 动画效果
    bgView.alpha = 0;
    customView.alpha = 0;
    customView.transform = CGAffineTransformScale(customView.transform, 0.5, 0.5);
    [UIView animateWithDuration:[NYSTKConfig defaultConfig].transformDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.alpha = 1.0;
        customView.alpha = 1.0;
        customView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    // 粒子效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

#pragma mark - 关闭弹框
+ (void)dismiss {
    [[NYSTKAlert sharedView] dismissWithDelay:0 completion:nil];
}

+ (void)dismissWithCompletion:(nullable NYSTKAlertDismissCompletion)completion {
    [[NYSTKAlert sharedView] dismissWithDelay:0 completion:completion];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    [[NYSTKAlert sharedView] dismissWithDelay:delay completion:nil];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable NYSTKAlertDismissCompletion)completion {
    [[NYSTKAlert sharedView] dismissWithDelay:delay completion:completion];
}

@end
