![(logo)](https://github.com/niyongsheng/NYSTK/blob/master/logo.png?raw=true)
NYSTK
===
[![](https://img.shields.io/badge/platform-iOS-orange.svg)](https://developer.apple.com/ios/)
[![](http://img.shields.io/travis/CocoaPods/CocoaPods/master.svg?style=flat)](https://travis-ci.org/CocoaPods/NYSMC)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/niyongsheng/NYSMC/blob/master/LICENSE)
===
* NYS弹框
* NYS alert framework

## <a id="How_to_use:"></a>How to use:
* Installation with CocoaPods：`pod 'NYSTK','~>0.0.1'`
* Manual import：
* Drag All files in the `NYSTK` folder to project
* Import the main file：`#import <NYSTK/NYSTK.h>`

## ScreenShot：
![image](https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Document/nystkDemo.gif)

## <a id="Tool_API:"></a>Tool API:
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

<!--
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
