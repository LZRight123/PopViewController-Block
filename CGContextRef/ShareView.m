//
//  ShareView.m
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
+ (instancetype) create {
    return [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:nil options:nil].lastObject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)clickCancelBtn:(UIButton *)sender {
    if (self.canceClick) {
        self.canceClick();
    }
}
- (IBAction)clickTitleBtn:(UIButton *)sender {
    if (self.showTitleClick) {
        self.showTitleClick(sender.currentTitle);
    }
}

@end
