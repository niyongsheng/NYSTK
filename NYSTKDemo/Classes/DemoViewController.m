//
//  DemoViewController.m
//  NYSTKDemo <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "DemoViewController.h"
#import "BLCustomContentView.h"
#import "NYSTK.h"

#define ImageURL1 @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2775010751,3989798890&fm=26&gp=0.jpg"
#define ImageURL2 @"http://anjufile.qmook.com/aaaaaaa/0a/79b2d4c6305e4c1712fd67a8753bf5.png"
#define ImageURL3 @"https://s1.ax1x.com/2020/09/07/wn4l6J.png"
#define DelayTime 2.5f

static NSString *titleString = @"NYSTK Test test tes te ...";
static NSString *loremString = @"Lorem ipsum dolor sit amet, 🤖consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

@interface DemoViewController () <BLCustomContentViewDelegate>
@property (nonatomic, strong) UIImageView *bgimageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) BLCustomContentView *contentView;
@end

@implementation DemoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(closeBtnClicked:)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateScreen) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.bgimageView];
    [self.view addSubview:self.effectView];
    [self.view addSubview:self.titleLabel];
    
    NYSTK_WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf showAlert];
    });
}

- (void)showAlert {
    // 清空默认样式
    [NYSTKAlert clearDefaultValue];
    
    if (self.indexPath.section == 0) {
        
        NSString *toastMsg = @"Toast Message Test !";
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, 350);
                [NYSTKAlert showToastWithMessage:toastMsg themeModel:self.tintModel];
            }
                break;
                
            case 1: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, 200);
                [NYSTKAlert showToastWithMessage:toastMsg
                                           image:@"logo"
                                      themeModel:self.tintModel];
            }
                break;
                
            case 2: {
                [NYSTKAlert showToastWithMessage:toastMsg
                                            animationType:NYSTKAnimationTypeImage
                                      themeModel:self.tintModel];
            }
                break;
                
            case 3: {
                [NYSTKAlert showToastWithMessage:toastMsg
                                            animationType:NYSTKAnimationTypeNative
                                      themeModel:self.tintModel];
                
            }
                break;
                
            case 4: {
                [NYSTKAlert showToastWithMessage:toastMsg
                                     messageType:NYSTKMessageTypeSuccess
                                      themeModel:self.tintModel];
                
            }
                break;
                
            case 5: {
                [NYSTKAlert showToastWithMessage:toastMsg
                                     messageType:NYSTKMessageTypeWarning
                                      themeModel:self.tintModel];
                
            }
                break;
                
            case 6: {
                [NYSTKAlert showToastWithMessage:toastMsg
                                     messageType:NYSTKMessageTypeError
                                      themeModel:self.tintModel];
                
            }
                break;
                
            default:
                break;
        }
        
    } else if (self.indexPath.section == 1) {
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKAlert showImageBarWithMessage:titleString
                                             onView:self.view
                             infoButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, 20);
                [NYSTKAlert showImageBarWithMessage:titleString
                                  attributedMessage:nil
                                              image:nil
                                               type:NYSTKColorfulToastTypeBlueHand
                                          direction:NYSTKComeInDirectionUp
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeNone
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, -20);
                [NYSTKAlert showImageBarWithMessage:titleString
                                  attributedMessage:nil
                                              image:nil
                                               type:NYSTKColorfulToastTypeGreenBook
                                          direction:NYSTKComeInDirectionDown
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeNone
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 3: {
                [NYSTKAlert showImageBarWithMessage:titleString
                                  attributedMessage:nil
                                              image:nil
                                               type:NYSTKColorfulToastTypeGreenStar
                                          direction:NYSTKComeInDirectionLeft
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeNone
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 4: {
                [NYSTKAlert showImageBarWithMessage:titleString
                                  attributedMessage:nil
                                              image:nil
                                               type:NYSTKColorfulToastTypeBlueFlower
                                          direction:NYSTKComeInDirectionRight
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeNone
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 5: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, -100);
                [NYSTKConfig defaultConfig].contentFont = [UIFont italicSystemFontOfSize:17.0f];
                
                [NYSTKAlert showImageBarWithMessage:nil
                                  attributedMessage:[self getMessageAttribute:titleString type:NYSTKMessageTypeSuccess]
                                              image:@"custom_icon_image_bar"
                                               type:NYSTKColorfulToastTypeCustom
                                          direction:NYSTKComeInDirectionDefault
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeNone
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        
    } else if (self.indexPath.section == 2) {
        
        NSString *amount = [NSString stringWithFormat:@"%d", 100];
        NSString *str = [NSString stringWithFormat:@"恭喜您^^\n获得%@积分", amount];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} range:[str rangeOfString:str]];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[str rangeOfString:amount]];
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKConfig defaultConfig].offsetForLabel = UIOffsetMake(0, -25);
                [NYSTKConfig defaultConfig].offsetForCloseBtn = UIOffsetMake(-70, 100);
                [NYSTKConfig defaultConfig].offsetForInfoBtn = UIOffsetMake(0, 10);
                [NYSTKConfig defaultConfig].tintColor = [UIColor colorWithRed:1.00 green:0.76 blue:0.05 alpha:1.00];
                [NYSTKAlert showImageAlertWithMessage:attrStr
                               infoButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:amount]];
                [NYSTKConfig defaultConfig].offsetForCloseBtn = UIOffsetMake(-20, 10);
                [NYSTKConfig defaultConfig].offsetForInfoBtn = UIOffsetMake(0, 10);
                [NYSTKConfig defaultConfig].tintColor = [UIColor redColor];
                [NYSTKAlert showImageAlertWithMessage:attrStr
                                                image:@"sign_red_bg"
                                             imageURL:nil
                                               onView:self.view
                                          emitterType:NYSTKEmitterAnimationTypeSnow
                                           themeModel:self.tintModel
                               infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                [NYSTKConfig defaultConfig].offsetForInfoBtn = UIOffsetMake(0, 115);
                [NYSTKConfig defaultConfig].tintColor = [UIColor redColor];
                [NYSTKAlert showImageAlertWithMessage:nil
                                                image:nil
                                             imageURL:[NSURL URLWithString:ImageURL1]
                                               onView:self.view
                                          emitterType:NYSTKEmitterAnimationTypeNone
                                           themeModel:self.tintModel
                               infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 3: {
                [NYSTKConfig defaultConfig].isHiddenInfoBtn = YES;
                [NYSTKConfig defaultConfig].bgImageViewContentMode = UIViewContentModeScaleAspectFill;
                [NYSTKAlert showImageAlertWithMessage:nil
                                                image:nil
                                             imageURL:[NSURL URLWithString:ImageURL2]
                                               onView:self.view
                                          emitterType:NYSTKEmitterAnimationTypeNone
                                           themeModel:self.tintModel
                               infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        
    } else if (self.indexPath.section == 3) {
        
        NSString *titleStr = @"温馨提醒";
        NSString *cnStr = @"给个小星星✨\n鼓励一下吧\n";
        NSString *enStr = @"Please click the Star.";
        NSString *string = [cnStr stringByAppendingString:enStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor systemPinkColor]} range:[string rangeOfString:string]];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[string rangeOfString:@"小星星"]];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:[string rangeOfString:enStr]];
        [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:[string rangeOfString:enStr]];
        
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKConfig defaultConfig].transformDuration = CGFLOAT_MIN;
                [NYSTKConfig defaultConfig].backgroundAlphaComponent = CGFLOAT_MIN;
                [NYSTKConfig defaultConfig].isCloseFeedback = YES;
                
                [NYSTKAlert showMessageWithTitle:titleStr
                                         message:[[NSAttributedString alloc] initWithString:enStr]
                                       imageName:@"alert_icon_top"
                                       infoTitle:@"I know"
                                      closeTitle:nil
                                          onView:self.view
                                     messageType:NYSTKMessageTypeDefault
                                     emitterType:NYSTKEmitterAnimationTypeNone
                                      themeModel:self.tintModel
                          infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                [NYSTKAlert showMessageWithTitle:titleStr
                                         message:attrStr
                                       imageName:nil
                                       infoTitle:@"好的"
                                      closeTitle:@"取消"
                                          onView:self.view
                                     messageType:NYSTKMessageTypeSuccess
                                     emitterType:NYSTKEmitterAnimationTypeColourbar
                                      themeModel:self.tintModel
                          infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                [NYSTKAlert showMessageWithTitle:titleStr
                                         message:attrStr
                                       imageName:nil
                                       infoTitle:@"好的"
                                      closeTitle:@"取消"
                                          onView:self.view
                                     messageType:NYSTKMessageTypeWarning
                                     emitterType:NYSTKEmitterAnimationTypeRain
                                      themeModel:self.tintModel
                          infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 3: {
                [NYSTKAlert showMessageWithTitle:titleStr
                                         message:attrStr
                                       imageName:nil
                                       infoTitle:@"好的"
                                      closeTitle:@"取消"
                                          onView:self.view
                                     messageType:NYSTKMessageTypeError
                                     emitterType:NYSTKEmitterAnimationTypeSnow
                                      themeModel:self.tintModel
                          infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        
    } else if (self.indexPath.section == 4) {
        
        switch (self.indexPath.row) {
                
            case 0: {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1000];
                NSString *timeString = [formatter stringFromDate:date];

                NSString *string = [@"有效期:" stringByAppendingString:timeString];
                NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
                [attribut setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, string.length)];
                [attribut addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, string.length)];

                [NYSTKAlert showAlertWithTitle:@"优惠劵"
                                       message:attribut
                                        onView:self.view
                                   emitterType:NYSTKEmitterAnimationTypeNone
                                    themeModel:self.tintModel
                        infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:loremString];
                [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:[loremString rangeOfString:loremString]];
                
                [NYSTKAlert showAlertWithTitle:@"TEST⚠️"
                                       message:attrStr
                                        onView:self.view
                                   emitterType:NYSTKEmitterAnimationTypeNone
                                    themeModel:self.tintModel
                        infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                NSString *string = @"￥21000.00/月\n";
                NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
                NSRange range = [string rangeOfString:@"/"];
                [attribut setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[string rangeOfString:string]];
                [attribut addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:25]} range:NSMakeRange(0, range.location)];
                
                [attribut appendAttributedString:[self getMessageAttribute:@"\n出勤天数: 20天" type:NYSTKMessageTypeSuccess]];
                [attribut appendAttributedString:[self getMessageAttribute:@"\n请假天数: 1天" type:NYSTKMessageTypeWarning]];
                [attribut appendAttributedString:[self getMessageAttribute:@"\n迟到天数: 0天" type:NYSTKMessageTypeError]];
                [attribut appendAttributedString:[self getMessageAttribute:@"\n... 天" type:NYSTKMessageTypeDefault]];

                [NYSTKAlert showAlertWithTitle:@"工资条"
                                       message:attribut
                                     infoTitle:@"查看"
                                    closeTitle:@"取消"
                                        onView:self.view
                                   emitterType:NYSTKEmitterAnimationTypeFireworks
                                    themeModel:self.tintModel
                        infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        
    } else if (self.indexPath.section == 5) {
        
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKAlert showCustomView:self.contentView
                                    onView:self.view
                               emitterType:NYSTKEmitterAnimationTypeColourbar];
            }
                break;
                
            default:
                break;
        }
         
    } else {
        [NYSTKAlert showToastWithMessage:@"Undefined Object !" image:@"logo" themeModel:self.tintModel];
        
        [NYSTKAlert dismissWithDelay:DelayTime completion:^{
            
        }];
    }
}

