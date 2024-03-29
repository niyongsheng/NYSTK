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
  <a href="https://github.com/niyongsheng/NYSTK/issues">
     <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat" alt="Issues">
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

## Features
- [x] Config
- [x] Effect
- [x] Feedback
- [x] Animation
- [ ] Documentation

## Example:
- Objective-C

```objc
#import <NYSTK/NYSTK.h>

NSString *string = @"NYSTK test msg ...";

[NYSTKConfig defaultConfig].offsetFromCenter = UIOffsetMake(0, -100);
[NYSTKConfig defaultConfig].contentFont = [UIFont boldSystemFontOfSize:20.0f];

[NYSTKAlert showImageBarWithMessage:string
                             onView:NYSTK_AppWindow
             infoButtonClickedBlock:^{
                    
}];
``` 

## Summary:
```
NYSTK
├─ NSBundle+NYSTK.h
├─ NSBundle+NYSTK.m
├─ NYSTK.bundle
│    ├─ images
│    ├─ Info.plist
│    ├─ en.lproj
│    │    └─ Localizable.strings
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
