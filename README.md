![(logo)](https://github.com/niyongsheng/NYSTK/blob/master/logo.png?raw=true)
NYSTK
===
<p align="left">
	<a href="http://cocoapods.org/pods/NYSTK">
    <img src="https://img.shields.io/cocoapods/v/NYSTK.svg" alt="Cocoapods Version">
  </a>
  <a href="http://cocoapods.org/pods/NYSTK">
    <img src="https://img.shields.io/cocoapods/p/NYSTK.svg" alt="Platform">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/cocoapods/l/NYSTK.svg" alt="MIT License">
  </a>
</p>

> ios 自定义弹框库 <br>
> ios colorful alert framework

## Usage:
* Installation with CocoaPods：
```ruby
pod 'NYSTK'
```

* Import the main file：
```objc
#import <NYSTK/NYSTK.h>
```

## Screenshot：
![(logo)](https://github.com/niyongsheng/NYSTK/blob/master/custom_none.gif)

<table>
<tr>
<th>image-bar</th>
<th>default</th>
<th>custom</th>
<th>simple</th>
<th>animation</th>
<th>image</th>
</tr>
<tr>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/image/image_bar_default.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/image/sign_default.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/image/sign_custom.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/toast/simple_toast_light.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/toast/animation_toast_native_light.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/toast/warning_toast_light.gif"/></td>
</tr>
</table>

<table>
<tr>
<th>success light</th>
<th>warning light</th>
<th>error light</th>
<th>success dark</th>
<th>warning dark</th>
<th>error dark</th>
</tr>
<tr>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/colourbar_message_alert_light.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/rain_message_alert_light.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/snow_message_alert_light.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/colourbar_message_alert_dark.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/rain_message_alert_dark.gif"/></td>
<td><img width="70px" height="120px" src="https://niyongsheng.github.io/Document/NYSTK/alert/snow_message_alert_dark.gif"/></td>
</tr>
</table>


## Summary:
```text
NYSTK
├─ NSBundle+NYSTK.h
├─ NSBundle+NYSTK.m
├─ NYSTK.bundle
│    ├─ Info.plist
│    ├─ alert_close_icon@2x.png
│    ├─ alert_exchange_icon@2x.png
│    ├─ alert_icon_bell_128x128@2x.png
│    ├─ colourbar_1@2x.png
│    ├─ colourbar_2@2x.png
│    ├─ colourbar_3@2x.png
│    ├─ colourbar_4@2x.png
│    ├─ colourbar_5@2x.png
│    ├─ colourbar_6@2x.png
│    ├─ colourbar_7@2x.png
│    ├─ colourbar_8@2x.png
│    ├─ en.lproj
│    │    └─ Localizable.strings
│    ├─ fireworks.png
│    ├─ group_banner_0_375x80_@2x.png
│    ├─ group_banner_1_375x80_@2x.png
│    ├─ group_banner_2_375x80_@2x.png
│    ├─ group_banner_3_375x80_@2x.png
│    ├─ group_banner_4_375x80_@2x.png
│    ├─ group_banner_5_375x80_@2x.png
│    ├─ loadingcircleimage@2x.png
│    ├─ placeholder_img@2x.png
│    ├─ rain.png
│    ├─ sign_yellow_bg@2x.png
│    ├─ snow.png
│    ├─ toast_error@2x.png
│    ├─ toast_success@2x.png
│    ├─ toast_warning@2x.png
│    ├─ zh-Hans.lproj
│    │    └─ Localizable.strings
│    └─ zh-Hant.lproj
│           └─ Localizable.strings
├─ NYSTK.h
├─ NYSTKAlert.h
├─ NYSTKAlert.m
├─ NYSTKConfig.h
├─ NYSTKConfig.m
├─ NYSTKConst.h
├─ NYSTKConst.m
├─ NYSTKEmitterUtil.h
├─ NYSTKEmitterUtil.m
├─ NYSTKImageView.h
├─ NYSTKImageView.m
├─ UIButton+NYSTK.h
├─ UIButton+NYSTK.m
├─ UIColor+NYSTK.h
├─ UIColor+NYSTK.m
├─ UIImage+NYSTK.h
├─ UIImage+NYSTK.m
├─ UIView+NYSTK.h
└─ UIView+NYSTK.m
```

## APIs:
[NYSTKConfig.h](https://github.com/niyongsheng/NYSTK/blob/master/NYSTK/NYSTKConfig.h)
<br>
[NYSTKAlert.h](https://github.com/niyongsheng/NYSTK/blob/master/NYSTK/NYSTKAlert.h)

- Objective-C

```objc
#import <NYSTK/NYSTK.h>

NSString *titleString = @"NYSTK test message ...";

[NYSTKAlert showImageBarWithMessage:titleString
                  attributedMessage:nil
                              image:nil
                                type:NYSTKColorfulToastTypeGreenStar
                          direction:NYSTKComeInDirectionDefault
                              onView:NYSTK_AppWindow
                        emitterType:NYSTKEmitterAnimationTypeColourbar
                          themeModel:NYSTKThemeModelAuto
                          infoButtonClickedBlock:^{
                    
} closeButtonClickedBlock:^{
                    
}];
``` 

## Remind
- [x] ARC
- [x] iOS >= 10.0
- [x] iPhone \ iPad screen anyway

## Contact Me
* E-mail: niyongsheng@Outlook.com
* Weibo: [@Ni永胜](https://weibo.com/u/7317805089)

## Contribution
Reward[:lollipop:](https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Beg/README.md)  Encourage[:heart:](https://github.com/niyongsheng/NYSTK/stargazers)

## License
`NYSTK` is available under the [MIT license](/LICENSE). See the LICENSE file for more info.
