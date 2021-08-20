//
//  NYSAlert.h
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//  Version:1.0.0

#import <UIKit/UIKit.h>
#import "NYSTKEmitterUtil.h"

typedef NS_ENUM(NSUInteger, NYSTKThemeModel) {
    NYSTKThemeModelLight,       // 浅色模式
    NYSTKThemeModelDark,        // 暗黑模式
    NYSTKThemeModelAuto API_AVAILABLE(ios(13.0))
};

typedef NS_ENUM(NSUInteger, NYSTKAnimationType) {
    NYSTKAnimationTypeNone,     // 无状态动画
    NYSTKAnimationTypeImage,    // 自定义图片
    NYSTKAnimationTypeNative    // 系统小菊花
};

typedef NS_ENUM(NSUInteger, NYSTKComeInDirection) {
    NYSTKComeInDirectionDefault,// 中心进入
    NYSTKComeInDirectionUp,     // 顶部进入
    NYSTKComeInDirectionDown,   // 底部进入
    NYSTKComeInDirectionLeft,   // 左侧进入
    NYSTKComeInDirectionRight   // 右侧进入
};

typedef NS_ENUM(NSUInteger, NYSTKColorfulToastType) {
    NYSTKColorfulToastTypeGreenBook,     // 绿色书本
    NYSTKColorfulToastTypePurpleFlower,  // 紫色花朵
    NYSTKColorfulToastTypeBlueHand,      // 蓝色手指
    NYSTKColorfulToastTypeBlueFlower,    // 蓝色花朵
    NYSTKColorfulToastTypeYellowCat,     // 黄色小猫
    NYSTKColorfulToastTypeGreenStar,     // 绿色星星
    NYSTKColorfulToastTypeCustom         // 自定义图片
};

typedef NS_ENUM(NSUInteger, NYSTKMessageType) {
    NYSTKMessageTypeDefault,    // 默认
    NYSTKMessageTypeSuccess,    // 成功
    NYSTKMessageTypeError,      // 错误
    NYSTKMessageTypeWarning     // 警告
};

/// 消失回调block
typedef void (^NYSTKAlertDismissCompletion)(void);

@interface NYSTKAlert : UIView

#pragma mark - Toast弹框

/// Toast弹框
/// @param message 内容信息
+ (void)showToastWithMessage:(NSString *)message;

/// Toast弹框
/// @param message 内容信息
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message themeModel:(NYSTKThemeModel)theme;

/// Toast弹框
/// @param message 内容信息
/// @param imageName 自定义图片名
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName themeModel:(NYSTKThemeModel)theme;

/// Toas成功/失败/警告弹框
/// @param message 内容信息
/// @param messageType 默认/成功/失败/警告
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message messageType:(NYSTKMessageType)messageType themeModel:(NYSTKThemeModel)theme;

/// Toast动画弹框
/// @param message 内容信息
/// @param animationType 动画类型
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message
               animationType:(NYSTKAnimationType)animationType
                  themeModel:(NYSTKThemeModel)theme;

/// Toast动画弹框
/// @param message 内容信息
/// @param animationType 动画类型
/// @param view 作用域
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message
               animationType:(NYSTKAnimationType)animationType
                        view:(UIView *)view
                  themeModel:(NYSTKThemeModel)theme;

/// Toast弹框
/// @param message 内容信息
/// @param imageName 自定义图片名
/// @param messageType 默认/成功/失败/警告
/// @param animationType 动画类型
/// @param view 作用域
/// @param theme 主题
+ (void)showToastWithMessage:(NSString *)message
                       image:(NSString *)imageName
                 messageType:(NYSTKMessageType)messageType
               animationType:(NYSTKAnimationType)animationType
                        view:(UIView *)view
                  themeModel:(NYSTKThemeModel)theme;


#pragma mark - 图片弹框条

/// 图片弹框条
/// @param message 内容信息
+ (void)showImageBarWithMessage:(NSString *)message;

/// 图片富文本弹框条
/// @param attributedMessage 富文本信息
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage;

/// 图片带回调弹框条
/// @param message 内容信息
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithMessage:(NSString *)message
                         onView:(UIView *)view
        infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock;

/// 图片富文本带回调弹框条
/// @param attributedMessage 富文本信息
/// @param view 作用域
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageBarWithAttributedMessage:(NSAttributedString *)attributedMessage
                                   onView:(UIView *)view
                    infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock;

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
        closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;


#pragma mark - 图片\签到弹框

/// 图片签到弹框
/// @param messageText 富文本信息
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock;

/// 图片弹框
/// @param messageText 富文本信息
/// @param imageURL 自定义弹框背景图url
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
                         imageURL:(NSURL *)imageURL
infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock;

/// 图片弹框
/// @param messageText 富文本信息
/// @param imageName 自定义弹框背景图
/// @param infoButtonClickedBlock 点击事件回调
+ (void)showImageAlertWithMessage:(NSAttributedString *)messageText
                            image:(NSString *)imageName
infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock;


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
closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;


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
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
                 messageType:(NYSTKMessageType)messageType
                 emitterType:(NYSTKEmitterAnimationType)emitter
                  themeModel:(NYSTKThemeModel)theme
      infoButtonClickedBlock:(void(^)(void))infoButtonClickedBlock
     closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;

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
   closeButtonClickedBlock:(void(^)(void))closeButtonClickedBlock;


#pragma mark - 自定义View弹框

/// 自定义View弹框
/// @param customView 自定义view
/// @param view 作用域
/// @param emitter 粒子效果
+ (void)showCustomView:(UIView *)customView
                onView:(UIView *)view
           emitterType:(NYSTKEmitterAnimationType)emitter;

#pragma mark - 关闭弹框

/// 关闭弹框
+ (void)dismiss;

/// 关闭弹框
/// @param completion 关闭后回调
+ (void)dismissWithCompletion:(nullable NYSTKAlertDismissCompletion)completion;

/// 关闭弹框
/// @param delay 延时
+ (void)dismissWithDelay:(NSTimeInterval)delay;

/// 关闭弹框
/// @param delay 延时
/// @param completion 关闭后回调
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable NYSTKAlertDismissCompletion)completion;

#pragma mark - 重置默认值
+ (void)clearDefaultValue;

@end
