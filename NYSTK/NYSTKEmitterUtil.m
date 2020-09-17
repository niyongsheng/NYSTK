//
//  NYSTKEmitterUtil.m
//  NYSTK <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NYSTKEmitterUtil.h"
#import "NYSTKConst.h"
#import "NSBundle+NYSTK.h"

@implementation NYSTKEmitterUtil

/// 开启粒子效果
/// @param type 类型
/// @param view 作用域
/// @param times 持续时间
+ (void)showEmitterType:(NYSTKEmitterAnimationType)type onView:(UIView *)view durationTime:(float)times {
    switch (type) {
        case NYSTKEmitterAnimationTypeColourbar:
            [self caiDaiWithView:view durationTime:(float)times];
            break;
            
        case NYSTKEmitterAnimationTypeSnow:
            [self snowWithView:view durationTime:(float)times];
            break;
            
        case NYSTKEmitterAnimationTypeRain:
            [self rainWithView:view durationTime:(float)times];
            break;
            
        case NYSTKEmitterAnimationTypeFireworks:
            [self fireWithView:view durationTime:(float)times];
            break;
            
        default:
            break;
    }
}

/// 彩带
+ (void)caiDaiWithView:(UIView *)view durationTime:(float)times {
    // 创建粒子Layer
    CAEmitterLayer *colourBarEmitter = [CAEmitterLayer layer];
    // 例子发射位置
    colourBarEmitter.emitterPosition = CGPointMake(NYSTK_ScreenWidth/2,-30);
    colourBarEmitter.preservesDepth = YES;
    colourBarEmitter.lifetime = 1.5;
    
    // 发射源的尺寸大小
    colourBarEmitter.emitterSize = CGSizeMake(NYSTK_ScreenWidth*2, NYSTK_ScreenHeight);
    // 发射模式
    colourBarEmitter.emitterMode = kCAEmitterLayerOutline;
    // 发射源的形状
    colourBarEmitter.emitterShape = kCAEmitterLayerLine;
    
    NSMutableArray *cellArr=[[NSMutableArray alloc] init];
    for (int i=1; i<9; i++) {
        CAEmitterCell *colourBarflake = [CAEmitterCell emitterCell];
        colourBarflake.birthRate     = 10.0;
        colourBarflake.lifetime      = 4.0;
        colourBarflake.alphaSpeed    = -0.1;
        colourBarflake.alphaRange    = 0.2;
        colourBarflake.velocity      = 150;
        colourBarflake.velocityRange = 30;
        colourBarflake.yAcceleration = 100;
        colourBarflake.emissionRange = M_PI; // some variation in angle
        colourBarflake.spinRange     = M_PI; // slow spin
        colourBarflake.contents      = (id)[[NSBundle nystk_imageForKey:[NSString stringWithFormat:@"colourbar_%d",i]] CGImage];
        [cellArr addObject:colourBarflake];
    }
    colourBarEmitter.shadowOpacity = 1.0;
    colourBarEmitter.shadowRadius  = 0.0;
    colourBarEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    
    colourBarEmitter.emitterCells  = cellArr;
    [view.layer addSublayer:colourBarEmitter];
    
    // 延时关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(times * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        colourBarEmitter.birthRate = 0;
    });
}

/// 雪花
+ (void)snowWithView:(UIView *)view durationTime:(float)times {
    // 创建粒子Layer
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    // 是否开启三维空间模式
//     snowEmitter.preservesDepth = YES;
    // 发射器的深度，有时可能会产生立体效果
//     snowEmitter.emitterDepth = 2.0;
    // 粒子发射位置
    snowEmitter.emitterPosition = CGPointMake(NYSTK_ScreenWidth/2,-20);
    // 发射源的尺寸大小
    snowEmitter.emitterSize = view.bounds.size;
    // 发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    // 发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    // 创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    // 粒子的名字
    snowflake.name = @"snow";
    // 粒子参数的速度乘数因子
    snowflake.birthRate = 60.0;  // 每秒生成数量
    snowflake.lifetime = 60;     // 生存时间
    // 粒子速度
    snowflake.velocity = 50.0;
    // 粒子的速度范围
    snowflake.velocityRange = 40;
    // 粒子y方向的加速度分量
    snowflake.yAcceleration = 20;
    // 周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    // 子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[NSBundle nystk_imageForKey:@"snow"] CGImage];
    // 设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor whiteColor] CGColor];
    // 缩放范围
    snowflake.scaleRange = 0.3f;
    snowflake.scale = 0.15f;
    // 设置透明度变化范围
    
    //设置粒子透明变化速度 越小 越块
    //    snowflake.alphaSpeed = 0;
    //透明度范围
    //    snowflake.alphaRange = -100;
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 0.0);
    // 粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    // 添加粒子
    snowEmitter.emitterCells = @[snowflake];
    
    // 将粒子Layer添加进图层中
    [view.layer addSublayer:snowEmitter];
    
    // 延时关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(times * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        snowEmitter.birthRate = 0;
    });
}

