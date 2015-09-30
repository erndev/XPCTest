//
//  ItunesXPCDownloader.m
//  XCPTest
//
//  Created by ernesto on 29/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "iTunesXPCDownloader.h"
#import "Item.h"

static NSString * const kXPCServiceName = @"com.ernesto.DownloadService";

@interface iTunesXPCDownloader ()
@property (strong,nonatomic) NSXPCConnection *xpcConnection;
@end

@implementation iTunesXPCDownloader

-(instancetype)init{
  
  self = [super init];
  if( self )
  {
    [self setupXPCConnection];
  }
  return self;
}

-(void)dealloc
{
  [self.xpcConnection invalidate];
}

-(void)setupXPCConnection
{
  self.xpcConnection = [[NSXPCConnection alloc] initWithServiceName:kXPCServiceName];
  self.xpcConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(DownloadProtocol)];
  
  // Configure the interface to allow the classes we use
  NSMutableArray *allowedClasses =  [NSMutableArray arrayWithArray:[[self.xpcConnection.remoteObjectInterface classesForSelector:@selector(downloadFeed:completionBlock:) argumentIndex:0 ofReply:YES] allObjects ]];
  [allowedClasses addObjectsFromArray:@[[Item class], [NSURL class]]];
  
  [self.xpcConnection.remoteObjectInterface setClasses:[NSSet setWithArray:allowedClasses] forSelector:@selector(downloadFeed:completionBlock:) argumentIndex:0 ofReply:YES];

  [self.xpcConnection resume];
}

#pragma mark - Invoke Remote methods
-(void)downloadFeed:(FeedType)feed completionBlock:(DownloadFeedCompletionBlock)completionBlock
{
   [self.xpcConnection.remoteObjectProxy downloadFeed:feed completionBlock:completionBlock];
}

-(void)downloadImage:(NSURL *)imageURL completionBlock:(DownloadImageCompletionBlock)completionBlock
{
  [self.xpcConnection.remoteObjectProxy downloadImage:imageURL completionBlock:completionBlock];

}

@end
