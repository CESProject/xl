//
//  searchResultForExperienceController.m
//  Creative
//
//  Created by MacBook on 16/3/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "searchResultForExperienceController.h"
#import "ListFriend.h"
@implementation searchResultForExperienceController


- (void)viewDidLoad{
    self.tableView.rowHeight = 90;
//     self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idnefif = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idnefif];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:idnefif];
        
    }
    ListFriend *listFriend = [self.CellArray objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:listFriend.image.absoluteImagePath] placeholderImage:[UIImage imageNamed:@"picf"]];
    cell.textLabel.text = listFriend.title;
    return cell;
}

@end
