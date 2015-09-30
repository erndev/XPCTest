//
//  ListViewController.h
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ItemSelectionProtocol.h"
#import "DownloadProtocol.h"

@interface ListViewController : NSViewController

@property (weak) id<ItemSelectionProtocol> delegate;
@property (nonatomic,strong) id<DownloadProtocol> downloader;

@end
