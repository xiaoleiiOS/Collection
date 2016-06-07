//
//  ViewController.m
//  Collection
//
//  Created by 王晓磊 on 16/5/4.
//  Copyright © 2016年 王晓磊. All rights reserved.
//

#import "ViewController.h"
#import "ReusableView.h"
#import "LYYCollectionViewFlowLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LYYCollectionFlowLayoutDelegate>
{
    UILabel *_label;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *headerID = @"headerID";

@implementation ViewController

#pragma mark - life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"collectionView仿tableView悬浮";
    
    LYYCollectionViewFlowLayout * layout = [[LYYCollectionViewFlowLayout alloc]init];
    layout.delegate = self;
    layout.headerHeight = 130;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    //向上滑，自定义一个悬浮窗，和SectionHeader保持一致
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"悬浮View";
    _label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_label];
    _label.hidden = YES;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
    return header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //返回网络数据上每个item的宽和高
    return CGSizeMake(375 / 2 - 10, arc4random() % 201 + 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 130);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y >= 86) {
        
        _label.hidden = NO;
    }else{
        _label.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
