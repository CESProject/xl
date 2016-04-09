//
//  MineBasicView.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MineBasicView.h"

@implementation MineBasicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAddSubviews];
    }
    return self;
}

- (void)createAddSubviews
{
    self.backgroundColor = [UIColor whiteColor];
   
    UIView *firstSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 120)];
    self.firstSection = firstSection;
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    nameLab.text = @"真实姓名";
    nameLab.font = [UIFont systemFontOfSize:15.0];
    nameLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *nameConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2 , 0, DEF_SCREEN_WIDTH/2-20, 30)];
    nameConLab.font = [UIFont systemFontOfSize:15.0];
    nameConLab.textAlignment = NSTextAlignmentRight;

    self.nameLab = nameLab;
    self.nameConLab = nameConLab;
    [firstSection addSubview:nameLab];
    [firstSection addSubview:nameConLab];
    
   
    UILabel *sexLab = [[UILabel alloc]initWithFrame:CGRectMake(20, nameConLab.mj_h + 1, 70, 30)];
    sexLab.text = @"性别";
    sexLab.font = [UIFont systemFontOfSize:15.0];
    sexLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *sexConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, nameConLab.mj_h + 1, DEF_SCREEN_WIDTH/2-20, 30)];
    sexConLab.font = [UIFont systemFontOfSize:15.0];
    sexConLab.textAlignment = NSTextAlignmentRight;
    
    self.sexLab = sexLab;
    self.sexConLab = sexConLab;
    [firstSection addSubview:sexLab];
    [firstSection addSubview:sexConLab];
    
    UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(20, sexConLab.mj_h + sexConLab.mj_y + 1, 70, 30)];
    dateLab.text = @"出生日期";
    dateLab.font = [UIFont systemFontOfSize:15.0];
    dateLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *dateConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, sexConLab.mj_h + sexConLab.mj_y + 1, DEF_SCREEN_WIDTH/2-20, 30)];
    dateConLab.font = [UIFont systemFontOfSize:15.0];
    dateConLab.textAlignment = NSTextAlignmentRight;
    
    self.dateLab = dateLab;
    self.dateConLab = dateConLab;
    [firstSection addSubview:dateLab];
    [firstSection addSubview:dateConLab];
    
    UILabel *workLab = [[UILabel alloc]initWithFrame:CGRectMake(20, dateConLab.mj_h + dateConLab.mj_y + 1, 70, 30)];
    workLab.text = @"从事行业";
    workLab.font = [UIFont systemFontOfSize:15.0];
    workLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *workConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, dateConLab.mj_h + dateConLab.mj_y + 1, DEF_SCREEN_WIDTH/2-20, 30)];
    workConLab.font = [UIFont systemFontOfSize:15.0];
    workConLab.textAlignment = NSTextAlignmentRight;
    
    self.workLab = workLab;
    self.workConLab = workConLab;
    [firstSection addSubview:workLab];
    [firstSection addSubview:workConLab];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = GRAYCOLOR;
    lineV.frame = CGRectMake(0, [self.workConLab bottom]+5, DEF_SCREEN_WIDTH, 5);
    [firstSection addSubview:lineV];
    firstSection.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstSection];
    
    UIView *secondSection = [[UIView alloc]initWithFrame:CGRectMake(0, firstSection.mj_y + firstSection.mj_h + 20, self.mj_w, 120)];
    self.secondSection = secondSection;
    
    UILabel *linkmanLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 30)];
    linkmanLab.text = @"联系人";
    linkmanLab.font = [UIFont systemFontOfSize:15.0];
    linkmanLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *linkmanConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2 , 0, DEF_SCREEN_WIDTH/2-20, 30)];
    linkmanConLab.font = [UIFont systemFontOfSize:15.0];
    linkmanConLab.textAlignment = NSTextAlignmentRight;
    
    self.linkmanLab = linkmanLab;
    self.linkmanConLab = linkmanConLab;
    [secondSection addSubview:linkmanLab];
    [secondSection addSubview:linkmanConLab];
    
    
    UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(20, linkmanConLab.mj_h + 1, 70, 30)];
    phoneLab.text = @"电话";
    phoneLab.font = [UIFont systemFontOfSize:15.0];
    phoneLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *phoneConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, linkmanConLab.mj_h + linkmanConLab.mj_y + 1, DEF_SCREEN_WIDTH/2-20, 30)];
    phoneConLab.font = [UIFont systemFontOfSize:15.0];
    phoneConLab.textAlignment = NSTextAlignmentRight;
    
    self.phoneLab = phoneLab;
    self.phoneConLab = phoneConLab;
    [secondSection addSubview:phoneLab];
    [secondSection addSubview:phoneConLab];
    
    UILabel *emailLab = [[UILabel alloc]initWithFrame:CGRectMake(20, phoneConLab.mj_h + phoneConLab.mj_y + 1, 70, 30)];
    emailLab.text = @"邮箱";
    emailLab.font = [UIFont systemFontOfSize:15.0];
    emailLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *emailConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, phoneConLab.mj_h + phoneConLab.mj_y + 1,DEF_SCREEN_WIDTH/2-20, 30)];
    emailConLab.font = [UIFont systemFontOfSize:15.0];
    emailConLab.textAlignment = NSTextAlignmentRight;
    
    self.emailConLab = emailConLab;
    self.emailLab = emailLab;
    [secondSection addSubview:emailLab];
    [secondSection addSubview:emailConLab];
    
    UILabel *QQLab = [[UILabel alloc]initWithFrame:CGRectMake(20, emailConLab.mj_h + emailConLab.mj_y + 1, 70, 30)];
    QQLab.text = @"QQ";
    QQLab.font = [UIFont systemFontOfSize:15.0];
    QQLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *QQConLab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2, emailConLab.mj_h + emailConLab.mj_y + 1,DEF_SCREEN_WIDTH/2-20, 30)];
    QQConLab.font = [UIFont systemFontOfSize:15.0];
    QQConLab.textAlignment = NSTextAlignmentRight;
    [secondSection addSubview:QQLab];
    [secondSection addSubview:QQConLab];
    
    self.QQConLab = QQConLab;
    self.QQLab = QQLab;
    secondSection.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondSection];
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, firstSection.mj_y + firstSection.mj_h, self.mj_w, 5)];
//    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    [self addSubview:lineView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
