//
//  KGHomeLayout.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeLayout.h"

@implementation KGHomeLayout
- (void)prepareLayout  //invalidateLayout
{
    [super prepareLayout];
}
//2
- (CGSize)collectionViewContentSize
{
    if (!self.collectionView.superview) {
        return CGSizeZero;
    }
    NSUInteger  numOfSection=[self.collectionView numberOfSections];
    CGSize size = [super collectionViewContentSize];
    CGFloat height=0;
    for (NSInteger i=0;i<numOfSection ;i++) {
        height+=  [self sectionWidth:i];
    }
    size.height=height;
    return size;
}
//3  返回目标区域对应的Attributes 数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"___________%@",NSStringFromCGRect(rect));
    //获取对应rect中的展示indexpath ，生成attribu，笔者这里的需求不会存在大量数据，就偷懒了。
    NSMutableArray *attributeArray = [NSMutableArray new];
    
    for (int section=0; section<self.collectionView.numberOfSections; section++) {
        for (NSInteger item=0; item<[self.collectionView numberOfItemsInSection:section]; item++) {
            UICollectionViewLayoutAttributes *att= [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            [attributeArray addObject:att];
        }
    }
    
    for (int section=0; section<[self.collectionView numberOfSections]; section++) {
        UICollectionViewLayoutAttributes* attHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        [attributeArray addObject:attHeader];
    }
    return attributeArray;
}

//生成对应的item Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    NSInteger totoalColumn=[self numColumnOfSection:indexPath.section];
    NSInteger line=(indexPath.item)/(CGFloat)totoalColumn;
    NSInteger column= indexPath.item%totoalColumn;  //
    CGRect tempFrame=attributes.frame;
    tempFrame.origin.x=column*(self.itemSize.width) +[self sectionItemStarX:indexPath.section];
    tempFrame.origin.y=line*(self.itemSize.height)  +self.headerReferenceSize.height;
    attributes.frame=tempFrame;
    return attributes;
}
//生成对应的SupplementaryView Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *orgAttributes=  [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CGRect tempFrame=orgAttributes.frame;
        NSInteger section=orgAttributes.indexPath.section;
        CGFloat perx= [self sectionItemStarX:section];
        tempFrame.origin.x=perx;
        tempFrame.origin.y=0;
        tempFrame.size=self.headerReferenceSize;
        orgAttributes.frame=tempFrame;
    }
    return orgAttributes;
}


#pragma mrak tool method
//每个section宽
-(CGFloat)sectionWidth:(NSUInteger)section
{
    NSInteger column=  [self numColumnOfSection:section];
    CGFloat re=self.sectionInset.left+self.sectionInset.right+column*(self.itemSize.width+self.minimumLineSpacing);
    return re;
}

//根据视图的高度，计算section的 行列数
-(NSInteger)numColumnOfSection:(NSUInteger)section
{
    NSInteger numOfItmes=[self.collectionView numberOfItemsInSection:section];
    CGFloat viewHeight=self.collectionView.frame.size.height;
    NSInteger line=  viewHeight/self.itemSize.height;
    CGFloat fcolumn=numOfItmes/line;
    NSInteger  column= ceil(fcolumn);
    return column;
}
-(CGFloat)sectionItemStarX:(NSUInteger)section
{
    CGFloat x=self.sectionInset.left;//计算每个head.x
    for (NSInteger i=1;i<=section ;i++) {
        x+=  [self sectionWidth:i];
    }
    return x;
}
//
@end
