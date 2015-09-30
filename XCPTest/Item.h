//
//  Item.h
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject<NSSecureCoding>

@property (nonatomic,copy,readonly) NSURL *url;
@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic,copy,readonly) NSURL *imageURL;
@property (nonatomic,copy,readonly) NSString *author;
@property (nonatomic,copy,readonly) NSString *price;
@property (nonatomic,copy,readonly) NSString *summary;
@property (nonatomic,strong) NSImage *image;

-(instancetype)initWithURL:(NSURL*)url name:(NSString*)name imageURL:(NSURL*)imageURL artist:(NSString*)artist  price:(NSString*)price summary:(NSString*)summary;

@end
