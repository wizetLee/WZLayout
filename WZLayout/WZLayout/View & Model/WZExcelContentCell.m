//
//  WZExcelContentCell.m
//  WZLayout
//
//  Created by liweizhao on 2018/7/1.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "WZExcelContentCell.h"

@interface WZExcelContentCell()


@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WZExcelContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = [UIColor greenColor];
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.text = @"--";
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textAlignment = 1;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

- (void)updateWithTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
