//
//  SqTableViewController.m
//  Creative
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SqTableViewController.h"
#import "SquareTableViewCell.h"
#import "AppearedTableViewCell.h"
#import "FlashTableViewCell.h"
#import "AppeareddetailsViewController.h"
#import "DataHelper.h"
@interface SqTableViewController ()<DateHelperDelegate>{
    NSMutableArray *arrayInfo;
    NSDictionary *dicInfo;
}
@end

@implementation SqTableViewController

- (void)viewDidLoad {
     [self GetInfo];
    [super viewDidLoad];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem * barbtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"select.png"] style:UIBarButtonItemStyleDone target:self action:@selector(qweqwe)];
//    [barbtn setTintColor:[UIColor whiteColor]];
//    
//    self.navigationItem.rightBarButtonItem=barbtn;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:DEF_RGB_COLOR(255, 255, 255)}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"3 (6)" highImage:nil];
    
    UIBarButtonItem *so = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"search"];
    UIBarButtonItem *sh = [UIBarButtonItem itemWithTarget:self action:@selector(selecterClick) image:@"select"];
    self.navigationItem.rightBarButtonItems = @[sh,so];
    
   
 }
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) searchClick{}
-(void)selecterClick {}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    #warning Incomplete implementation, return the number of rows
    return [arrayInfo count];
}
-(void) GetInfo{
    NSString *strUrl=@"POST /queryRepositoryAndCategory/getRepositoryCategoryPageForB";
    DataHelper *dataHelper=[[ DataHelper alloc] init];
    dataHelper.delegate=self;
    [dataHelper GETRequest:strUrl];
}
-(void) backValue:(id)obj{
//    arrayInfo =[[NSMutableArray alloc] init];
//    arrayInfo =[obj objectForKey:@"tngou"];
    NSLog(@"%@",obj);
    
    [self.tableView  reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==0) {
        
        static NSString *acell=@"acell";
        SquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
     
        dicInfo =[[NSDictionary alloc] init];
        dicInfo=arrayInfo[indexPath.row];
        NSLog(@"%@",dicInfo);
         NSLog(@"-------%@",[dicInfo  objectForKey:@"count"]);
    
       
        if (!cell) {
            cell=[[SquareTableViewCell alloc]init];
        }
         cell.TypeTitle.text=dicInfo[@"count"];
        // Configure the cell...
        
        return cell;
    }else if(_index==1)
    {
        static NSString *bcell=@"bcell";
        SquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bcell];
        if (!cell) {
            cell=[[SquareTableViewCell alloc]init];
            cell.TypeTitle.text=@"a";
        }
        return cell;
    }else if (_index==2){
    
        static NSString *ccell=@"ccell";
        AppearedTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ccell];
        if (!cell) {
            cell=[[AppearedTableViewCell alloc]init];
            cell.TypeTitle.text=@"b";
        }
        return cell;
        
    }else if (_index==3){
    
        static NSString *dcell=@"dcell";
        FlashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dcell];
        if (!cell) {
            cell=[[FlashTableViewCell alloc]init];
            cell.TypeTitle.text=@"cß";
        }
        
        // Configure the cell...
        
        return cell;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppeareddetailsViewController *apper = [[AppeareddetailsViewController alloc]init];
    apper.view = [[UIView alloc]initWithFrame:self.view.frame];
    apper.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:apper animated:YES];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the
 row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

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
