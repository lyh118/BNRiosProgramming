//
//  BNRImageStore.h
//  Homepwner
//
//  Created by N3962 on 2015. 5. 7..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
