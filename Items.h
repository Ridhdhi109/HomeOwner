//
//  Items.h
//  RandomItems
//
//  Created by Ridhdhi Desai on 3/5/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface = class , Items= class name NSObject is superclass of this class
//Onjective C has only single inheritance so every class has only one superclass

@interface Items : NSObject

//Instance varible in the class are declared between curly braces immediately after class declaration

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic,copy) NSString *itemKey;

//Instance method uses + and class method uses -
//in header file instance variable comes first followed by class variables
+(instancetype)randomItem;

//designated initializer for item
-(instancetype)initWithItemName: (NSString *)name
                 ValueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;

-(instancetype)initWithItemName: (NSString *)name;

@end
