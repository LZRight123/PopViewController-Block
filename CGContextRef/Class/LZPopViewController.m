//
//  LZPopViewController.m
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "LZPopViewController.h"

@interface LZPopViewController ()

@end

@implementation LZPopViewController

- (void) setNeedBlur:(BOOL)needBlur {
    _needBlur = needBlur;
    if (needBlur && [UIDevice currentDevice].systemVersion.doubleValue>=8.0) {
        //=================毛玻璃======================
        //  创建需要的毛玻璃特效类型
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        //  毛玻璃view 视图
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //添加到要有毛玻璃特效的控件中 模糊的frame
        effectView.frame = self.view.bounds;
        [self.view addSubview:effectView];
        [self.view sendSubviewToBack:effectView];
        //设置模糊透明度
        effectView.alpha = .9f;
        //============================================
    }
}
- (void) showActionBlock:(void (^)(CGFloat, CGFloat, CGFloat))action{
    self.showAction = action;
}
- (void) dismissActionBlock:(void (^)(CGFloat, CGFloat, CGFloat))action{
    self.dismissAction = action;
}
- (void) show {
    [self showInView:[[UIApplication sharedApplication] keyWindow]];
}
- (void) showInView:(UIView *)view {
    [view addSubview:self.view];
}
- (void) showInViewController:(UIViewController*)controller{
    [self showInView:controller.view];
}
- (void) dismiss{
    [self.view removeFromSuperview];
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

#pragma mark - 动画
- (void) setupFadeInOutWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = duration;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    view.alpha = 1;
    [view.layer addAnimation:popAnimation forKey:nil];
}
- (void) setupBottomToTopWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CGFloat tx = 0;
    CGFloat ty = -view.bounds.size.height;
    [self setupAnimation2DWithView:view duration:duration tx:tx ty:ty];
}
- (void) setupTopToBottomWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CGFloat tx = 0;
    CGFloat ty = view.bounds.size.height;
    [self setupAnimation2DWithView:view duration:duration tx:tx ty:ty];
}
- (void) setupRightToLeftWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CGFloat tx = -view.bounds.size.width;
    CGFloat ty = 0;
    [self setupAnimation2DWithView:view duration:duration tx:tx ty:ty];
}
- (void) setupLeftToRightWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CGFloat tx = view.bounds.size.width;
    CGFloat ty = 0;
    [self setupAnimation2DWithView:view duration:duration tx:tx ty:ty];
}
- (void) setupAnimation2DWithView:(UIView*)view duration:(NSTimeInterval)duration tx:(CGFloat)tx ty:(CGFloat)ty {
    if (self.showAction) {
        self.showAction(duration,tx,ty);
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = CGAffineTransformMakeTranslation(tx,ty);
    } completion:nil];
}
- (void) setupDissmissWithSubViews:(NSArray<UIView*>*)views duration:(NSTimeInterval)duration{
    if (self.dismissAction) {
        self.dismissAction(duration,0,0);
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformMakeTranslation(0,0);
        }
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

@end
