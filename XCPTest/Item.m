//
//  Item.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "Item.h"

@interface Item ()
@property (copy,nonatomic) NSURL *url;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSURL *imageURL;
@property (copy,nonatomic) NSString *author;
@property (copy,nonatomic) NSString * price;
@property (copy,nonatomic) NSString * summary;
@end

@implementation Item

-(instancetype)initWithURL:(NSURL*)url name:(NSString*)name imageURL:(NSURL*)imageURL artist:(NSString*)artist price:(NSString*)price summary:(NSString *)summary
{
  self = [super init];
  if( self )
  {
    self.url  = url;
    self.name = name;
    self.imageURL = imageURL;
    self.author = artist;
    self.price = price;
    self.summary = summary;
    
  }
  return self;
}

-(NSString *)description
{
  [super description];
  return [NSString stringWithFormat:@"%@\nURL:\t%@\nName:\t%@\nAuthor:\t%@\nPrice:\t%@\nSummary:\t%@\nImage URL:\t%@\n", [super description], self.url, self.name, self.author, self.price, self.summary, self.imageURL];
}

#pragma mark - Secure coding (required by XPC)

+(BOOL)supportsSecureCoding
{
  return YES;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
 
  [aCoder encodeObject:self.url forKey:@"url"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.imageURL forKey:@"imageURL"];
  [aCoder encodeObject:self.author forKey:@"author"];
  [aCoder encodeObject:self.price forKey:@"price"];
  [aCoder encodeObject:self.summary forKey:@"summary"];
  
  
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super init];
  if( self )
  {
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.imageURL = [aDecoder decodeObjectForKey:@"imageURL"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.summary = [aDecoder decodeObjectForKey:@"summary"];
  }
  return self;
}

@end
