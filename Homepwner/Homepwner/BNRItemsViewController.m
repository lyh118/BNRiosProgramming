//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by N3962 on 2015. 4. 17..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

/* ====== 초기화 S ====== */
-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        /*for (int i=0; i<5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }*/
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];

    // 테이블뷰에 헤더뷰에 관해 알려준다
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
    
}

- (UIView *)headerView
{
    // headerView가 아직 로드되지 않았다면...
    if(!_headerView) {
        
        // HeaderView.xib를 로드한다
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    
    return _headerView;
}
/* ====== 초기화 E ====== */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerMsg;
    if (section == 0) {
        headerMsg = @"첫번째 Section";
    }else{
        headerMsg = @"두번째 Section";
    }
        
    return headerMsg;
}

/*
 * UITableViewController를 상속받은 BNRItemsViewController 는
 * tableView:numberOfRowsInSection: 과
 * tableView:cellForRowAtIndexPath: 를 반드시 구현해야 한다
 */
- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsInSection;
    rowsInSection = [[[BNRItemStore sharedStore] allItems] count];
    /*
    switch (section) {
        case 0:
            rowsInSection = [[[BNRItemStore sharedStore] over50Items] count];
            break;
            
        case 1:
            rowsInSection = [[[BNRItemStore sharedStore] under50Items] count];
            break;
            
        default:
            break;
    }
    */
    NSLog(@"ROW_IN_SECTION(%li)=%li", section, (long)rowsInSection);
    
    return rowsInSection;
}

- (UITableViewCell *)   tableView:(UITableView *)tableView
            cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * cell 재사용 안함
     *
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"UITableViewCell"];
    */
    
    // cell 재사용
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *itme = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:itme];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

/*
 * Chap9.은메달 과제: 재정렬 막기
 */
- (BOOL)        tableView:(UITableView *)tableView
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowsInSection = [[[BNRItemStore sharedStore] allItems] count]-1;
    
    if (indexPath.row == rowsInSection) // Don't move the first row
        return NO;
    
    return YES;
}

/*
 * Editing Mode로 전환되지 않습니다
 */
- (BOOL)        tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowsInSection = [[[BNRItemStore sharedStore] allItems] count]-1;
    
    if (indexPath.row == rowsInSection)
        return NO;
    
    return YES;
}

/*
 * Chap.9 동메달 과제
 * 'Delete'버튼 -> 'Remove'로 변경
 */
-(NSString *)   tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

/* ====== CHAP.9 ======*/
- (IBAction)addNewItem:(id)sender
{
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];

    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
    
}

- (IBAction)toggleEditingMode:(id)sender
{
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        [self setEditing:YES animated:YES];
    }
    
}


/* ====== 내부함수 ====== */


@end
