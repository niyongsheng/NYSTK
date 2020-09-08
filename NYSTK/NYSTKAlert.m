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
#import "NYSTKImageView.h"

@interface NYSTKAlert ()

@end

@implementation NYSTKAlert

#pragma mark - 纯文本toast提示

/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message themeModel:(NYSTKThemeModel)theme {
    
    // bg view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor grayColor] colorWithAlphaComponent:0.85f] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    bgView.layer.cornerRadius = NYSTKBackgroundCornerRadius;
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.superview.mas_centerX);
        make.centerY.mas_equalTo(bgView.superview.mas_bottom).mas_offset(-50);
        make.top.left.mas_equalTo(label).mas_offset(-20);
        make.bottom.right.mas_equalTo(label).mas_offset(20);
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(150);
        make.center.mas_equalTo(label.superview);
    }];
    
    // 自动移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NYSTKAutoDismissDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName themeModel:(NYSTKThemeModel)theme {
    
    // bg view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor grayColor] colorWithAlphaComponent:0.7f] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    bgView.layer.cornerRadius = NYSTKBackgroundCornerRadius;
    
    // image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:22];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(label.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
    
    // 自动移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NYSTKAutoDismissDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

/// 炫彩弹框
/// @param message 信息
/// @param type 类型
/// @param direction 进入方向
/// @param view 作用域
/// @param theme 主题样式
+ (void)showColorfulToastWithMessage:(NSString *)message
                                type:(NYSTKColorfulToastType)type
                           direction:(NYSTKComeInDirection)direction
                              onView:(UIView *)view
                          themeModel:(NYSTKThemeModel)theme {
    // bg view
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.layer.cornerRadius = 10.0f;
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
            
        default:
            break;
    }
    [view addSubview:bgImageView];
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgImageView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置背景view的约束
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (direction) {
            case NYSTKComeInDirectionUp: {
                make.centerX.mas_equalTo(bgImageView.superview.mas_centerX);
                make.top.mas_equalTo(bgImageView.superview.mas_top).mas_offset(-NYSTK_RealValue(70));
            }
                break;
                
            case NYSTKComeInDirectionDown: {
                make.centerX.mas_equalTo(bgImageView.superview.mas_centerX);
                make.bottom.mas_equalTo(bgImageView.superview.mas_bottom).mas_offset(NYSTK_RealValue(70));
            }
                break;
                
            case NYSTKComeInDirectionLeft: {
                make.right.mas_equalTo(bgImageView.superview.mas_left);
                make.centerY.mas_equalTo(bgImageView.superview.mas_centerY);
            }
                break;
                
            case NYSTKComeInDirectionRight: {
                make.left.mas_equalTo(bgImageView.superview.mas_right);
                make.centerY.mas_equalTo(bgImageView.superview.mas_centerY);
            }
                break;
                
            default:
                break;
        }
        make.width.mas_lessThanOrEqualTo(NYSTK_ScreenWidth * 0.75);
        make.height.mas_lessThanOrEqualTo(NYSTK_RealValue(70));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.superview.mas_left).mas_offset(15);
        make.right.mas_equalTo(label.superview.mas_right).mas_offset(-60);
        make.centerY.mas_equalTo(label.superview.mas_centerY);
    }];
    
    [bgImageView.superview layoutIfNeeded];
    
    [bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        switch (direction) {
            case NYSTKComeInDirectionUp: {
                make.top.mas_equalTo(bgImageView.superview.mas_top).mas_offset(20);
            }
                break;
                
            case NYSTKComeInDirectionDown: {
                make.bottom.mas_equalTo(bgImageView.superview.mas_bottom).mas_offset(-20);
            }
                break;
                
            case NYSTKComeInDirectionLeft: {
                make.right.mas_equalTo(bgImageView.superview.mas_left).mas_offset(NYSTK_ScreenWidth * 0.875);
//                make.right.mas_equalTo(NYSTK_ScreenWidth * 0.875);
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NYSTKAutoDismissDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0f animations:^{
                bgImageView.alpha = 0;
            } completion:^(BOOL finished) {
                [bgImageView removeFromSuperview];
            }];
        });
    }];
}

