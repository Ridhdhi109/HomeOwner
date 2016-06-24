//
//  RDItemStore.m
//  Homeowner
//
//  Created by Ridhdhi Desai on 3/19/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import "RDItemStore.h"
#import "Items.h"
#import "RDImageStore.h"

@interface RDItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation RDItemStore

+ (instancetype) sharedStore {
    
    static RDItemStore *sharedStore = nil;    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

//if a programmer calls [[RDItemSore] alloc] init] let him know the error of his ways

-(instancetype)init {
    [NSException raise:@"Singleton" format:@"Use + [BNRItemStore sharedStore]"];
    return nil;
}

//Here is the real (Secret) initializer
-(instancetype) initPrivate {
    
    self = [super init];
    
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        //If the  array hadn't been saved previously, create a new empty one
        if(!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(NSArray *) allItems {
    
    return [self.privateItems copy];
}

-(Items *)createItem {
    
    Items *item = [[Items alloc] init];
    [self.privateItems addObject:item];
    return item;
    
}

-(void) removeItem:(Items *)item
{
    NSString *key = item.itemKey;
    [[RDImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void) moveItemIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) {
        return;
    }
    //Get the pointer to object being moved so that you can reinsert it
    Items *item = self.privateItems[fromIndex];
    
    //Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (NSString *)itemArchivePath {
    //Make sure that the first argument is NSDocument Directory
    //and not NSDocumentationDirectory
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    
    //return YES on success
    
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
