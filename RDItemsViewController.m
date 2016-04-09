//
//  RDItemsTableViewController.m
//  Homeowner
//
//  Created by Ridhdhi Desai on 3/15/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import "RDItemsViewController.h"
#import "RDDetailViewController.h"
#import "RDItemStore.h"
#import "Items.h"

@interface RDItemsViewController ()

//@property (nonatomic,strong) IBOutlet UIView *headerView;

@end


@implementation RDItemsViewController

-(instancetype) init {
    //call superclass's designated initializer
    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homeowner";
        
        //Create a new bar button item that will send
        //addNewItem: to BNRItemsViewController
        
        UIBarButtonItem *bbi = [ [UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        //set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:style];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
   // UIView *header = self.headerView;
   // [self.tableView setTableHeaderView:header];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
} */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"This tableview has %lu rows", [[[RDItemStore sharedStore] allItems] count]);
    return [[[RDItemStore sharedStore] allItems] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    // Configure the cell...
    
    //set the text on the cell with description of the item
    //that is at the nth index of items, where n = rows this cell will appear in the tableview
    
    NSArray *items = [[RDItemStore sharedStore] allItems];
    Items *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (IBAction)addNewItem:(id)sender {
    
    //make a new index path for 0th section, last row create a new Item and add it to the store
    
    Items *newItem = [[RDItemStore sharedStore] createItem];
    
    //Figure out where this item is in the array
    NSInteger lastRow = [[[RDItemStore sharedStore] allItems] indexOfObject:newItem];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //Insert this new row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

/*
-(IBAction)toggleEditingMode:(id)sender {
    // if you are currenlty in editing mode
    
    if(self.isEditing) {
        //Change text of Button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        //Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        //Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        //Enter Editing mode
        [self setEditing:YES animated:YES];
        
    }
} */

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:( NSIndexPath *)indexPath{
    
    //if a tableview is asking to commit a delete command
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[RDItemStore sharedStore] allItems];
        Items *item = items[indexPath.row];
        [[RDItemStore sharedStore] removeItem:item];
        //also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*-(UIView *)headerView {
    
    //if you have not loaded the headerView yet
    
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    }
    return _headerView;
} */

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[RDItemStore sharedStore]moveItemIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

-(void)tableView: (UITableView *)tableView
                        didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RDDetailViewController *detailViewController = [[RDDetailViewController alloc] init];
    NSArray *items = [[RDItemStore sharedStore] allItems];
    Items *selectedItem = items[indexPath.row];
    
    //Give detail view controller a pointer to the item object in row
    detailViewController.item = selectedItem;
    
    //push it on the top of the navigation controller list
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
