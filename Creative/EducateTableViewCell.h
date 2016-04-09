//
//  EducateTableViewCell.h
//  Creative
//
//  Created by Mr Wei on 16/1/26.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "informationModel.h"

@interface EducateTableViewCell : UITableViewCell<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


@property (nonatomic , strong) UIView *backGroundView;

@property (nonatomic , strong) UILabel *schooltypeLab;
@property (nonatomic , strong) UITextField *schooltypeText;
@property (nonatomic , strong) UILabel *schoolnameLab;
@property (nonatomic , strong) UITextField *schoolnameText;
@property (nonatomic , strong) UILabel *sectionLab;
@property (nonatomic , strong) UITextField *sectionText;
@property (nonatomic , strong) UILabel *dateLab;
@property (nonatomic , strong) UITextField *dateText1;
@property (nonatomic , strong) UILabel *branchLab;
@property (nonatomic , strong) UITextField *branchText;

@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line6;

@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIButton *delBtn;

@property (nonatomic , strong) informationModel *infmodelcell;

//@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,copy)NSString *formatterDate;
@property(nonatomic,strong)UITextField *textFieldS;

@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,strong)NSArray *arrDataS;
//@property (nonatomic , strong) NSMutableArray *proviceArr;
//@property (nonatomic , strong) NSMutableArray *cityArr;
//@property (nonatomic , strong) NSMutableArray *cityAreamArr;

@property (nonatomic , strong) NSArray *schoolArr;


+ (EducateTableViewCell *)cellWithTableView:(UITableView *)tableview;@end
