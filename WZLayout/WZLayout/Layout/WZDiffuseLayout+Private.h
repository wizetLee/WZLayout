//
//  WZDiffuseLayout+Private.h
//  Test
//
//  Created by liweizhao on 2018/6/29.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZDiffuseLayout.h"

@interface WZDiffuseLayout()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>*attributesMixture;//所有的ats的集合
@property (nonatomic, strong) NSMutableArray <NSMutableArray <UICollectionViewLayoutAttributes *>*>*itemLayoutBuffer;//cell的ats

//记录横向、纵向的偏移值
//记录每个section的纵向，每个item的横向的偏移值
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *>*XOffsetContainerForSection;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *>*YOffsetContainerForSection;

@property (nonatomic, assign) NSUInteger rowCount;
@property (nonatomic, assign) NSUInteger colomnCount;
@property (nonatomic, assign) CGSize contentSize;

@end
