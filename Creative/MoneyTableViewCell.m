//
//  MoneyTableViewCell.m
//  Creative
//
//  Created by Mr Wei on 16/1/18.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MoneyTableViewCell.h"

@implementation MoneyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAddSubviews];
    }
    return self;
}

- (void)createAddSubviews
{
    
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    self.backView = backView;
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont systemFontOfSize:17.0];
    self.titleLab = titleLab;
    
    UIImageView *dateIm = [[UIImageView alloc]init];
    dateIm.image = [UIImage imageNamed:@"clock"];
    self.dateIm = dateIm;
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.font = [UIFont systemFontOfSize:12.0];
    self.dateLab = dateLab;
    
    UILabel *moneyLab = [[UILabel alloc]init];
    moneyLab.text = @"投资资金";
    moneyLab.textColor = [UIColor grayColor];
    moneyLab.font = [UIFont systemFontOfSize:15.0];
    self.moneyLab = moneyLab;
    
    UILabel *moneyConLab = [[UILabel alloc]init];
    moneyConLab.textColor = [UIColor grayColor];
    self.moneyConLab = moneyConLab;
    
    UILabel *typeLab = [[UILabel alloc]init];
    typeLab.text = @"投资类型";
    typeLab.font = [UIFont systemFontOfSize:15.0];
    typeLab.textColor = [UIColor grayColor];
    self.typeLab = typeLab;
    
    UILabel *typeConLab = [[UILabel alloc]init];
    typeConLab.textColor = [UIColor grayColor];
    self.typeConLab = typeConLab;
    
    UILabel *guildLab = [[UILabel alloc]init];
    guildLab.text = @"投资行业";
    guildLab.textColor = [UIColor grayColor];
    guildLab.font = [UIFont systemFontOfSize:15.0];
    self.guildLab = guildLab;
   
    UILabel *guildConLab = [[UILabel alloc]init];
    guildConLab.textColor = [UIColor grayColor];
    self.guildConLab = guildConLab;
    
    [backView addSubview:titleLab];
    [backView addSubview:dateIm];
    [backView addSubview:dateLab];
    [backView addSubview:moneyLab];
    [backView addSubview:moneyConLab];
    [backView addSubview:typeLab];
    [backView addSubview:typeConLab];
    [backView addSubview:guildLab];
    [backView addSubview:guildConLab];
    
    [self.contentView addSubview:backView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 5, self.mj_w, 135);
    self.titleLab.frame = CGRectMake(10, 5, self.mj_w - 20, 25);
    self.dateIm.frame = CGRectMake(10, self.titleLab.mj_h + 10, 15, 15);
    self.dateLab.frame = CGRectMake(self.dateIm.mj_x + self.dateIm.mj_w, self.dateIm.mj_y - 3, self.mj_w - self.dateIm.mj_w - self.dateIm.mj_x - 20, 20);
    self.moneyLab.frame = CGRectMake(10, self.dateIm.mj_y + self.dateIm.mj_h + 5, 70, 20);
    self.moneyConLab.frame = CGRectMake(self.moneyLab.mj_w + self.moneyLab.mj_x, self.moneyLab.mj_y, self.mj_w - self.moneyLab.mj_w - self.moneyLab.mj_x, 20);
    self.typeLab.frame = CGRectMake(10, self.moneyLab.mj_y + self.moneyLab.mj_h + 5, 70, 20);
    self.typeConLab.frame = CGRectMake(self.typeLab.mj_w + self.typeLab.mj_x, self.typeLab.mj_y, self.mj_w - self.typeLab.mj_w - self.typeLab.mj_x, 20);
    
    self.guildLab.frame = CGRectMake(10, self.typeLab.mj_y + self.typeLab.mj_h + 5, 70, 20);
    self.guildConLab.frame = CGRectMake(self.guildLab.mj_w + self.guildLab.mj_x, self.guildLab.mj_y, self.mj_w - self.guildLab.mj_w - self.guildLab.mj_x, 20);
}

+ (MoneyTableViewCell *)cellWithTabelView:(UITableView *)tableView
{
    static NSString *PJcell = @"moneyCellID";
    MoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PJcell];
    if (cell == nil) {
        cell = [[MoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PJcell];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
