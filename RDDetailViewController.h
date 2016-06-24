//
//  RDDetailViewController.h
//  Homeowner
//
//  Created by Ridhdhi Desai on 3/26/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Items;

@interface RDDetailViewController : UIViewController

- (instancetype)initForNewItem: (BOOL)isNew;

@property (nonatomic, strong) Items *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
