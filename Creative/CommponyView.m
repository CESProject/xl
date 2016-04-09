//
//  CommponyView.m
//  Creative
//
//  Created by Mr Wei on 16/1/16.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "CommponyView.h"

@implementation CommponyView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateAddSubviewS];
    }
    return self;
}

- (void)CreateAddSubviewS
{
    self.backgroundColor = [UIColor whiteColor];
    UITextField *name = [[UITextField alloc]init];
    name.placeholder = @"真实姓名";
    self.name = name;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor grayColor];
    self.line1 = line1;
    
    UITextField *identity = [[UITextField alloc]init];
    identity.placeholder = @"身份证号";
    self.identity = identity;
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor grayColor];
    self.line2 = line2;
    
    UITextField *phone = [[UITextField alloc]init];
    phone.placeholder = @"联系电话";
    self.phone = phone;
    
    UIView *line3= [[UIView alloc]init];
    line3.backgroundColor = [UIColor grayColor];
    self.line3 = line3;
    
    UITextField *QQnum = [[UITextField alloc]init];
    QQnum.placeholder = @"QQ";
    self.QQnum = QQnum;
    
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor grayColor];
    self.line4 = line4;
    
    UITextField *Emailnum = [[UITextField alloc]init];
    Emailnum.placeholder = @"Email";
    self.Emailnum = Emailnum;
    
    UIView *line5 = [[UIView alloc]init];
    line5.backgroundColor = [UIColor grayColor];
    self.line5 = line5;
    
    UITextField *weiNum = [[UITextField alloc]init];
    weiNum.placeholder = @"微信";
    self.weiNum = weiNum;
    
    UIView *line6 = [[UIView alloc]init];
    line6.backgroundColor = [UIColor grayColor];
    self.line6 = line6;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 4;
    sureBtn.layer.borderWidth = 1;
    sureBtn.tintColor = GREENCOLOR;
    sureBtn.layer.borderColor = GREENCOLOR.CGColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.sureBtn = sureBtn;
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.tintColor = GREENCOLOR;
    cancleBtn.layer.borderColor = GREENCOLOR.CGColor;
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.cancleBtn = cancleBtn;
    
//    [self addSubview:name];
//    [self addSubview:identity];
//    [self addSubview:phone];
//    [self addSubview:QQnum];
//    [self addSubview:Emailnum];
//    [self addSubview:weiNum];
    [self addSubview:sureBtn];
    [self addSubview:cancleBtn];
//    [self addSubview:line1];
//    [self addSubview:line2];
//    [self addSubview:line2];
//    [self addSubview:line3];
//    [self addSubview:line4];
//    [self addSubview:line5];
//    [self addSubview:line6];
    
    
}

- (void)layoutSubviews
{
    self.name.frame = CGRectMake(10, 0, self.mj_w - 20, 40);
    self.line1.frame = CGRectMake(self.name.mj_x, self.name.mj_y + self.name.mj_h, self.mj_w - 20, 1);
    
    self.identity.frame = CGRectMake(self.name.mj_x, self.name.mj_y + self.name.mj_h + 15, self.mj_w - 20, 40);
    self.line2.frame = CGRectMake(self.name.mj_x, self.identity.mj_y + self.identity.mj_h, self.mj_w - 20, 1);
    
    self.phone.frame = CGRectMake(self.name.mj_x, self.identity.mj_y + self.identity.mj_h + 15, self.mj_w - 20, 40);
    self.line3.frame = CGRectMake(self.name.mj_x, self.phone.mj_y + self.phone.mj_h, self.mj_w - 20, 1);
    
    self.QQnum.frame = CGRectMake(self.name.mj_x, self.phone.mj_y + self.phone.mj_h + 15, self.mj_w - 20, 40);
    self.line4.frame = CGRectMake(self.name.mj_x, self.QQnum.mj_y + self.QQnum.mj_h, self.mj_w - 20, 1);
    
    self.Emailnum.frame =  CGRectMake(self.name.mj_x , self.QQnum.mj_y + self.QQnum.mj_h + 15,  self.mj_w - 20, 40);
    self.line5.frame = CGRectMake(self.name.mj_x, self.Emailnum.mj_y + self.Emailnum.mj_h, self.mj_w - 20, 1);
    
    self.weiNum.frame =  CGRectMake(self.name.mj_x , self.Emailnum.mj_y + self.Emailnum.mj_h + 15,  self.mj_w - 20, 40);
    self.line6.frame = CGRectMake(self.name.mj_x, self.weiNum.mj_y + self.weiNum.mj_h, self.mj_w - 20, 1);
    
    UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.mj_w - 20, 50)];
    msgLab.text = @"企业报名尚未开放";
    msgLab.textAlignment = NSTextAlignmentCenter;
    msgLab.font = [UIFont systemFontOfSize:18];
    msgLab.textColor = [UIColor cyanColor];
    [self addSubview:msgLab];
    
    self.sureBtn.frame = CGRectMake(msgLab.mj_x + 10, msgLab.mj_y + msgLab.mj_h + 30, (self.mj_w - 60)/ 2 , 40);
    
    self.cancleBtn.frame = CGRectMake(self.sureBtn.mj_x + self.sureBtn.mj_w + 10, msgLab.mj_y + msgLab.mj_h+ 30, (self.mj_w - 60)/ 2 , 40);
    
//    self.sureBtn.frame = CGRectMake(self.name.mj_x + 10, self.weiNum.mj_y + self.weiNum.mj_h + 30, (self.mj_w - 60)/ 2 , 40);
//    
//    self.cancleBtn.frame = CGRectMake(self.sureBtn.mj_x + self.sureBtn.mj_w + 10, self.weiNum.mj_y + self.weiNum.mj_h + 30, (self.mj_w - 60)/ 2 , 40);
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
