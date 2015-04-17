//
//  BNRItem.h
//  RandomItems
//
//  Created by N3962 on 2015. 3. 26..
//  Copyright (c) 2015년 N3962. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate  *_dateCreated;
}

+ (instancetype)randomItem;

// 지정 초기화 메소드
- (instancetype)initWithItemName: (NSString *)name
                  valueInDollars: (int)value
                    serialNumber: (NSString *)sNumber;
- (instancetype)initWithItemName: (NSString *)name;

- (void)setItemName: (NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber: (NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars: (int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;

@end
