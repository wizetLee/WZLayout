//
//  BViewController.m
//  WZLayout
//
//  Created by liweizhao on 2018/6/30.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "BViewController.h"

#import "WZDiffuseLayout.h"
#import "WZLayout.h"
#import "WZExcelLayout.h"

#import "WZExcelTitleCell.h"
#import "WZExcelContentCell.h"
#import "WZExcelModelProtocol.h"
#import "WZExcelTitleModel.h"
#import "WZExcelContentModel.h"

@interface BViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) WZExcelLayout *layout;
@property (nonatomic, strong) NSMutableArray <NSMutableArray <WZExcelModelProtocol>*>*dataSource;
@property (nonatomic, assign) NSUInteger sectionCount;
@property (nonatomic, assign) NSUInteger rowCount;


@end

@implementation BViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"excel";
    self.view.backgroundColor = UIColor.whiteColor;
    self.automaticallyAdjustsScrollViewInsets = false;
    [self initViews];
    [self initData];
}

- (void)initViews {
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithTitle:@"action" style:UIBarButtonItemStyleDone target:self action:@selector(action)]
                                                ];
    
    _layout = WZExcelLayout.new;
    _layout.itemSize = CGSizeMake(50.0, 33.0);
    _layout.lineSpacing = 1.0;
    _layout.interitemSpacing = 1.0;
    _layout.dataDirection = 1;
    _layout.hoverOverTheLeft = 1;
    _layout.hoverOverTheTop = 1;
    //    _layout.rowsHeigthMap[@(0)] = @(20);
    //    _layout.rowsHeigthMap[@(1)] = @(20);
    //    _layout.columnWidthMap[@(0)] = @(20);
    //    _layout.columnWidthMap[@(1)] = @(20);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 88.0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 88.0 - 34) collectionViewLayout:_layout];
    [self.view addSubview:_collection];
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collection.showsHorizontalScrollIndicator = _collection.showsVerticalScrollIndicator = true;
    [_collection registerClass:WZExcelTitleCell.class forCellWithReuseIdentifier:@"WZExcellTitleCell"];
    [_collection registerClass:WZExcelContentCell.class forCellWithReuseIdentifier:@"WZExcelContentCell"];
    _collection.alwaysBounceVertical = true;
    _collection.alwaysBounceHorizontal = true;
    
}

- (void)initData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.sectionCount = 20;
        self.rowCount = 20;
        NSMutableArray *tmpSection = NSMutableArray.array;
        for (int i = 0; i < self.sectionCount; i++) {
            NSMutableArray *tmpRow = NSMutableArray.array;
            for (int j = 0; j < self.rowCount; j++) {
                if (i == 0) {
                    WZExcelTitleModel *model = WZExcelTitleModel.new;
                    model.title = [NSString stringWithFormat:@"%d:%d", i, j];
                    [tmpRow addObject:model];
                } else {
                    WZExcelContentModel *model = WZExcelContentModel.new;
                    model.title = [NSString stringWithFormat:@"%d:%d", i, j];
                    [tmpRow addObject:model];
                }
                
            }
            [tmpSection addObject:tmpRow];
        }
        self.dataSource = tmpSection;
        [self.collection reloadData];
    });
}


- (void)action {
//  _layout.interitemSpacing = _layout.lineSpacing = _layout.lineSpacing + 2.0;
    if (_layout.dataDirection == WZExcelLayoutDataDirection_Horizontal) {
        _layout.dataDirection = WZExcelLayoutDataDirection_Vertical;
    } else {
        _layout.dataDirection = WZExcelLayoutDataDirection_Horizontal;
    }
  [_collection reloadData];
}


#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sectionCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rowCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [(_dataSource[indexPath.section][indexPath.row]) identifier];
    if (cellID == nil) {
        cellID = @"UICollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[WZExcelTitleCell class]]) {
        [((WZExcelTitleCell *)cell) updateWithTitle:[(_dataSource[indexPath.section][indexPath.row]) title]];
    } else if ([cell isKindOfClass:[WZExcelContentCell class]]) {
        [((WZExcelContentCell *)cell) updateWithTitle:[(_dataSource[indexPath.section][indexPath.row]) title]];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}


@end
