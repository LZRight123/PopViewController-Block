//
//  ViewController.m
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "ViewController.h"
#import "SBView.h"
#import "CustomTestViewController.h"
@interface ViewController ()
@property (nonatomic,strong) CustomTestViewController *pop;
@property (weak, nonatomic) IBOutlet SBView *sbView;

@end

@implementation ViewController

- (CustomTestViewController*)pop {
    if (!_pop) {
        _pop = [CustomTestViewController new];
        __weak typeof(self) weakSelf = self;
        _pop.showTitleClick = ^(NSString *title){
            weakSelf.sbView.title = title;
        };
                
        [_pop showActionBlock:^(CGFloat duration, CGFloat tx, CGFloat ty) {
//            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                weakSelf.view.transform = CGAffineTransformMakeTranslation(tx,ty);
//            } completion:nil];
        }];
        [_pop dismissActionBlock:^(CGFloat duration, CGFloat tx, CGFloat ty) {
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                weakSelf.view.transform = CGAffineTransformMakeTranslation(tx,ty);
            } completion:nil];
        }];
        _pop.clickCollectionCell = ^(NSInteger index){
            weakSelf.sbView.title = [NSString stringWithFormat:@"严明俊是SB+%ld",index];
        };
    }
    return _pop;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sbView.title = @"严明俊";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.pop.text = self.sbView.title;
    NSLog(@"%@",self.pop.text);
    [self.pop show];
    
}
@end
