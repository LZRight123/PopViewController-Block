//
//  CustomShareVC.m
//  CGContextRef
//
//  Created by Right on 15/12/28.
//  Copyright © 2015年 right. All rights reserved.
//

#import "CustomShareVC.h"
#import "CollectionShareCell.h"
@interface CustomShareVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak  , nonatomic) UIView *shareView;
@property (weak  , nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *platformTypes;

@property (copy  , nonatomic) NSString *shareURL;
@property (copy  , nonatomic) NSString *shareTitle;
@end

#define kCancelBtnHeight 30
#define kCustomShareRGB(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]
@implementation CustomShareVC
- (void) setupShareUrl:(NSString *)url title:(NSString *)title{
    _shareURL = url;
    _shareTitle = title;
}
- (NSMutableArray *) platformTypes {
    if (!_platformTypes) {
        _platformTypes = @[].mutableCopy;
        
        PlatformMode *wechat        = [[PlatformMode alloc]initWithColor:kCustomShareRGB(69, 178, 61) title:@"微信好友" imageName:@"share-weixing1-icon" platform:LZSharePlatformTypeWechat];
        
        PlatformMode *wechat2       = [[PlatformMode alloc]initWithColor:[UIColor whiteColor] title:@"朋友圈" imageName:@"share-weixing2-icon" platform:LZSharePlatformTypeWechatFriend];
        wechat2.boradColor          = kCustomShareRGB(153, 153, 153);
        
        PlatformMode *qq            = [[PlatformMode alloc]initWithColor:kCustomShareRGB(88, 206, 255) title:@"QQ" imageName:@"share-qq-icon" platform:LZSharePlatformTypeQQ];
        
        PlatformMode *qqZone        = [[PlatformMode alloc]initWithColor:kCustomShareRGB(255, 196, 72) title:@"QQ空间" imageName:@"share-qzone-icon" platform:LZSharePlatformTypeQQZone];
        
        PlatformMode *sinaWebo      = [[PlatformMode alloc]initWithColor:kCustomShareRGB(255, 97, 86) title:@"新浪微博" imageName:@"share-sinaweibo-icon" platform:LZSharePlatformTypeSinaWeibo];
        
        PlatformMode *tenencenWeibo = [[PlatformMode alloc]initWithColor:kCustomShareRGB(60, 162, 234) title:@"腾讯微博" imageName:@"share-txweibo-icon" platform:LZSharePlatformTypeTencentWeibo];
        
        PlatformMode *email         = [[PlatformMode alloc]initWithColor:kCustomShareRGB(74,151,255) title:@"邮箱" imageName:@"share-mail-icon" platform:LZSharePlatformTypeEmail];
        
        PlatformMode *message       = [[PlatformMode alloc]initWithColor:kCustomShareRGB(2,196,1) title:@"短信" imageName:@"share-message-icon" platform:LZSharePlatformTypeMessage];
        
        [_platformTypes addObjectsFromArray:@[wechat,wechat2,qq,qqZone,sinaWebo,tenencenWeibo,email,message]];
    }
    return _platformTypes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithWhite:0 alpha:0.5];
    self.needBlur = YES;
    [self setupShareView];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupBottomToTopWithView:self.shareView duration:0.3];
}
- (void) dismiss {
    [self setupDissmissWithSubViews:@[self.shareView] duration:0.3];
}
- (void) setupShareView {
    UIView *shareView = [[UIView alloc]init];
    [self.view addSubview:_shareView = shareView];
    shareView.translatesAutoresizingMaskIntoConstraints = NO;
    shareView.backgroundColor = [UIColor whiteColor];
    
    NSArray *constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shareView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(shareView)];
    [self.view addConstraints:constraint];
    [NSLayoutConstraint constraintWithItem:shareView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:shareView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:280].active = YES;
    
    //1..底部按钮
    UIButton *cancelBtn = [[UIButton alloc]init];
    [shareView addSubview:cancelBtn];
    cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[self cancelBtnColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

    constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancelBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cancelBtn)];
    [shareView addConstraints:constraint];
    
    //2..绘制分割线
    UIView *line = [[UIView alloc]init];
    [shareView addSubview:line];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = [self lineColor];

    constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)];
    [shareView addConstraints:constraint];
    
    //3..collectionView
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [shareView addSubview:_collectionView = collection];
    constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collection]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(collection)];
    [shareView addConstraints:constraint];
    
    collection.translatesAutoresizingMaskIntoConstraints = NO;
    constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collection][line(==0.5)][cancelBtn(==40)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(collection,line,cancelBtn)];
    [shareView addConstraints:constraint];
    
    [self setupCollectionView];
}
- (void) setupCollectionView {
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate   = self;
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
    [_collectionView registerNib:[UINib nibWithNibName:[CollectionShareCell kind] bundle:nil] forCellWithReuseIdentifier:[CollectionShareCell kind]];
    flow.minimumInteritemSpacing = 15;
    flow.minimumLineSpacing =0;
    // 上 左 下 右
    flow.sectionInset = UIEdgeInsetsMake(5, 15, 10, 15);
}

- (UIColor *) cancelBtnColor{
    return [UIColor colorWithRed:85/255.0 green:176/255.0 blue:211/255.0 alpha:1];
}
- (UIColor *) lineColor{
    return [UIColor colorWithRed:212/255.0 green:213/255.0 blue:214/255.0 alpha:1];
}
#pragma mark - UICollecitonViewDataSource And Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectW  = collectionView.frame.size.width;
    CGFloat collectH  = collectionView.frame.size.height;
    CGFloat width     = (collectW - 75)/4;
    CGFloat height    = (collectH - 20)/2;
    return CGSizeMake(width, height);
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    CollectionShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CollectionShareCell kind] forIndexPath:indexPath];
    PlatformMode *mode = self.platformTypes[indexPath.item];
    
    [cell setColor:mode.color boradColor:mode.boradColor imageName:mode.imageName title:mode.title];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    if ([self.delegate respondsToSelector:@selector(customShareVC:didSelectPlatform:)]) {
        [self.delegate customShareVC:self didSelectPlatform:[(PlatformMode*)self.platformTypes[item] platformType]];
    }
    NSLog(@"%@--%@",self.shareURL,self.shareTitle);
}
@end







@implementation PlatformMode
- (instancetype) initWithColor:(UIColor*)color title:(NSString*)title imageName:(NSString*)imageName platform:(LZSharePlatformType)type{
    if (self = [super init]) {
        _color     = color;
        _title     = title;
        _imageName = imageName;
        _platformType = type;
    }
    return self;
}

@end
