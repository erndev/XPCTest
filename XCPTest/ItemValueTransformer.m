//
//  ItemValueTransformer.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "ItemValueTransformer.h"
#import "Item.h"

static NSString * const kFeedKey = @"feed";
static NSString * const kEntryKey = @"entry";
static NSString * const kIDKey = @"id";
static NSString * const kArtistKey = @"im:artist";
static NSString * const kImageKey = @"im:image";
static NSString * const kPriceKey = @"im:price";
static NSString * const kLabelKey = @"label";
static NSString * const kNameKey = @"im:name";
static NSString * const kSummaryKey = @"summary";



@implementation ItemValueTransformer

+(Class)transformedValueClass {
  return [Item class];
}

+(BOOL)allowsReverseTransformation
{
  return NO;
}

-(NSArray*)transformedValue:(NSData*)jsonData {
  
  if( ![jsonData isKindOfClass:[NSData class]]) {
    return nil;
  }
  
  NSMutableArray *items  = [[NSMutableArray alloc] init];
  NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
  NSDictionary *feed = [json valueForKey:kFeedKey];
  if( feed != nil )
  {
    NSArray * entries = feed[kEntryKey];
    if( [entries isKindOfClass:[NSArray class]]) {
      for ( NSDictionary * entry in entries )
      {
        Item *item = [self itemFromJson:entry];
        if( item ){
          [items addObject:item];
        }
      }
    }
  }
  return [items copy];
}

- (NSString *) unscapeString:(NSString*)string {
  CFStringRef unescapedCF = CFXMLCreateStringByUnescapingEntities (NULL,
                                                                   (CFStringRef) string, NULL);
  NSString *unescaped = [NSString stringWithString: (__bridge NSString *)
                         unescapedCF];
  CFRelease (unescapedCF);

  return unescaped;
}

-(NSString*)highestResImage:(NSArray*)imagesArray
{
  NSString *imageURL;
  NSInteger currentRes = 0;
  for( NSDictionary *dict in imagesArray )
  {
    NSInteger imageRes = [dict[@"attributes"][@"height"] integerValue];
    if( imageRes > currentRes )
    {
      imageURL  = dict[kLabelKey];
    }
  }
  
  return imageURL;
}

-(Item*)itemFromJson:(NSDictionary*)json
{
  NSString *url = json[kIDKey][kLabelKey];
  NSString *author = json[kArtistKey][kLabelKey];
  NSString *imageURL = [self highestResImage:json[kImageKey]];
  NSString *name = json[kNameKey][kLabelKey];
  NSString *price = json[kPriceKey][kLabelKey];
  NSString *summary = json[kSummaryKey][kLabelKey];
  
  
  if ( url.length == 0 || imageURL.length == 0 )
  {
    // we expect valid urls.
    return nil;
    
  }
  
  summary   = [self unscapeString:summary];
  author    = [self unscapeString:author];
  name      = [self unscapeString:name];
  price     = [self unscapeString:price];
  
  return [[Item alloc] initWithURL:[NSURL URLWithString:url] name:name imageURL:[NSURL URLWithString:imageURL] artist:author price:price summary:summary];
}

@end
