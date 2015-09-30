//
//  WindowController.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "WindowController.h"
#import "ListViewController.h"
#import "DetailViewController.h"
#import "ItemSelectionProtocol.h"
#import "iTunesXPCDownloader.h"

@interface WindowController ()<ItemSelectionProtocol>

@property (nonatomic) DetailViewController *detailViewController;
@property (nonatomic) ListViewController *listViewController;
@property (nonatomic,strong) iTunesXPCDownloader *downloader;
@end

@implementation WindowController

- (void)windowDidLoad {

  [super windowDidLoad];
    
  [self setupControllers];
  
}

-(void)setupControllers
{
  NSSplitViewController *splitController = (NSSplitViewController*)self.contentViewController;
  self.detailViewController = splitController.childViewControllers.lastObject;
  self.listViewController = splitController.childViewControllers.firstObject;
  
  self.listViewController.delegate = self;

  self.downloader = [[iTunesXPCDownloader alloc] init];
  self.detailViewController.downloader = self.downloader;
  self.listViewController.downloader = self.downloader;
}

#pragma mark - ItemSelection Protocol
-(void)itemSelected:(Item *)item
{
  self.detailViewController.representedObject = item;
}

@end