#pragma mark - 带block回调的签到弹窗
/// 签到弹框
/// @param signMessageText 富文本
/// @param view 作用域
/// @param type 类型
/// @param emitter 粒子样式
/// @param theme 主题样式
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showSignAlertWithMessage:(NSAttributedString *)signMessageText
                          onView:(UIView *)view
                        signType:(NYSTKSignType)type
                     emitterType:(NYSTKEmitterAnimationType)emitter
                      themeModel:(NYSTKThemeModel)theme
          infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
         closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = (type == NYSTKSignTypeYellow) ? [NSBundle nystk_imageForKey:@"sign_yellow_bg"] : [UIImage imageNamed:@"sign_red_bg"];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        if (type == NYSTKSignTypeYellow) {
            make.size.mas_equalTo(CGSizeMake(NYSTK_ScreenWidth, NYSTK_RealValue(450)));
        } else if (type == NYSTKSignTypeRed) {
            make.size.mas_equalTo(CGSizeMake(NYSTK_ScreenWidth * 0.75, NYSTK_RealValue(260)));
        }
    }];
    
    // 签到label
    UILabel *signLabel = [[UILabel alloc] init];
    [signLabel setTextColor:[UIColor colorWithRed:1.00 green:0.76 blue:0.09 alpha:1.00]];
    [signLabel setNumberOfLines:0];
    signLabel.attributedText = signMessageText;
    signLabel.adjustsFontSizeToFitWidth = YES;
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.centerY.mas_equalTo(bgImageView).mas_offset(- NYSTK_RealValue(30));
    }];
    
    // 查看详情按钮
    UIButton *infoButton = [[UIButton alloc] init];
    [bgView addSubview:infoButton];
    infoButton.backgroundColor = [UIColor redColor];
    [infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [infoButton setTitle:[NSBundle nystk_localizedStringForKey:NYSTKInfoText] forState:UIControlStateNormal];
    infoButton.layer.cornerRadius = 6;
    infoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateNormal];
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateHighlighted];
    infoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    [[infoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        infoButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(signLabel.mas_bottom).mas_offset(NYSTK_RealValue(20));
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[NSBundle nystk_imageForKey:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        closeButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (type == NYSTKSignTypeYellow) {
            make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-55);
            make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset(110);
        } else if (type == NYSTKSignTypeRed) {
            make.right.mas_equalTo(bgImageView.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset(40);
        }
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 粒子效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

/// 网络图片弹框
/// @param imageURL 图片url
/// @param contentMode 显示方式
/// @param size 尺寸
/// @param view 作用域
/// @param emitter 粒子样式
/// @param theme 主题样式
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showAlertWithImageURL:(NSURL *)imageURL
                  contentMode:(UIViewContentMode)contentMode
                         size:(CGSize)size
                       onView:(UIView *)view
                  emitterType:(NYSTKEmitterAnimationType)emitter
                   themeModel:(NYSTKThemeModel)theme
       infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
      closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    // 网络图片
    NYSTKImageView *urlImageView = [[NYSTKImageView alloc] init];
    urlImageView.layer.cornerRadius = 10.0f;
    urlImageView.clipsToBounds = YES;
    urlImageView.contentMode = contentMode;
    [urlImageView setImageWithURL:imageURL placeholder:[NSBundle nystk_imageForKey:@"placeholder_img"]];
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 网络图片
    [bgView addSubview:urlImageView];
    [urlImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.size.mas_equalTo(size);
    }];
    
    // 详情按钮
    UIButton *infoButton = [[UIButton alloc] init];
    [bgView addSubview:infoButton];
    infoButton.backgroundColor = [UIColor nystk_colorWithHexString:@"e83421"];
    [infoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [infoButton setTitle:[NSBundle nystk_localizedStringForKey:NYSTKInfoText] forState:UIControlStateNormal];
    infoButton.layer.cornerRadius = 6;
    infoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateNormal];
    [infoButton setImage:[NSBundle nystk_imageForKey:@"sign_exchange"] forState:UIControlStateHighlighted];
    infoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    [[infoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        infoButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(urlImageView.mas_bottom).mas_offset(9);
        make.size.mas_equalTo(CGSizeMake(84, 29));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[NSBundle nystk_imageForKey:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        closeButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(urlImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(urlImageView.mas_top).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 粒子效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

/// 信息弹框
/// @param title 标题
/// @param message 信息
/// @param view 作用域
/// @param type 成功/失败/警告
/// @param colorType 颜色
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showMessageWithTitle:(NSString *)title
                     message:(NSAttributedString *)message
                      onView:(UIView *)view
                        type:(NYSTKMessageType)type
                   colorType:(NYSTKMessageColorType)colorType
                 emitterType:(NYSTKEmitterAnimationType)emitter
                  themeModel:(NYSTKThemeModel)theme
      infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = (colorType == NYSTKMessageColorTypeRed) ? [NSBundle nystk_imageForKey:@"nys_alert_bg_red"] : [NSBundle nystk_imageForKey:@"nys_alert_bg_blue"];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(NYSTK_RealValue(240), NYSTK_RealValue(250)));
    }];
    
    // 标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgImageView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).mas_offset(NYSTK_RealValue(15));
    }];
    
    // 成功图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    if (type == NYSTKMessageTypeSuccess) {
        iconImageView.image = [NSBundle nystk_imageForKey:@"nys_alert_success"];
    } else if (type == NYSTKMessageTypeEror) {
        iconImageView.image = [NSBundle nystk_imageForKey:@"nys_alert_fail"];
    } else if (type == NYSTKMessageTypeWarning) {
        iconImageView.image = [NSBundle nystk_imageForKey:@"nys_alert_warning"];
    }
    [bgImageView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView).mas_offset(-15);
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(NYSTK_RealValue(70), NYSTK_RealValue(70)));
    }];
    
    // 详细信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [bgImageView addSubview:messageLabel];
    messageLabel.attributedText = message;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_offset(14);
        make.left.right.mas_equalTo(bgImageView);
    }];
    
    // ok按钮
    UIButton *okButton = [[UIButton alloc] init];
    [bgView addSubview:okButton];
    if (colorType == NYSTKMessageColorTypeBlue) {
        okButton.backgroundColor = [[UIColor nystk_colorWithHexString:@"#4183ED"] colorWithAlphaComponent:0.85f];
    } else if (colorType == NYSTKMessageColorTypeRed) {
        okButton.backgroundColor = [[UIColor nystk_colorWithHexString:@"#EF2C37"] colorWithAlphaComponent:0.85f];
    }
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [okButton setTitle:[NSBundle nystk_localizedStringForKey:NYSTKIKnowText] forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 5.0f;
    [[okButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        infoButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.bottom.mas_equalTo(bgImageView.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(70, 35));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[NSBundle nystk_imageForKey:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        closeButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    // 彩带效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

/// 提示弹框
/// @param title 标题
/// @param message 信息
/// @param time 时间
/// @param btnTitle 确认按钮标题
/// @param view 作用域
/// @param type 类型
/// @param emitter 粒子效果
/// @param theme 主题
/// @param infoButtonClickedBlock 详情回调
/// @param closeButtonClickedBlock 关闭回调
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSAttributedString *)message
                      time:(NSString *)time
              infoBtnTitle:(NSString *)btnTitle
                    onView:(UIView *)view
                      type:(NYSTKAlertType)type
               emitterType:(NYSTKEmitterAnimationType)emitter
                themeModel:(NYSTKThemeModel)theme
    infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock {
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [view addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 白色view
    UIView *whiteView = [[UIView alloc] init];
    [bgView addSubview:whiteView];
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 5;
    whiteView.backgroundColor = (theme == NYSTKThemeModelLight) ? [[UIColor whiteColor] colorWithAlphaComponent:0.85f] : [[UIColor blackColor] colorWithAlphaComponent:NYSTKBackgroundAlpha];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(255);
        make.center.mas_equalTo(bgView);
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [whiteView addSubview:titleLabel];
    titleLabel.textColor = (theme == NYSTKThemeModelLight) ? [UIColor blackColor] : [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(17);
    }];
    
    // 提示信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [whiteView addSubview:messageLabel];
    messageLabel.attributedText = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = (theme == NYSTKThemeModelLight) ? [UIColor blackColor] : [UIColor lightGrayColor];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView).mas_offset(10);
        make.right.mas_equalTo(whiteView).mas_offset(-10);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
    }];
    
    // 时间label
    UILabel *timeLabel = [[UILabel alloc] init];
    [whiteView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor nystk_colorWithHexString:@"#EF2C37"];
    timeLabel.text = time;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(messageLabel);
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_offset(10);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [whiteView addSubview:cancelButton];
    [cancelButton setTitle:[NSBundle nystk_localizedStringForKey:NYSTKCancelText] forState:UIControlStateNormal];
    [cancelButton setTitleColor:NYSTKThemeColor forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // 点击取消按钮移除弹窗
        [bgView removeFromSuperview];
        closeButtonClickedBlock();
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(whiteView.mas_centerX);
        make.height.mas_equalTo(43);
    }];
    
    // 详情按钮
    UIButton *infoButton = [[UIButton alloc] init];
    [whiteView addSubview:infoButton];
    [infoButton setTitle:btnTitle forState:UIControlStateNormal];
    [infoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [infoButton setTitleColor:NYSTKThemeColor forState:UIControlStateNormal];
    [[infoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
        infoButtonClickedBlock();
    }];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.mas_equalTo(cancelButton);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.bottom.mas_equalTo(whiteView);
    }];
    
    // 横线灰色线
    UIView *grayLineView1 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView1];
    grayLineView1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    [grayLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
    }];
    
    // 竖向灰色线
    UIView *grayLineView2 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView2];
    grayLineView2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    [grayLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayLineView1.mas_bottom);
        make.bottom.mas_equalTo(whiteView);
        make.centerX.mas_equalTo(whiteView);
        make.width.mas_equalTo(1);
    }];
    
    // 彩带效果
    [NYSTKEmitterUtil showEmitterType:emitter onView:bgView durationTime:NYSTKEmitterAnimationDuration];
}

/*------------------------ TODO -----------------------------*/
#pragma mark - 提交成功提示弹框

@end
