//
//  WZLayout.h
//  Test
//
//  Created by liweizhao on 2018/6/25.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import <UIKit/UIKit.h>



//避免了刷新时数据量大引起的线程阻塞、缺点在于每次滑动都要计算位置
@interface WZLayout : UICollectionViewLayout

@property (nonatomic, assign, readonly) CGSize contentSize;
@property (nonatomic, assign) CGFloat minimumLineSpacing;//列间距
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;//行间距

@property (nonatomic, assign) UIEdgeInsets contentInset;


//普通cell的样式
@property (nonatomic, assign) CGSize itemSize;
//指定cell的样式

// cell是规则的，只能改同方向的行高、宽度
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *rowsHeigthMap; //指定某行的高度
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *> *columnWidthMap; //指定某列的宽度




@end
