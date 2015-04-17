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

@implementation BNRItemsViewController

/* ====== 초기화 ====== */
-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i=0; i<5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}
/* ====== 초기화 ====== */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView
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
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsInSection;
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
    
    NSLog(@"ROW_IN_SECTION(%li)=%li", section, (long)rowsInSection);
    
    return rowsInSection;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
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


/* ====== 내부함수 ====== */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

@end
