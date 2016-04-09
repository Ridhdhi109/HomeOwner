//
//  RDImageStore.h
//  Homeowner
//
//  Created by Ridhdhi Desai on 4/3/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RDImageStore : NSObject

+(instancetype) sharedStore;

-(void) setImage: (UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey: (NSString *)key;
-(void)deleteImageForKey: (NSString *)key;

@end
