//
//  DetailViewController.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"


@interface DetailViewController ()

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *authorTextField;
@property (weak) IBOutlet NSTextField *priceTextField;
@property (weak) IBOutlet NSTextField *summaryTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
  [self updateDetails];
}

-(void)setRepresentedObject:(id)representedObject
{
  [super setRepresentedObject:representedObject];
  [self updateDetails];
}


-(void)updateDetails
{
  
  
  Item * item = (Item*)self.representedObject;
  
  [self.nameTextField setStringValue:item.name ?: @""];
  [self.authorTextField setStringValue:item.author ?: @"" ];
  [self.priceTextField setStringValue:item.price ?: @"" ];
  [self.summaryTextField setStringValue:item.summary ?: @"" ];
  self.imageView.image =nil;
  
  // this should go to an image cache. just a sample app, so download and show it directly.
  if( item.imageURL )
  {
      [self.downloader downloadImage:item.imageURL completionBlock:^(NSURL *url, NSImage *image, NSError *error) {
        if( [item.imageURL isEqual:url])
        {
          dispatch_async(dispatch_get_main_queue(), ^{

            self.imageView.image = image;
          });
        }
      }];
  }
  
}


@end
