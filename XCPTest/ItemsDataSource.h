//
//  ItemsDataSource.h
//  XCPTest
//
//  Created by ernesto on 28/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import <AppKit/Appkit.h>


@interface ItemsDataSource : NSObject

@property (nonatomic,strong) NSArray *items;

-(instancetype)initWithTableView:(NSTableView*)tableView;



@end
