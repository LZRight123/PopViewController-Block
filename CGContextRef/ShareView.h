//
//  ShareView.h
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property (nonatomic,copy) void(^canceClick)(void);
@property (nonatomic,copy) void(^showTitleClick)(NSString *title);





+ (instancetype) create ;
@end
