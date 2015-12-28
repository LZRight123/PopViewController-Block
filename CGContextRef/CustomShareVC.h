//
//  CustomShareVC.h
//  CGContextRef
//
//  Created by Right on 15/12/28.
//  Copyright © 2015年 right. All rights reserved.
//

#import "LZPopViewController.h"
typedef NS_ENUM(NSUInteger, LZSharePlatformType) {
    /// 微信好友
    LZSharePlatformTypeWechat = 0,
    /// 微信朋友圈
    LZSharePlatformTypeWechatFriend,
    /// QQ好友
    LZSharePlatformTypeQQ,
    /// QQ空间
    LZSharePlatformTypeQQZone,
    /// sina微博
    LZSharePlatformTypeSinaWeibo,
    /// 腾讯微博
    LZSharePlatformTypeTencentWeibo,
    /// 发邮件
    LZSharePlatformTypeEmail,
    /// 发信息
    LZSharePlatformTypeMessage,
    LZSharePlatformTypeXXXXX,
};
@class CustomShareVC;
@protocol CustomShareVcDelegate <NSObject>

@optional
/// 点击 分享平台
- (void) customShareVC:(CustomShareVC *)VC didSelectPlatform:(LZSharePlatformType)platformType;

@end

@interface CustomShareVC : LZPopViewController
@property (weak  , nonatomic) id<CustomShareVcDelegate> delegate;
- (void) setupShareUrl:(NSString*)url title:(NSString*)title;
@end
















@interface PlatformMode : NSObject
/// 背景色
@property (nonatomic,strong) UIColor *color;
/// 标题
@property (nonatomic,copy)  NSString *title;
/// 图片名
@property (nonatomic,copy)  NSString *imageName;
/// 边框色
@property (nonatomic,strong) UIColor *boradColor;
/// 平台类型
@property (assign, nonatomic) LZSharePlatformType platformType;
- (instancetype) initWithColor:(UIColor*)color title:(NSString*)title imageName:(NSString*)imageName platform:(LZSharePlatformType)type;
@end
