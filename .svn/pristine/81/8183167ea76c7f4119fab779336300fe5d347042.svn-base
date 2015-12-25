//
//  SBView.m
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "SBView.h"

@implementation SBView

- (void) setTitle:(NSString *)title{
    _title = title;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_title];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:[UIColor yellowColor]} range:NSMakeRange(0, str.length-2)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:NSMakeRange(str.length-2, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length-2, 2)];
    [str drawAtPoint:CGPointMake((self.frame.size.width-str.size.width)*0.5, self.frame.size.height/2)];

}


@end
