//
//  NYSAlert.h
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSTKEmitterUtil.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NYSTKThemeModel) {
    NYSTKThemeModelLight,       // 浅色模式
    NYSTKThemeModelDark         // 暗黑模式
};

typedef NS_ENUM(NSUInteger, NYSTKComeInDirection) {
    NYSTKComeInDirectionUp,     // 顶部进入
    NYSTKComeInDirectionDown,   // 底部进入
    NYSTKComeInDirectionLeft,   // 左侧进入
    NYSTKComeInDirectionRight   // 右侧进入
};

typedef NS_ENUM(NSUInteger, NYSTKColorfulToastType) {
    NYSTKColorfulToastTypeGreenBook,
    NYSTKColorfulToastTypePurpleFlower,
    NYSTKColorfulToastTypeBlueHand,
    NYSTKColorfulToastTypeBlueFlower,
    NYSTKColorfulToastTypeYellowCat,
    NYSTKColorfulToastTypeGreenStar
};

typedef NS_ENUM(NSUInteger, NYSTKSignType) {
    NYSTKSignTypeYellow,        // 黄色签到框
    NYSTKSignTypeRed            // 红色签到框
};

typedef NS_ENUM(NSUInteger, NYSTKMessageColorType) {
    NYSTKMessageColorTypeBlue,  // 蓝色弹出框
    NYSTKMessageColorTypeRed    // 红色弹出框
};

typedef NS_ENUM(NSUInteger, NYSTKMessageType) {
    NYSTKMessageTypeSuccess,    // 成功
    NYSTKMessageTypeEror,       // 错误
    NYSTKMessageTypeWarning     // 警告
};

typedef NS_ENUM(NSUInteger, NYSTKAlertType) {
    NYSTKAlertTypeDefault,      // 默认
    NYSTKAlertTypeInvite        // 邀请卡
};

@interface NYSTKAlert : UIView

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

/*------------------------ TODO -----------------------------*/
#pragma mark - 提交成功提示弹框


@end

NS_ASSUME_NONNULL_END
