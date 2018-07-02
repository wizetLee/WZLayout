//
//  WZExcelLayout.m
//  Test
//
//  Created by liweizhao on 2018/6/29.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZExcelLayout.h"
#import "WZDiffuseLayout+Private.h"

@interface WZExcelLayout()


@end

@implementation WZExcelLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hoverOverTheTop = 1;
        _hoverOverTheLeft = 1;
   
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray <UICollectionViewLayoutAttributes *>*atsMArr = NSMutableArray.array;
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat offsetY = self.collectionView.contentOffset.y;
    for (UICollectionViewLayoutAttributes *ats in self.attributesMixture) {
        if (self.dataDirection == WZExcelLayoutDataDirection_Horizontal) {
           if (ats.indexPath.row < _hoverOverTheLeft
               || ats.indexPath.section < _hoverOverTheTop
               ) {
               if (ats.indexPath.section < _hoverOverTheTop && ats.indexPath.row < _hoverOverTheLeft) {
                   
                   ats.frame = CGRectMake(offsetX + [self.XOffsetContainerForSection[@(ats.indexPath.row)] floatValue]
                                          , offsetY + [self.YOffsetContainerForSection[@(ats.indexPath.section)] floatValue]
                                          , ats.frame.size.width, ats.frame.size.height);
                   ats.zIndex = 3;
               } else if (ats.indexPath.section < _hoverOverTheTop) {
                   ats.frame = CGRectMake(ats.frame.origin.x
                                          , offsetY + [self.YOffsetContainerForSection[@(ats.indexPath.section)] floatValue]
                                          , ats.frame.size.width
                                          , ats.frame.size.height);
                   ats.zIndex = 1;
               } else if (ats.indexPath.row < _hoverOverTheLeft) {
                   ats.frame = CGRectMake(offsetX + [self.XOffsetContainerForSection[@(ats.indexPath.row)] floatValue]
                                          , ats.frame.origin.y
                                          , ats.frame.size.width
                                          , ats.frame.size.height);
                   ats.zIndex = 1;
               }
           }
           [atsMArr addObject:ats];
        } else if (self.dataDirection == WZExcelLayoutDataDirection_Vertical) {
            if (ats.indexPath.row < _hoverOverTheTop
               || ats.indexPath.section < _hoverOverTheLeft
               ) {
                if (ats.indexPath.row < _hoverOverTheTop && ats.indexPath.section < _hoverOverTheLeft) {
                   
                   ats.frame = CGRectMake(offsetX + [self.XOffsetContainerForSection[@(ats.indexPath.section)] floatValue]
                                          , offsetY + [self.YOffsetContainerForSection[@(ats.indexPath.row)] floatValue]
                                          , ats.frame.size.width, ats.frame.size.height);
                   ats.zIndex = 3;
                }  else if (ats.indexPath.section < _hoverOverTheLeft) {
                   ats.frame = CGRectMake(offsetX + [self.XOffsetContainerForSection[@(ats.indexPath.section)] floatValue]
                                          , ats.frame.origin.y
                                          , ats.frame.size.width
                                          , ats.frame.size.height);
                   ats.zIndex = 1;
                } else if (ats.indexPath.row < _hoverOverTheTop) {
                   ats.frame = CGRectMake(ats.frame.origin.x
                                          , offsetY + [self.YOffsetContainerForSection[@(ats.indexPath.row)] floatValue]
                                          , ats.frame.size.width
                                          , ats.frame.size.height);
                   ats.zIndex = 1;
                }
            }
            [atsMArr addObject:ats];
        } else if (CGRectIntersectsRect(rect, ats.frame)) {
            [atsMArr addObject:ats];
        }
    }
    
    return atsMArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

#pragma mark - Accessor
- (void)setContentInset:(UIEdgeInsets)contentInset {}


@end