/// 雨水
+ (void)rainWithView:(UIView *)view durationTime:(float)times {
    // 发射器
    CAEmitterLayer *rainEmitter =[CAEmitterLayer layer];
    
    rainEmitter.emitterShape    = kCAEmitterLayerLine;
    rainEmitter.emitterMode     = kCAEmitterLayerOutline;
    //    rainEmitter.emitterSize     = self.view.bounds.size;
    rainEmitter.emitterSize     = CGSizeMake(NYSTK_ScreenWidth*2, NYSTK_ScreenHeight);
    rainEmitter.renderMode      = kCAEmitterLayerAdditive;
    rainEmitter.emitterPosition = CGPointMake(0, -20);
    //水滴
    CAEmitterCell *rainflake    = [CAEmitterCell emitterCell];
    rainflake.birthRate         = 50;       // 每秒发出的数量
    
    //rainflake.speed             = 10;     // 速度
    rainflake.velocity          = 200;      // 加速度
    rainflake.velocityRange     = 75;       // 加速度范围
    rainflake.yAcceleration     = 500;      // 重力
    
    //    rainflake.emission = 0.3 * M_PI;
    //    rainflake.spin = 0.1 * M_PI;
    
    rainflake.emissionLatitude = 0.1 *M_PI;
    //    rainflake.emissionLongitude =  M_PI_2; // 方向，M_PI_2 右斜
    
    rainflake.contents          = (id)[NSBundle nystk_imageForKey:@"rain"].CGImage;
    rainflake.color             = [UIColor whiteColor].CGColor;
    rainflake.lifetime          = 3;        // 生命周期
    rainflake.scale             = 0.3;      // 缩放
    rainflake.scaleRange        = 0.2;
    
    //水花
    CAEmitterCell *rainSpark =[CAEmitterCell emitterCell];
    
    //    rainSpark.birthRate         = 1;
    //    rainSpark.velocity          = 0;
    //    //rainSpark.emissionRange     = M_PI;//180度
    //    //rainSpark.yAcceleration     = 40;
    //    rainSpark.scale             = 0.5;
    //    rainSpark.contents          = (id)[NSBundle nystk_imageForKey:@"snow"].CGImage;
    //    rainSpark.color=[UIColor whiteColor].CGColor;
    //    rainSpark.lifetime          =  0.3;
    
    //
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate             = 50;           // 炸开后产生40花
    spark.velocity              = 50;           // 速度
    spark.velocityRange         = 20;
    spark.emissionRange         = M_PI;         // 360 度
    spark.yAcceleration         = 40;           // 重力
    spark.lifetime              = 0.5;
    
    spark.contents              = (id) [[NSBundle nystk_imageForKey:@"snow"] CGImage];
    spark.scaleSpeed            = 0.2;
    spark.scale                 = 0.2;
    spark.color                 = [UIColor whiteColor].CGColor;
    spark.alphaSpeed            = - 0.25;
    spark.spin                  = 2* M_PI;
    spark.spinRange             = 2* M_PI;
    
    rainEmitter.emitterCells    = @[rainflake];
    rainflake.emitterCells      = @[rainSpark];
    rainSpark.emitterCells      = @[spark];
    
    [view.layer addSublayer:rainEmitter];
    
    // 延时关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(times * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        rainEmitter.birthRate = 0;
    });
}

/// 烟火
+ (void)fireWithView:(UIView *)view durationTime:(float)times {
    // cell产生在底部,向上移动
    CAEmitterLayer *fireworkdEmitter =[CAEmitterLayer layer];
    CGRect viewBounds = view.layer.bounds;
    
    fireworkdEmitter.emitterPosition =CGPointMake(viewBounds.size.width/2, viewBounds.size.height);
    fireworkdEmitter.emitterMode = kCAEmitterLayerOutline;
    fireworkdEmitter.emitterShape = kCAEmitterLayerLine;
    fireworkdEmitter.renderMode = kCAEmitterLayerAdditive;
    fireworkdEmitter.seed = (arc4random()%100)+1;
    
    // 创建火箭cell
    CAEmitterCell *rocket   = [CAEmitterCell emitterCell];
    rocket.birthRate        = 1;
    rocket.emissionRange    = 0.25 *M_PI;
    rocket.velocity         = 300;
    rocket.velocityRange    = 75;
    rocket.lifetime         = 1.02;
    
    rocket.contents         = (id)[NSBundle nystk_imageForKey:@"fireworks"].CGImage;
    rocket.scale            = 0.5;
    rocket.scaleRange       = 0.5;
    rocket.color            = [UIColor redColor].CGColor;
    rocket.greenRange       = 1.0;
    rocket.redRange         = 1.0;
    rocket.blueRange        = 1.0;
    rocket.spinRange        = M_PI;
    
    // 破裂对象不能被看到,但会产生火花
    // 这里我们改变颜色,因为火花继承它的值
    CAEmitterCell *fireCell =[CAEmitterCell emitterCell];
    
    fireCell.birthRate      = 1;
    fireCell.velocity       = 0;
    fireCell.scale          = 1;
    fireCell.redSpeed       =- 1.5;
    fireCell.blueSpeed      =+ 1.5;
    fireCell.greenSpeed     =+ 1.5;
    fireCell.lifetime       = 0.34;
    
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate         = 400;          // 炸开后产生400个小烟花
    spark.velocity          = 125;          // 速度
    spark.emissionRange     = 2* M_PI;      // 360 度
    spark.yAcceleration     = 40;           // 重力
    spark.lifetime          = 3;
    
    spark.contents          = (id) [[NSBundle nystk_imageForKey:@"snow"] CGImage];
    spark.scaleSpeed        =- 0.2;
    
    spark.greenSpeed        =- 0.1;
    spark.redSpeed          =+ 0.1;
    spark.blueSpeed         =- 0.1;
    spark.alphaSpeed        =- 0.25;
    
    spark.spin              = 2* M_PI;
    spark.spinRange         = 2* M_PI;
    
    fireworkdEmitter.emitterCells = [NSArray arrayWithObject:rocket];
    rocket.emitterCells           = [NSArray arrayWithObject:fireCell];
    fireCell.emitterCells         = [NSArray arrayWithObject:spark];
    
    [view.layer addSublayer:fireworkdEmitter];
    
    // 延时关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(times * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        fireworkdEmitter.birthRate = 0;
    });
}

@end
