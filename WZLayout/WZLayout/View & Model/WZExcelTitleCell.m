//
//  WZExcellTitleCell.m
//  WZLayout
//
//  Created by liweizhao on 2018/7/1.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZExcelTitleCell.h"

@interface WZExcelTitleCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WZExcelTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = [UIColor redColor];
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.text = @"--";
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textAlignment = 1;
}

//使用autolayout或者重新布局
-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

- (void)updateWithTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
