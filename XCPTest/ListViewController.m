//
//  ListViewController.m
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#import "ListViewController.h"
#import "ItemsDataSource.h"
#import "ItemCell.h"

static NSString * const kCellID = @"ItemCell";

@interface ListViewController ()<NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic,strong) ItemsDataSource *dataSource;
@property FeedType currentFeed;
@property (weak) IBOutlet NSProgressIndicator *progressControl;
@property (weak) IBOutlet NSPopUpButton *popupButton;
@end

@implementation ListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupUI];

}

-(void)setupUI
{
  self.dataSource = [[ItemsDataSource alloc] initWithTableView:self.tableView];
  self.tableView.delegate = self;
  
}

-(void)downloadFeed:(FeedType)feed
{
  self.currentFeed = feed;
  [self.progressControl startAnimation:self];
  

  [self.downloader downloadFeed:feed completionBlock:^(NSArray *items, NSError *error) {
    // Make sure UI work is done in the main thread.
    dispatch_async(dispatch_get_main_queue(), ^{
      [self itemsReceived:items feed:feed error:error];
    });
  }];
}

-(void)itemsReceived:(NSArray*)array feed:(FeedType)feed error:(NSError*)error
{
  [self.progressControl stopAnimation:self];

  if (feed == self.currentFeed )
  {
    NSLog(@"Processing items received");
    self.dataSource.items = array;
    [self informDelegate];
  }
}

-(void)informDelegate
{
  NSInteger selectedIndex = [self.tableView selectedRow];
  if( [self.delegate respondsToSelector:@selector(itemSelected:)] ){
    [self.delegate itemSelected: selectedIndex>=0 ? self.dataSource.items[selectedIndex]: nil];
  }
}

-(IBAction)popupSelectionChanged:(NSPopUpButton*)sender
{
  self.dataSource.items = [[NSArray alloc] init];
  [self downloadFeed:sender.indexOfSelectedItem];
}

#pragma mark - Tableview Delegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  ItemCell * cell = [tableView makeViewWithIdentifier:kCellID owner:self];
  Item *item = self.dataSource.items[row];
  
  [cell.textField setStringValue:item.name];
  [cell.subtitleTextField setStringValue:item.author];
  return cell;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
  if( [self.delegate respondsToSelector:@selector(itemSelected:)] )
  {
    NSInteger selectedRow = self.tableView.selectedRow;
    [self.delegate itemSelected: (selectedRow>=0) ?self.dataSource.items[selectedRow]:nil];
  }
}

@end
