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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }
    return self;
}

- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    // 여기서 왜 참조가 안 될까요??
    // private&public
    //backgroundView.circleColor = [UIColor lightGrayColor];
    
    UISegmentedControl *mainSegment = [[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:@"RED", @"BLUE", @"GREEN", nil]];

    mainSegment.frame = CGRectMake(backgroundView.bounds.size.width, 10, 200, 43);
    
    self.navigationItem.titleView = mainSegment;
    
    mainSegment.selectedSegmentIndex = 1;
    
    [mainSegment addTarget:self
                    action:@selector(mainSegmentControl:)
          forControlEvents: UIControlEventValueChanged];
    
    [backgroundView addSubview:mainSegment];
    
    self.view = backgroundView;
}

- (void)mainSegmentControl:(UISegmentedControl *)segment
{
    BNRHypnosisView *view = (BNRHypnosisView*)self.view;
    
    if(segment.selectedSegmentIndex == 0)
    {
        [view changeCircleColor:[UIColor redColor]];
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        [view changeCircleColor:[UIColor blueColor]];
    }
    else if(segment.selectedSegmentIndex == 2)
    {
        [view changeCircleColor:[UIColor greenColor]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

@end
