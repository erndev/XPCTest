//
//  ItemSelectionProtocol.h
//  XCPTest
//
//  Created by ernesto on 23/9/15.
//  Copyright (c) 2015 ernesto. All rights reserved.
//

#ifndef XCPTest_ItemSelectionProtocol_h
#define XCPTest_ItemSelectionProtocol_h

#import "Item.h"

@protocol ItemSelectionProtocol <NSObject>

-(void)itemSelected:(Item*)item;

@end

#endif
