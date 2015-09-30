//
//  DetailViewController.h
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DownloadProtocol.h"
#import "DownloadProtocol.h"

@interface DetailViewController : NSViewController
@property (nonatomic,strong) id<DownloadProtocol> downloader;
@end
