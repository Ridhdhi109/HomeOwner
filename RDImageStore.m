//
//  RDImageStore.m
//  Homeowner
//
//  Created by Ridhdhi Desai on 4/3/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import "RDImageStore.h"

@interface RDImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation RDImageStore

+(instancetype) sharedStore {
    
    static RDImageStore *sharedStore;
    if(!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

//No one should call init
+(instancetype) init {
    
    [NSException raise:@"Singleton" format:@"Use + [RDImageStore sharedStore]"];
    return nil;
}

//Secret designated initializer

- (instancetype) initPrivate {
    
    self = [super init];
    
    if(self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

-(UIImage *) imageForKey:(NSString *)key {
    return self.dictionary[key];
}

-(void) deleteImageForKey:(NSString *)key {
    if(!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}


@end
