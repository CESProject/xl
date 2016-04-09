//
//  CareerTableViewCell.h
//  addcellTest
//
//  Created by Mr Wei on 16/1/25.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "informationModel.h"

@interface CareerTableViewCell : UITableViewCell<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic , strong) UIView *backGroundView;

@property (nonatomic , strong) UILabel *proviceLab;
@property (nonatomic , strong) UITextField *proviceText;
@property (nonatomic , strong) UILabel *cityLab;
@property (nonatomic , strong) UITextField *cityText;
@property (nonatomic , strong) UILabel *sectionLab;
@property (nonatomic , strong) UITextField *sectionText;
@property (nonatomic , strong) UILabel *dateLab;
@property (nonatomic , strong) UITextField *dateText1;
@property (nonatomic , strong) UITextField *dateText2;
@property (nonatomic , strong) UILabel *branchLab;
@property (nonatomic , strong) UITextField *branchText;

@property (nonatomic , strong) UILabel *textLab;
@property (nonatomic , strong) UIImageView *imCl1;
@property (nonatomic , strong) UIImageView *imCl2;

@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;
@property (nonatomic , strong) UIView *line4;
@property (nonatomic , strong) UIView *line5;
@property (nonatomic , strong) UIView *line6;

@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIButton *delBtn;

@property(nonatomic,strong)UIView *datePut;
@property(nonatomic,copy)NSString *formatterDate;
@property(nonatomic,strong)UITextField *textFieldS;

@property(nonatomic,copy)NSString *strPicker;
@property(nonatomic,strong)UIView *picker;
@property(nonatomic,strong)UIPickerView *pick;
@property(nonatomic,strong)NSArray *arrDataS;
@property (nonatomic , strong) NSMutableArray *proviceArr;
@property (nonatomic , strong) NSMutableArray *cityArr;
@property (nonatomic , strong) NSMutableArray *cityAreamArr;

@property (nonatomic , strong) informationModel *infoModel;

+ (CareerTableViewCell *)cellWithTableView:(UITableView *)tableview;

@end
