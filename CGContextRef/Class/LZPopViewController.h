//
//  LZPopViewController.h
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZPopViewController : UIViewController
@property (nonatomic,copy) void(^showAction)(CGFloat duration,CGFloat tx,CGFloat ty);
@property (nonatomic,copy) void(^dismissAction)(CGFloat duration,CGFloat tx,CGFloat ty);
@property (nonatomic,assign) BOOL needBlur;


- (void) show;
- (void) showInView:(UIView *)view;
- (void) showInViewController:(UIViewController*)controller;
- (void) dismiss;

- (void) showActionBlock:(void(^)(CGFloat duration,CGFloat tx,CGFloat ty))action;
- (void) dismissActionBlock:(void(^)(CGFloat duration,CGFloat tx,CGFloat ty))action;

- (void) setupFadeInOutWithView:(UIView*)view duration:(NSTimeInterval)duration;
- (void) setupBottomToTopWithView:(UIView*)view duration:(NSTimeInterval)duration;
- (void) setupTopToBottomWithView:(UIView*)view duration:(NSTimeInterval)duration;
- (void) setupRightToLeftWithView:(UIView*)view duration:(NSTimeInterval)duration;
- (void) setupLeftToRightWithView:(UIView*)view duration:(NSTimeInterval)duration;

/// 自定义
- (void) setupAnimation2DWithView:(UIView*)view duration:(NSTimeInterval)duration tx:(CGFloat)tx ty:(CGFloat)ty;
- (void) setupDissmissWithSubViews:(NSArray<UIView*>*)views duration:(NSTimeInterval)duration;
@end
