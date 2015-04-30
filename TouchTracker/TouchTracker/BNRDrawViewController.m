//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by N3962 on 2015. 4. 30..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawViewController ()

@end

@implementation BNRDrawViewController

- (void) loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
