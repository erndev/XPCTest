//
//  ItemsDataSource.m
//  XCPTest
//
//  Created by ernesto on 28/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "ItemsDataSource.h"


@interface ItemsDataSource() <NSTableViewDataSource>

@property (nonatomic,strong) NSTableView *tableView;
@end

@implementation ItemsDataSource

-(instancetype)initWithTableView:(NSTableView*)tableView
{
  self = [super init];
  if (self )
  {
    _tableView = tableView;
    _tableView.dataSource = self;
  }
  return self ;
}

-(void)setItems:(NSArray *)items
{
  _items = items;
  [self.tableView reloadData];
}

@end


@implementation ItemsDataSource (DataSource)
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return self.items.count;
}

@end