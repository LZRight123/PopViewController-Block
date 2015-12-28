//
//  CustomTestViewController.m
//  CGContextRef
//
//  Created by 梁泽 on 15/12/19.
//  Copyright © 2015年 right. All rights reserved.
//

#import "CustomTestViewController.h"
#import "ShareView.h"
#import "CollectionShareCell.h"
#define kCancelBtnHeight 40
@interface CustomTestViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,weak) ShareView *bottomToTopView;
@property (nonatomic,weak)  UIView *fadeOutInView;
@property (nonatomic,weak)  UIView *rightToLeft;
@property (nonatomic,weak)  UIView *topToBottom;
@property (nonatomic,weak)  UIView *leftToRight;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
static CGFloat kAnimationDutation = 0.3f;
@implementation CustomTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupShareView];
    [self setupFadeOutInView];
    [self setupRightToLeftView];
    [self setupTopToBottom];
    [self setupLeftToRightView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupFadeInOutWithView:self.fadeOutInView duration:kAnimationDutation+1];
    [self setupBottomToTopWithView:self.bottomToTopView duration:kAnimationDutation];
    [self setupRightToLeftWithView:self.rightToLeft duration:kAnimationDutation];
    [self setupTopToBottomWithView:self.topToBottom duration:kAnimationDutation];
    [self setupLeftToRightWithView:self.leftToRight duration:kAnimationDutation];
}

- (void) dismiss {
    [self setupDissmissWithSubViews:@[self.bottomToTopView,self.rightToLeft,self.topToBottom,self.leftToRight] duration:kAnimationDutation];
}

// ======================= 从上到下视图 =================
- (void) setupTopToBottom{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -200, self.view.bounds.size.width,200)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    self.topToBottom = view;
}
// =======================================================
- (void) setupLeftToRightView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-160, 0, 160, self.view.bounds.size.height)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    self.leftToRight = view;
}
// ======================= 从右边冒出来视图 =================
- (void) setupRightToLeftView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, 150, self.view.bounds.size.height)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    self.rightToLeft = view;
}
// =======================================================
// ======================= 从下面冒出来视图==================
- (void) setupShareView {
    ShareView *customView = [ShareView create];
    customView.frame = CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width , 300);
    customView.backgroundColor = [UIColor grayColor];
    __weak typeof(self) weakSelf = self;
    customView.canceClick = ^{
        [weakSelf dismiss];
    };
    customView.showTitleClick = ^(NSString *title){
        if (weakSelf.showTitleClick) {
            weakSelf.showTitleClick(title);
        }
        [weakSelf dismiss];
    };
    
    [self.view addSubview:customView];
    self.bottomToTopView = customView;
}
// ======================================================
// ======================== 淡入淡出视图 ===================
- (UIView *) setupFadeOutInView {
    CGRect frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 280);
    UIView *background = [[UIView alloc]initWithFrame:frame];
    background.backgroundColor = [UIColor blueColor];
   
    //1... 顶部标题视图  先搞一个高为0.5的view上去
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 1)];
    titleView.backgroundColor = [UIColor whiteColor];
    [background addSubview:titleView];
    //2... 在底部设一个取消分享按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height-kCancelBtnHeight, frame.size.width, kCancelBtnHeight)];
    [cancelBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:cancelBtn];
    //3... 分割线
    UIView *footerLine = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMinY(cancelBtn.frame)-0.5, frame.size.width, 0.5)];
    footerLine.backgroundColor = [UIColor grayColor];
    [background addSubview:footerLine];
    
    //4... 集合视图
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titleView.frame), frame.size.width, frame.size.height-CGRectGetHeight(titleView.frame)-CGRectGetHeight(cancelBtn.frame)-CGRectGetHeight(footerLine.frame)) collectionViewLayout:flow];
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
//    [self.collectionView registerNib:[UINib nibWithNibName:kCollectionShareCell bundle:nil] forCellWithReuseIdentifier:kCollectionShareCell];
    flow.minimumInteritemSpacing = 15;
    flow.minimumLineSpacing =0;
    // 上 左 下 右
    flow.sectionInset = UIEdgeInsetsMake(5, 15, 10, 15);
    CGFloat collectW  = self.collectionView.frame.size.width;
    CGFloat collectH  = self.collectionView.frame.size.height;
    CGFloat width     = (collectW - 75)/4;
    CGFloat height    = (collectH - 20)/2;
    flow.itemSize     = CGSizeMake(width, height);
    
    [background addSubview:self.collectionView];
    
     [self.view addSubview:background];
    self.fadeOutInView = background;
    self.fadeOutInView.alpha = 0;
    return background ;
}
- (void) clickCancelBtn{
    [self dismiss];
}
// ======================== 淡入淡出视图 ===================


@end
