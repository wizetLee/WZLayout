    //
//  WZDiffuseLayout.m
//  Test
//
//  Created by liweizhao on 2018/6/27.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZDiffuseLayout.h"
#import "WZDiffuseLayout+Private.h"


@interface WZDiffuseLayout()
{
    BOOL _refreshSignal;
}

@end

@implementation WZDiffuseLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contentInset = UIEdgeInsetsZero;
        _rowsHeigthMap = [NSMutableDictionary dictionary];
        _columnWidthMap = [NSMutableDictionary dictionary];
         _refreshSignal = false;
        _dataDirection = WZExcelLayoutDataDirection_Horizontal;
    }
    return self;
}

- (void)prepareLayout {
    /**
     重新布局计算条件：
     1、记录的行数为0
     2、记录的行数与数据源数目不对应
     3、记录的行数的列数不一致（每行的列数都是统一的且没有行就没有列了）
     */
    if ([self shouldRefresh]) {
        _refreshSignal = false;
        _rowCount = [self.collectionView numberOfSections];
        _XOffsetContainerForSection = [NSMutableDictionary dictionary];
        _YOffsetContainerForSection = [NSMutableDictionary dictionary];
        _attributesMixture = [NSMutableArray array];
        _contentSize = CGSizeZero;
        _itemLayoutBuffer = nil;
        if (_rowCount) {
            _colomnCount = [self.collectionView numberOfItemsInSection:0];
          
            [self calculate];
            {
                self.collectionView.contentInset = UIEdgeInsetsZero;
                //此处不考虑存在nav还status bar的偏移情况
                if (@available(iOS 11.0, *)) {
                    // 如iOS 11.0以下则设置vc.automaticallyAdjustsScrollViewInsets = false; 否则会有偏移
                    self.collectionView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
                }
            }
        }
    } else {
        _rowCount = 0;
    }
}

- (BOOL)shouldRefresh {
    return (_refreshSignal
            || _rowCount == 0
            || _rowCount != [self.collectionView numberOfSections]
            || _colomnCount != [self.collectionView numberOfItemsInSection:0]);
}


- (CGSize)collectionViewContentSize {
    return _contentSize;
}

/**
 获取rect内可见的cell的indexPath修改关联的ats

 @param rect 可见域
 @return 修改过的ats[]
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 根据偏移值缓存，计算位置
    NSMutableArray <UICollectionViewLayoutAttributes *>*atsMArr = NSMutableArray.array;
    for (UICollectionViewLayoutAttributes *ats in _attributesMixture) {
        if (CGRectIntersectsRect(rect, ats.frame)) {
            [atsMArr addObject:ats];
        }
    }
    
    return atsMArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemLayoutBuffer[indexPath.section][indexPath.row];
}

#pragma mark - Private
- (void)calculate {
    NSMutableArray <NSMutableArray <UICollectionViewLayoutAttributes *>*>*itemLayoutBuffer = NSMutableArray.array;
    NSUInteger numberOfSections = _rowCount;
    
    CGFloat x = _contentInset.left;
    CGFloat y = _contentInset.top;
    CGFloat width = _itemSize.width;
    CGFloat height = _itemSize.height;
    CGFloat tmpHeight = 0;
    CGFloat tmpWidth = 0;
    
    for (int section = 0; section < numberOfSections; section++) {
        NSUInteger numberOfItemsInSection = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        NSMutableArray *tmp = [NSMutableArray array];
        tmpHeight = height;
        
        if (_dataDirection == WZExcelLayoutDataDirection_Horizontal) {
            NSNumber *row = self.rowsHeigthMap[@(section)];
            if (row) {
                tmpHeight = row.floatValue;
            }
            self.YOffsetContainerForSection[@(section)] = @(y);
            x = _contentInset.left;
            for (int index = 0; index < numberOfItemsInSection; index++) {
                self.XOffsetContainerForSection[@(index)] = @(x);
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
                UICollectionViewLayoutAttributes *ats = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                {
                    tmpWidth = width;
                    NSNumber *column = self.columnWidthMap[@(index)];
                    if (column) {
                        tmpWidth = column.floatValue;
                    }
                    ats.frame = CGRectMake(x, y, tmpWidth, tmpHeight);//ast
                    x = x + (_lineSpacing + tmpWidth);
                }
                
                [tmp addObject:ats];
                [_attributesMixture addObject:ats];
            }
            y = y + (_interitemSpacing + tmpHeight);
            
        } else if (_dataDirection == WZExcelLayoutDataDirection_Vertical) {
            
            NSNumber *column = self.columnWidthMap[@(section)];
            tmpWidth = width;
            if (column) {
                tmpWidth = column.floatValue;
            }
            self.XOffsetContainerForSection[@(section)] = @(x);
            y = _contentInset.top;
            for (int index = 0; index < numberOfItemsInSection; index++) {
                self.YOffsetContainerForSection[@(index)] = @(y);
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
                UICollectionViewLayoutAttributes *ats = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                {
                    tmpHeight = height;
                    NSNumber *row = self.rowsHeigthMap[@(index)];
                    if (row) {
                        tmpHeight = row.floatValue;
                    }
                    ats.frame = CGRectMake(x, y, tmpWidth, tmpHeight);//ast
                    y = y + (_interitemSpacing + tmpHeight);
                }
                
                [tmp addObject:ats];
                [_attributesMixture addObject:ats];
            }
            x = x + (_lineSpacing + tmpWidth);
        }
        [itemLayoutBuffer addObject:tmp];
    }
    
    _contentSize = CGSizeMake(x - _lineSpacing + _contentInset.right
                                  , y - _interitemSpacing + _contentInset.bottom);
    self.itemLayoutBuffer = itemLayoutBuffer;
}


- (void)setDataDirection:(WZExcelLayoutDataDirection)dataDirection {
    if (dataDirection != _dataDirection) {
        _dataDirection = dataDirection;
        _refreshSignal = true;
    }
}


@end
