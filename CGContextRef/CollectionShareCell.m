//
//  CollectionShareCell.m
//  OnlineShop
//
//  Created by yons on 15/10/29.
//  Copyright (c) 2015年 m. All rights reserved.
//

#import "CollectionShareCell.h"

#define kPaddingWithTitle 5
#define kPaddingWithCell   10
static NSString *kCollectionShareCell = @"CollectionShareCell";
@interface CollectionShareCell ()
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@end
@implementation CollectionShareCell
+ (NSString *) kind {
    return kCollectionShareCell;
}

- (void) setColor:(UIColor*)color boradColor:(UIColor*)boradColor imageName:(NSString*)imageName title:(NSString*)title{
    CGFloat width  = (([UIScreen mainScreen].bounds.size.width - 75)/4 - 20);
    self.iconBtn.layer.cornerRadius = width * 0.5;
    self.iconBtn.backgroundColor = color;
    if (boradColor) {
        self.iconBtn.layer.borderColor = boradColor.CGColor;
        self.iconBtn.layer.borderWidth = 1;
    }else{
        self.iconBtn.layer.borderColor = [UIColor clearColor].CGColor;
    }
    [self.iconBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.titleLabel.text = title;
    
}

@end
