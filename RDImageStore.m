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
    
    static RDImageStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
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

- (void) setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
    
    //Create full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    //Turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    //Write it to full path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *) imageForKey:(NSString *)key {
    return self.dictionary[key];
}

- (NSString *)imagePathForKey: (NSString *)key {
   
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (void) deleteImageForKey:(NSString *)key {
    if(!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
     NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

@end
