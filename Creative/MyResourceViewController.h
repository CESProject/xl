//
//  MyResourceViewController.h
//  Creative
//
//  Created by Mr Wei on 16/1/31.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSliderScrollView.h"
#import "WJSliderView.h"
#import "TeacherTableViewCell.h"
@interface MyResourceViewController : UIViewController<WJSliderViewDelegate,UITableViewDataSource,UITableViewDelegate,TeacherTableViewCellDelegate>
{
    UITableView *myTableVIew;
}
@property(nonatomic,strong)WJSliderScrollView *wjScroll;
@property(nonatomic,strong)UIView *detalView;
@property(nonatomic,strong)UIView *commentsView;
@property(nonatomic,strong)UIView *resulsView;

@end
