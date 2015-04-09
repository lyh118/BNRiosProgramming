//
//  BNRHypnosisViewController.m
//  Chap6.HypnoNerd
//
//  Created by N3962 on 2015. 4. 9..
//
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController

- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    self.view = backgroundView;
}

@end
