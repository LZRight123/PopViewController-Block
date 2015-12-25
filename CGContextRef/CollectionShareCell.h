//
//  CollectionShareCell.h
//  OnlineShop
//
//  Created by yons on 15/10/29.
//  Copyright (c) 2015年 m. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kCollectionShareCell = @"CollectionShareCell";
@interface CollectionShareCell : UICollectionViewCell
@property (nonatomic,  weak) IBOutlet UILabel *titleLabel;

- (void) setColor:(UIColor*)color boradColor:(UIColor*)boradColor imageName:(NSString*)imageName title:(NSString*)title;
@end
