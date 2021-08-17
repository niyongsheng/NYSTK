//
//  DemoViewController.m
//  NYSTKDemo <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "DemoViewController.h"
#import "NYSTK.h"

#define ImageURL1 @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2775010751,3989798890&fm=26&gp=0.jpg"
#define ImageURL2 @"http://anjufile.qmook.com/aaaaaaa/0a/79b2d4c6305e4c1712fd67a8753bf5.png"
#define ImageURL3 @"https://s1.ax1x.com/2020/09/07/wn4l6J.png"

@interface DemoViewController ()
@property (nonatomic, strong) UIImageView *bgimageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIVisualEffectView *effectView;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf showAlert];
    });
}

- (void)showAlert {
    if (self.indexPath.section == 0) {
        
    } else if (self.indexPath.section == 1) {
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKAlert showImageBarWithMessage:@"NYSTK Test test tes te ..."
                                  attributedMessage:nil
                                              image:nil
                                               type:NYSTKColorfulToastTypeGreenStar
                                          direction:NYSTKComeInDirectionDefault
                                             onView:self.view
                                        emitterType:NYSTKEmitterAnimationTypeColourbar
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, 20);
                [NYSTKAlert showImageBarWithMessage:@"NYSTK Test test tes te ..."
                                               type:NYSTKColorfulToastTypeBlueHand
                                          direction:NYSTKComeInDirectionUp
                                             onView:self.view
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                [NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, -20);
                [NYSTKAlert showImageBarWithMessage:@"NYSTK Test test tes te ..."
                                               type:NYSTKColorfulToastTypeBlueHand
                                          direction:NYSTKComeInDirectionDown
                                             onView:self.view
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 3: {
                [NYSTKAlert showImageBarWithMessage:@"NYSTK Test test tes te ..."
                                               type:NYSTKColorfulToastTypeBlueHand
                                          direction:NYSTKComeInDirectionLeft
                                             onView:self.view
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 4: {
                [NYSTKAlert showImageBarWithMessage:@"NYSTK Test test tes te ..."
                                               type:NYSTKColorfulToastTypeBlueHand
                                          direction:NYSTKComeInDirectionRight
                                             onView:self.view
                                         themeModel:self.tintModel
                             infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        [[NYSTKConfig defaultConfig] clearDefaultValue];
        
    } else if (self.indexPath.section == 2) {
        NSString *amount = [NSString stringWithFormat:@"%d", 100];
        NSString *str = [NSString stringWithFormat:@"恭喜您^^\n获得%@积分", amount];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        switch (self.indexPath.row) {
            case 0: {
                [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[str rangeOfString:amount]];
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
                [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[str rangeOfString:amount]];
                [NYSTKConfig defaultConfig].offsetForCloseBtn = UIOffsetMake(-20, 10);
                [NYSTKConfig defaultConfig].offsetForInfoBtn = UIOffsetMake(0, 10);
                [NYSTKConfig defaultConfig].tintColor = [UIColor redColor];
                [NYSTKAlert showImageAlertWithMessage:attrStr
                                                image:@"sign_red_bg"
                               infoButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 2: {
                [NYSTKConfig defaultConfig].offsetForInfoBtn = UIOffsetMake(0, 115);
                [NYSTKConfig defaultConfig].tintColor = [UIColor redColor];
                [NYSTKAlert showImageAlertWithMessage:nil
                                             imageURL:[NSURL URLWithString:ImageURL1]
                               infoButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 3: {
                [NYSTKConfig defaultConfig].isHiddenInfoBtn = YES;
                [NYSTKConfig defaultConfig].bgImageViewContentMode = UIViewContentModeScaleAspectFill;
                [NYSTKAlert showImageAlertWithMessage:nil
                                             imageURL:[NSURL URLWithString:ImageURL2]
                               infoButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
        [[NYSTKConfig defaultConfig] clearDefaultValue];
        
    } else if (self.indexPath.section == 3) {
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKAlert showMessageWithTitle:@"提醒"
                                         message:nil
                                       infoTitle:@"登录"
                                      closeTitle:@"取消"
                                          onView:self.view
                                     emitterType:NYSTKEmitterAnimationTypeNone
                                      themeModel:self.tintModel
                          infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
//                [NYSTKAlert showMessageWithTitle:@"Error"
//                                         message:[self getMessageAttribute:@"NYSTK\n error info" type:NYSTKMessageTypeEror]
//                                          onView:self.view
//                                            type:NYSTKMessageTypeEror
//                                       colorType:NYSTKMessageColorTypeRed
//                                     emitterType:NYSTKEmitterAnimationTypeSnow
//                                      themeModel:self.tintModel
//                          infoButtonClickedBlock:^{
//
//                } closeButtonClickedBlock:^{
//
//                }];
            }
                break;
                
            case 2: {
//                [NYSTKAlert showMessageWithTitle:@"WARNING"
//                                         message:[self getMessageAttribute:@"NYSTK\n warning info" type:NYSTKMessageTypeWarning]
//                                          onView:self.view
//                                            type:NYSTKMessageTypeWarning
//                                       colorType:NYSTKMessageColorTypeBlue
//                                     emitterType:NYSTKEmitterAnimationTypeRain
//                                      themeModel:self.tintModel
//                          infoButtonClickedBlock:^{
//
//                } closeButtonClickedBlock:^{
//
//                }];
            }
                break;
                
            default:
                break;
        }
    } else if (self.indexPath.section == 4) {
        switch (self.indexPath.row) {
            case 0: {
                [NYSTKAlert showAlertWithTitle:@"TEST"
                                       message:nil
                                     infoTitle:@"登录"
                                    closeTitle:@"取消"
                                        onView:self.view
                                   emitterType:NYSTKEmitterAnimationTypeNone
                                    themeModel:self.tintModel
                        infoButtonClickedBlock:^{
                    
                } closeButtonClickedBlock:^{
                    
                }];
            }
                break;
                
            case 1: {
                //                [NYSTKAlert showAlertWithTitle:@"查看优惠券"
                //                                       message:[[NSAttributedString alloc] initWithString:@"激活码：MVBCQ-B3VPW-CT369"]
                //                                          time:@"有效期:2020-09-07"
                //                                  infoBtnTitle:@"确定"
                //                                        onView:self.view
                //                                          type:NYSTKAlertTypeDefault
                //                                   emitterType:NYSTKEmitterAnimationTypeNone
                //                                    themeModel:self.tintModel
                //                        infoButtonClickedBlock:^{
                //
                //                } closeButtonClickedBlock:^{
                //
                //                }];
               
            }
                break;
                
            case 2: {
                
            }
                break;
                
            default:
                break;
        }
    } else {
        [NYSTKAlert showToastWithMessage:@"Undefined Object !" image:@"logo" themeModel:self.tintModel];
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
        UIBlurEffect *effect = self.tintModel == 0 ? [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular] : [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
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
    } else if (type == NYSTKMessageTypeEror) {
        color = [UIColor colorWithRed:0.94 green:0.17 blue:0.22 alpha:1.00];
    } else if (type == NYSTKMessageTypeWarning) {
        color = [UIColor colorWithRed:0.98 green:0.51 blue:0.21 alpha:1.00];
    } else {
        color = [UIColor blackColor];
    }
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@" "];
    NSRange pointRange = NSMakeRange(0, range.location);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:20.0f];
    [attribut setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]} range:range];
    [attribut setAttributes:@{NSForegroundColorAttributeName:color} range:pointRange];
    
    return attribut;
}

@end
