//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by N3962 on 2015. 4. 17..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"
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
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

/*
// UINavigationItem에 BarButtonItem 추가로 인한 삭제
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
*/
/* ====== 초기화 E ====== */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)      tableView:(UITableView *)tableView
      titleForHeaderInSection:(NSInteger)section
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

/*
 * editing 모드로 전환 후 item을 삭제합니다.
 */
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

/*
 * View에서 item이 이동할때 dataSource도 같이 수정합니다.
 * -- view에서 이동이 안되게 하는 방법이 필요!!
 */
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
- (NSString *)   tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

/*
 * TableView의 Row가 선택됐을때 호출됩니다
 */
- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}



/* ====== 내부함수 ====== */
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

// UINavigationItem에 BarButtonItem 추가로 인한 삭제
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

@end
