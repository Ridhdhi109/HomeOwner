//
//  RDItemStore.h
//  Homeowner
//
//  Created by Ridhdhi Desai on 3/19/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
// RDItemStore will be a singleton. This means there will only be one instance of this type in the application

#import <Foundation/Foundation.h>
#import "Items.h"


@class BNRItem;

@interface RDItemStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;

//notice that this is the class metod and prefix with + instead of -
+ (instancetype) sharedStore;
-(Items *) createItem;
-(void) removeItem:(Items *) item;
-(void) moveItemIndex: (NSUInteger) fromIndex toIndex:(NSUInteger)toIndex;

@end
