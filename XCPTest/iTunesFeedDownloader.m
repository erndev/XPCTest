//
//  iTunesFeedDownloader.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "iTunesFeedDownloader.h"
#import "ItemValueTransformer.h"
#import "Item.h"
#import <AppKit/AppKit.h>

static NSString * const kItunesFeedHost       = @"itunes.apple.com";
static NSString * const kItunesFeedScheme     = @"https";
static NSString * const kItunesPathFormaString= @"/us/rss/%@/limit=10/json";
static NSString * const kItunesiOSApps        = @"toppaidapplications";
static NSString * const kItunesBooks          = @"toppaidebooks";
static NSString * const kItunesMacApps        = @"toppaidmacapps";
static NSString * const kItunesMovies         = @"topmovies";
static NSString * const kItunesTvShows        = @"toptvepisodes";

static NSString * const kItunesFeedErrorDomain   = @"iTunesFeedErrorDomain";
static NSInteger const kItunesGenericErrorCode  = 1;



@interface iTunesFeedDownloader ()
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) ItemValueTransformer *valueTransformer;
@end

@implementation iTunesFeedDownloader

-(instancetype)init;
{
  self = [super init];
  if( self )
  {
    [self setupSession];
  }
  return self;
}

-(NSURLRequest*)requestForFeedType:(FeedType)feedType
{
  
  NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
  urlComponents.scheme = kItunesFeedScheme;
  urlComponents.host = kItunesFeedHost;
  NSString *feedTypeString;
  
  switch (feedType) {
    case Books:
      feedTypeString = kItunesBooks;
      break;
    case iOSApps:
      feedTypeString  = kItunesiOSApps;
      break;
    case MacApps:
      feedTypeString = kItunesMacApps;
      break;
    case Movies:
      feedTypeString = kItunesMovies;
      break;
    case TVShows:
      feedTypeString = kItunesTvShows;
      break;
      
    default:
      return nil;
  }
  
  urlComponents.path = [NSString stringWithFormat:kItunesPathFormaString, feedTypeString];
  return [NSURLRequest requestWithURL:urlComponents.URL];
}


-(void)setupSession
{
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  self.session = [NSURLSession sessionWithConfiguration:config];
  // Register the value transformer
  self.valueTransformer = [ItemValueTransformer new];
}

#pragma mark - Download Protocol
-(void)downloadFeed:(FeedType)feed completionBlock:(DownloadFeedCompletionBlock)completionBlock;
{
  //https://itunes.apple.com/us/rss/toppaidapplications/limit=10/json
  
  NSURLRequest *request = [self requestForFeedType:feed];
  if ( request == nil ) {
    
    if( completionBlock)
      completionBlock(nil, [NSError errorWithDomain:kItunesFeedErrorDomain code:kItunesGenericErrorCode userInfo:nil]);
    return;
  }
  NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSArray *items;
    if( !error )
    {
      items = [self.valueTransformer transformedValue:data];
    }
    if ( completionBlock )
      completionBlock(items, error);
  }];
  [task resume];
  
  
}

-(void)downloadImage:(NSURL*)imageURL completionBlock:(DownloadImageCompletionBlock)completionBlock
{
  // In a real app this should be handled in a different session, but for the example the same session is shared.
  NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
  NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    NSImage *image;
    if( !error )
    {
      image = [[NSImage alloc] initWithData:data];
    }
    if( completionBlock )
      completionBlock(imageURL, image, error);
    
  }];
  [dataTask resume];
  
}


@end
