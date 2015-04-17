//
//  BNRItemStore.m
//  Homepwner
//
//  Created by N3962 on 2015. 4. 17..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic) NSMutableArray *overItems;
@property (nonatomic) NSMutableArray *underItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore =nil;
    
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    // 얘는 그럼 함수 이름이 뭘까요?
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    if (item.valueInDollars > 50) {
        [self.overItems addObject:item];
        NSLog(@"VALUE_IN_DOLLARS_OVER=%i", item.valueInDollars);
    }else{
        [self.underItems addObject:item];
        NSLog(@"VALUE_IN_DOLLARS_UNDER=%i", item.valueInDollars);
    }
    
    return item;
}


- (NSArray *)allItems
{
    return self.privateItems;
}

- (NSArray *)over50Items
{
    return self.overItems;
}

- (NSArray *)under50Items
{
    return self.underItems;
}

@end