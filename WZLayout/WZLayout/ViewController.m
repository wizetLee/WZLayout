//
//  ViewController.m
//  WZLayout
//
//  Created by liweizhao on 2018/6/30.
//  Copyright © 2018年 wizet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @[@{
                  @"title" : @"excel",
                  @"className" : @"BViewController",
                  },
//              @{
//                  @"title" : @"",
//                  @"className" : @"CViewController",
//                  },
//              @{
//                  @"title" : @"",
//                  @"className" : @"DViewController",
//                  },
//              @{
//                  @"title" : @"",
//                  @"className" : @"EViewController",
//                  },
              ];
    
    [self.view addSubview:self.table];
    [self.table reloadData];
}



- (UITableView *)table {
    if(!_table) {
        UITableView *table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [self.view addSubview:table];
        
        table.delegate = (id<UITableViewDelegate>)self;
        table.dataSource = (id<UITableViewDataSource>)self;
        table.backgroundColor = UIColor.lightGrayColor;
        table.estimatedRowHeight = UITableViewAutomaticDimension;
        table.estimatedSectionFooterHeight = 0.0;
        table.estimatedSectionHeaderHeight = 0.0;
        
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _table = table;
        
    }
    return _table;
}


#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (_data.count > indexPath.row) {
        cell.textLabel.text = (NSString *)_data[indexPath.row][@"title"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_data.count > indexPath.row) {
        [self.navigationController pushViewController:NSClassFromString((NSString *)_data[indexPath.row][@"className"]).new animated:true];
    }
}



@end