#pragma mark - lazzy load
- (UIImageView *)bgimageView {
    if (!_bgimageView) {
        _bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NYSTK_ScreenWidth, NYSTK_ScreenHeight)];
        _bgimageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgimageView.image = [UIImage imageNamed:@"logo"];
    }
    return _bgimageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, NYSTK_ScreenWidth - 50, NYSTK_ScreenHeight/3)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setFont:[UIFont fontWithName:@"DINCondensed-Bold" size:50.f]];
        [_titleLabel setTextColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:0.85f]];
        [_titleLabel setText:self.title];
    }
    return _titleLabel;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
//        UIBlurEffect *effect = self.tintModel == 0 ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular] : [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = CGRectMake(0, 0, NYSTK_ScreenWidth, NYSTK_ScreenHeight);
    }
    return _effectView;
}

- (void)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Screen Orientation Control
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)rotateScreen {
    self.effectView.frame = CGRectMake(0, 0, NYSTK_ScreenWidth, NYSTK_ScreenHeight);
    [self.effectView layoutIfNeeded];
}

- (NSMutableAttributedString *)getMessageAttribute:(NSString *)string type:(NYSTKMessageType)type {
    UIColor *color = nil;
    if (type == NYSTKMessageTypeSuccess) {
        color = [UIColor colorWithRed:0.21 green:0.71 blue:0.45 alpha:1.00];
    } else if (type == NYSTKMessageTypeError) {
        color = [UIColor colorWithRed:0.94 green:0.17 blue:0.22 alpha:1.00];
    } else if (type == NYSTKMessageTypeWarning) {
        color = [UIColor colorWithRed:0.98 green:0.51 blue:0.21 alpha:1.00];
    } else {
        color = [UIColor darkGrayColor];
    }
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    [attribut setAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:[string rangeOfString:string]];
    NSRange range = [string rangeOfString:@" "];
    NSRange pointRange = NSMakeRange(0, range.location);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:20.0f];
    [attribut setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]} range:range];
    [attribut setAttributes:@{NSForegroundColorAttributeName:color} range:pointRange];
    
    return attribut;
}

- (BLCustomContentView *)contentView {
    if (!_contentView) {
        CGFloat scale = 375.0 / NYSTK_ScreenWidth;
        CGFloat width = 320.0 * scale;
        CGFloat height = 360.0 * scale;
        _contentView = [[BLCustomContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [_contentView updateTitle:@"🎯\nLorem" desc:loremString buttonTitle:@"Got it"];
        _contentView.delegate = self;
    }
    return _contentView;
}

#pragma mark - BLCustomContentViewDelegate
- (void)didClickedCloseButton:(UIButton *)button {
    [NYSTKAlert dismissWithDelay:0.1 completion:^{
        
    }];
}

@end
