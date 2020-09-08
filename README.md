![(logo)](https://github.com/niyongsheng/NYSTK/blob/master/logo.png?raw=true)
NYSTK
===
[![](https://img.shields.io/badge/platform-iOS-orange.svg)](https://developer.apple.com/ios/)
[![](http://img.shields.io/travis/CocoaPods/CocoaPods/master.svg?style=flat)](https://travis-ci.org/CocoaPods/NYSMC)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/niyongsheng/NYSMC/blob/master/LICENSE)
===
> NYS弹框<br>
> NYS alert framework

## How to use:
* Installation with CocoaPods：`pod 'NYSTK','~>0.0.5'`
* Import the main file：`#import <NYSTK/NYSTK.h>`
<br><hr>
* Manual import：Drag [`NYSTK`](https://github.com/niyongsheng/NYSTK/tree/master/NYSTK) folder to project
* Import the main file：`#import "NYSTK.h"`

## ScreenShot：
![image](https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Document/nystk_demo_1.gif)
![image](https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Document/nystk_demo_2.gif)

## Framework API:

```objc
#pragma mark - Toast
/// 纯文本toast
/// @param message 提示文本
/// @param theme 主题样式
+ (void)showToastWithMessage:(NSString *)message themeModel:(NYSTKThemeModel)theme;

/// 图文toast提示
/// @param message 提示样式
/// @param imageName 提示图
/// @param theme 主题样式
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName themeModel:(NYSTKThemeModel)theme;

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
                          themeModel:(NYSTKThemeModel)theme;

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
         closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
      closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;
```

<!--
```objc
[NYSTKAlert showColorfulToastWithMessage:@"NYSTK Test test tes te ..."
                                    type:NYSTKColorfulToastTypeBlueFlower
                               direction:NYSTKComeInDirectionUp
                                  onView:self.view
                              themeModel:self.tintModel];

[NYSTKAlert showSignAlertWithMessage:attrStr
                              onView:self.view
                            signType:NYSTKSignTypeYellow
                         emitterType:NYSTKEmitterAnimationTypeColourbar
                          themeModel:self.tintModel
              infoButtonClickedBlock:^{

} closeButtonClickedBlock:^{

}];

[NYSTKAlert showAlertWithTitle:@"查看优惠券"
                       message:[[NSAttributedString alloc] initWithString:@"激活码：MVBCQ-B3VPW-CT369"]
                          time:@"有效期:2020-09-07"
                  infoBtnTitle:@"确定"
                        onView:self.view
                          type:NYSTKAlertTypeDefault
                   emitterType:NYSTKEmitterAnimationTypeColourbar
                    themeModel:self.tintModel
                    infoButtonClickedBlock:^{

} closeButtonClickedBlock:^{

}];                                                              
```


* Step 1.Add Shell
```shell

```
* Step 2.AppDelegate.m
```objc

```
-->
## Remind
- [x] ARC
- [x] iOS >= 10.0
- [x] iPhone \ iPad screen anyway

## Contribution
Reward[:lollipop:](https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Beg/README.md)  Encourage[:heart:](https://github.com/niyongsheng/NYSTK/stargazers)

## Contact Me [:octocat:](https://niyongsheng.github.io)
* E-mail: niyongsheng@Outlook.com
* Weibo: [@Ni永胜](https://weibo.com/u/7317805089)
