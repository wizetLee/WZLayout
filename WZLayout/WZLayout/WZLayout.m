//
//  WZLayout.m
//  Test
//
//  Created by liweizhao on 2018/6/25.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZLayout.h"


@interface WZLayout()

//记录每个section的纵向，每个item的横向的偏移值
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *>*XOffsetContainerForSection;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *>*YOffsetContainerForSection;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation WZLayout

- (instancetype)init
{
    self = [super init];
        _contentInset = UIEdgeInsetsZero;
        _rowsHeigthMap = [NSMutableDictionary dictionary];
        _columnWidthMap = [NSMutableDictionary dictionary];
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    _XOffsetContainerForSection = [NSMutableDictionary dictionary];
    _YOffsetContainerForSection = [NSMutableDictionary dictionary];
    
    [self calculate];

}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

/**
 获取rect内可见的cell的indexPath修改关联的ats
 
 @param rect 可见域
 @return 修改过的ats[]
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray <UICollectionViewLayoutAttributes *>*atsMArr = NSMutableArray.array;
 
//    CGRectGetMinX(rect);
//    CGRectGetMaxX(rect);
//    CGRectGetMinY(rect);
//    CGRectGetMaxY(rect);
    
    //算法需要修改
    NSUInteger rowCount = [self.collectionView numberOfSections];
    for (int i = 0; i < rowCount; i++) {    //可适度增加一些过滤以优化
        for (int j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            UICollectionViewLayoutAttributes *ats = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            if (CGRectIntersectsRect(ats.frame, rect)) {
                [atsMArr addObject:ats];
            }
        }
    }
    
    return atsMArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *ats = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSNumber *yNum = _YOffsetContainerForSection[@(indexPath.section)];
    NSNumber *xNum = _XOffsetContainerForSection[@(indexPath.row)];
    NSNumber *hNum = _rowsHeigthMap[@(indexPath.section)];
    NSNumber *wNum = _columnWidthMap[@(indexPath.row)];
    CGFloat x = xNum.floatValue;
    CGFloat y = yNum.floatValue;
    CGFloat w = wNum ? wNum.floatValue : _itemSize.width;
    CGFloat h = hNum ? hNum.floatValue : _itemSize.height;
    ats.frame = CGRectMake(x, y, w, h);
    
    return ats;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}


#pragma mark - Private

- (void)calculate {
    
    //section的数目 section下item的数目
    NSMutableArray <NSMutableArray <UICollectionViewLayoutAttributes *>*>*itemLayoutBuffer = NSMutableArray.array;
    NSMutableArray <NSNumber *>*itemCount = NSMutableArray.array;
    NSUInteger numberOfSections = 1;
    if ([self.collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        numberOfSections = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
    }
    
    CGFloat x = 0.0;
    CGFloat y = _contentInset.top;
    CGFloat width = _itemSize.width;
    CGFloat height = _itemSize.height;
    CGFloat tmpWidth = 0.0;
    CGFloat tmpHeight = 0.0;
    //section
    for (int section = 0; section < numberOfSections; section++) {
        NSUInteger numberOfItemsInSection = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        NSMutableArray *tmp = [NSMutableArray array];
        tmpHeight = height;
        NSNumber *row = _rowsHeigthMap[@(section)];//判断有无自定义的高度
        if (row) {
            tmpHeight = row.floatValue;
        }
        //row
        
        _YOffsetContainerForSection[@(section)] = @(y);                 //缓存
        x = _contentInset.left;//重置
        for (int index = 0; index < numberOfItemsInSection; index++) {
            _XOffsetContainerForSection[@(index)] = @(x);                 //缓存
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            
            UICollectionViewLayoutAttributes *ats = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            {//ats 设置
                //外部提供的size
                tmpWidth = width;
                
                NSNumber *column = _columnWidthMap[@(index)];//判断有无自定义的高度
                if (column) {
                    tmpWidth = column.floatValue;
                }
                ats.frame = CGRectMake(x, y, tmpWidth, tmpHeight);//ast
                x = x + (_minimumLineSpacing + tmpWidth);
            }
            
            [tmp addObject:ats];
        }
        
        y = y + (_minimumInteritemSpacing + tmpHeight);
        
        [itemLayoutBuffer addObject:tmp];
        [itemCount addObject:@(numberOfItemsInSection)];
    }
    
    _contentSize = CGSizeMake(x - _minimumLineSpacing + _contentInset.right
                              , y - _minimumInteritemSpacing + _contentInset.bottom);
}

@end
