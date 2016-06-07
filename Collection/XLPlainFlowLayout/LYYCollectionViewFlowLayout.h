//
//  LYYCollectionViewFlowLayout.h
//  NBBSTest
//
//  Created by liuyingying@neu on 16/5/13.
//  Copyright © 2016年 liuyingying@neu. All rights reserved.
//


/**
 *  根据双瀑布流的layout修改，加入SectionHeaderView
 */


#import <UIKit/UIKit.h>

@protocol LYYCollectionFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LYYCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 *  段头frame
 */
@property (nonatomic, strong) NSMutableDictionary *framesForHeaderSection;

/**
 *  headerHeight
 */
@property (assign,nonatomic)CGFloat headerHeight;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) id<LYYCollectionFlowLayoutDelegate>delegate;
@property (nonatomic, assign) CGFloat maxHeight;

@end
