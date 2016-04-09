//
//  Items.m
//  RandomItems
//
//  Created by Ridhdhi Desai on 3/5/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import "Items.h"

@implementation Items

-(instancetype) initWithItemName:(NSString *)name ValueInDollars:(int)value serialNumber:(NSString *)sNumber {
    //call the superclass's designated initializer
    self = [super init];
    
    //did super class designated initializer succeed?
    if (self) {
        //give the instance variable initial values
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        
        // set datecreated to current date and time
        _dateCreated = [[NSDate alloc] init];
        
        //Create an NSUUID object - and get its string representation
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    //Retern the address of the newly initialized object
    return self;
}

-(instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name
                   ValueInDollars:0
                   serialNumber:@""];
}

-(instancetype) init {
    return [self initWithItemName:@"Items"];
}

-(NSString *) description {
NSString *descriptionString = [[NSString alloc] initWithFormat: @ " %@ (%@) Worth %d, recorded on %@",self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];

return descriptionString;
}

-(void) dealloc {
    NSLog(@"Destroyed:%@",self);
}

+(instancetype) randomItem {
    //Create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    //Create immutable array of three nouns
    NSArray *randomNounList = @[@"Bear" , @"Spork", @"Mac"];
    
    //Get the index of a random adjective/noun from the lists
    //Note that the % operator is the modulo operator, gives
    //you the remainder.  So adjective index is a random number from 0 to 2 inclusive
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    //NSInterger is not an object but a type definition for long
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@" , randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    Items *newItem = [[self alloc] initWithItemName:randomName ValueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
    
}

@end
