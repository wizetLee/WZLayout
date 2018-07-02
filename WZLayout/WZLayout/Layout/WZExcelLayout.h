//
//  WZExcelLayout.h
//  Test
//
//  Created by liweizhao on 2018/6/29.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZDiffuseLayout.h"





/**
  T2功能、特点：
 1、悬停若干行若干列
 2、contentInset总是{0,0,0,0}
 */
@interface WZExcelLayout : WZDiffuseLayout

@property (nonatomic, assign) NSUInteger hoverOverTheTop;//悬停在顶部的数量
@property (nonatomic, assign) NSUInteger hoverOverTheLeft;//悬停在左部的数量

@end
