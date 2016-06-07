//
//  ReusableView.m
//  PlainLayout
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import "ReusableView.h"

@implementation ReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, frame.size.height - 44) collectionViewLayout:flowLayout];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        //要悬浮的地方
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"悬浮View";
        label.backgroundColor = [UIColor greenColor];
        [self addSubview:label];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    _text = text;
    
    ((UILabel *)self.subviews[0]).text = text;
}

#pragma mark - collectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 30;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //Collection cell 设定布局
    CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat height = self.frame.size.height - 44;
    return CGSizeMake(width, height);
}

@end
