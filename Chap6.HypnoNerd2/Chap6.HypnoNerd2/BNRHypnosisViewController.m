//
//  BNRHypnosisViewController.m
//  Chap6.HypnoNerd
//
//  Created by N3962 on 2015. 4. 9..
//
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@end

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
    
    /* ====== SegmentView 생성 [S] ====== */
    UISegmentedControl *mainSegment = [[UISegmentedControl alloc]
                            initWithItems:[NSArray arrayWithObjects:@"RED", @"BLUE", @"GREEN", nil]];

    mainSegment.frame = CGRectMake(100, 10, 200, 43);
    
    self.navigationItem.titleView = mainSegment;
    
    mainSegment.selectedSegmentIndex = 1;
    
    [mainSegment addTarget:self
                    action:@selector(mainSegmentControl:)
          forControlEvents: UIControlEventValueChanged];
    
    [backgroundView addSubview:mainSegment];
    /* ====== SegmentView 생성 [E] ====== */
    
    /* ====== 텍스트 필드 추가 [S] ====== */
    CGRect textFieldRect = CGRectMake(45, 150, 270, 30);
    UITextField * textFiled = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textFiled.borderStyle   = UITextBorderStyleRoundedRect;
    textFiled.placeholder   = @"Hypnotize me";
    textFiled.returnKeyType = UIReturnKeyDone;
    textFiled.delegate      = self;
    
    [backgroundView addSubview:textFiled];
     
    /* ====== 텍스트 필드 추가 [E] ====== */
    
    self.view = backgroundView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder]; //이게 뭘까요??
    
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i=0; i<20; i++) {
        
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // 라벨의 크기를 표시할 텍스트에 적합하게 조절한다
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
    }
}

/*
 * Segment CallBack Function
 */
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
