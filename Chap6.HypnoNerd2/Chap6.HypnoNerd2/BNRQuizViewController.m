//
//  BNRQuiz.m
//  Chap6.HypnoNerd2
//
//  Created by N3962 on 2015. 4. 9..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRQuizViewController.h"

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        
        tbi.title = @"Quiz";
        
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        tbi.image = i;
    }
    
    return self;
}

@end
