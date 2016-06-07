//
//  LYYCollectionViewFlowLayout.m
//  NBBSTest
//
//  Created by liuyingying@neu on 16/5/13.
//  Copyright © 2016年 liuyingying@neu. All rights reserved.
//

#import "LYYCollectionViewFlowLayout.h"
#define LCollectionViewWidth self.collectionView.frame.size.width
static const CGFloat LDefaultColumnMargin = 10;
static const UIEdgeInsets LDefaultInsets = {10,10,10,10};
static const int LDefaultColumsCount = 2;
@implementation LYYCollectionViewFlowLayout

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(NSMutableDictionary *)framesForHeaderSection{
    if(!_framesForHeaderSection) _framesForHeaderSection = [NSMutableDictionary new];
    
    return _framesForHeaderSection;
}


-(void)prepareLayout{
    [super prepareLayout];
    self.maxHeight = 0;
    CGFloat leftY = 10;
    CGFloat rightY = 10;
    CGFloat maxLeftY = 0;
    CGFloat maxRightY = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        //水平方向的总间距
        CGFloat xMargin = LDefaultInsets.left + LDefaultInsets.right +(LDefaultColumsCount -1) * LDefaultColumnMargin;
        //宽度
        CGFloat width = (LCollectionViewWidth - xMargin) / LDefaultColumsCount;
        //高度
        CGFloat height = itemSize.height;
        //左边
        if (i % 2 == 0) {
            attributes.frame = CGRectMake(LDefaultInsets.left, leftY + self.headerHeight, width, height);
            maxLeftY = leftY + itemSize.height;
            leftY += itemSize.height + LDefaultColumnMargin;
        }else{
            attributes.frame = CGRectMake(LDefaultInsets.left + width + LDefaultColumnMargin, rightY + self.headerHeight, width, height);
            maxRightY = rightY + itemSize.height;
            rightY += itemSize.height + LDefaultColumnMargin;
        }
        self.maxHeight = MAX(self.maxHeight, CGRectGetMaxY(attributes.frame));
        [self.array addObject:attributes];
    }
    
    CGRect headerFrame1 = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,130);
    
    self.framesForHeaderSection[@(0)] = [NSValue valueWithCGRect:headerFrame1];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *rectArray = [NSMutableArray array];
    for (int i = 0; i < [self.array count]; i++) {
        UICollectionViewLayoutAttributes *att = [self.array objectAtIndex:i];
        if (CGRectIntersectsRect(rect, att.frame)) {
            [rectArray addObject:att];
        }
    }
    
    for (int i= 0; i<[self.collectionView numberOfSections]; i++) {
        
        NSIndexPath* indexPaths = [NSIndexPath indexPathForItem:i inSection:i];
        
        //section header
        UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind: UICollectionElementKindSectionHeader atIndexPath:indexPaths];
        
        if (!CGSizeEqualToSize(headerAttributes.frame.size, CGSizeZero) && CGRectIntersectsRect(headerAttributes.frame, rect)){
            [rectArray addObject:headerAttributes];
        }
    }
    
    return rectArray;
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        attributes.frame = [self.framesForHeaderSection[@(indexPath.section)] CGRectValue];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        attributes.frame = [self.framesForFooterSection[@(indexPath.section)] CGRectValue];
    }
    
    // If there is no header or footer, we need to return nil to prevent a crash from UICollectionView private methods.
    if(CGRectIsEmpty(attributes.frame)) {
        attributes = nil;
    }
    
    return attributes;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.maxHeight);
}

@end
