//
//  WZDiffuseLayout.h
//  Test
//
//  Created by liweizhao on 2018/6/27.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WZExcelLayoutDataDirection) {
    WZExcelLayoutDataDirection_Horizontal,
    /**
     section0_row0  section0_row1  section0_row2 ...
     section1_row0
     section2_row0
     .
     .
     .
     */
    WZExcelLayoutDataDirection_Vertical,
    /**
     section0_row0  section1_row0  section2_row0...
     section0_row1
     section0_row2
     .
     .
     .
     */
};

/**
 T1功能、特点：
 1、设置列间距、行间距
 2、itemSize (指定某行的行高、某列的宽度)
 3、不考虑删除和插入（因为设置了横向纵向个数检查，会崩溃，如无特殊说明，其子类也是相同效果）
 4、自定义contentInset
 5、数据横向/纵向展示
 */

/**
 向左下扩散的layout（类flowLayout，但不是限定单个方向的滑动）
 */
@interface WZDiffuseLayout : UICollectionViewLayout

@property (nonatomic, assign, readonly) CGSize contentSize;
@property (nonatomic, assign) WZExcelLayoutDataDirection dataDirection;

@property (nonatomic, assign) CGFloat interitemSpacing;            //列间距
@property (nonatomic, assign) CGFloat lineSpacing;                 //行间距
@property (nonatomic, assign) UIEdgeInsets contentInset;

@property (nonatomic, assign) CGSize itemSize;  //设置默认的cell的尺寸
// 修改整行高度、整列宽度
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *rowsHeigthMap;  //指定某行的高度
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *columnWidthMap; //指定某列的宽度

- (BOOL)shouldRefresh;
@end
