//
//  CustomTestViewController.h
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "LZPopViewController.h"

@interface CustomTestViewController : LZPopViewController
@property (nonatomic,copy) void(^showTitleClick)(NSString *title);
@property (nonatomic,copy)  void(^clickCollectionCell)(NSInteger index);
@property (nonatomic,copy)  NSString *text;

@end
