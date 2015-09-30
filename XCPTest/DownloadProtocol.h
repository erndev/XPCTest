//
//  DownloadProtocol.h
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#ifndef XCPTest_DownloadProtocol_h
#define XCPTest_DownloadProtocol_h
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  Books,
  iOSApps,
  MacApps,
  Movies,
  TVShows
} FeedType;

typedef void(^DownloadFeedCompletionBlock)(NSArray *items, NSError* error);
typedef void(^DownloadImageCompletionBlock)(NSURL *imageURL, NSImage *image, NSError* error);
@protocol DownloadProtocol <NSObject>

-(void)downloadFeed:(FeedType)feed completionBlock:(DownloadFeedCompletionBlock)completionBlock;
-(void)downloadImage:(NSURL*)imageURL completionBlock:(DownloadImageCompletionBlock)completionBlock;
@end

#endif
