//
//  WeatherCell.m
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(WeatherModel *)model{
    self.lab_day.text = [NSString stringWithFormat:@"星期%@",model.week];
    
    NSString * weatherday = [model.day objectAtIndex:1];
    
    if ([weatherday isEqualToString:@"多云"] || [weatherday isEqualToString:@"阴"] ) {
        self.image_weather.image = [UIImage imageNamed:@"多云"];
    }else if ([weatherday isEqualToString:@"晴"]){
        self.image_weather.image = [UIImage imageNamed:@"太阳"];
    }else if ([weatherday isEqualToString:@"下雪"]){
        self.image_weather.image = [UIImage imageNamed:@"下雪"];
    }else if ([weatherday isEqualToString:@"雾"]){
        self.image_weather.image = [UIImage imageNamed:@"雾"];
    }else if ([weatherday isEqualToString:@"小雨"] || [weatherday isEqualToString:@"阵雨"]){
        self.image_weather.image = [UIImage imageNamed:@"小雨"];
    }else if ([weatherday isEqualToString:@"中雨"]){
        self.image_weather.image = [UIImage imageNamed:@"中雨"];
    }else if ([weatherday isEqualToString:@"大雨"]){
        self.image_weather.image = [UIImage imageNamed:@"大雨"];
    }else if ([weatherday isEqualToString:@"雷阵雨"]){
        self.image_weather.image = [UIImage imageNamed:@"雷阵雨"];
    }
    
    
    if(model.night.count > 0){
    
        if ([[model.day objectAtIndex:2] integerValue] > [[model.night objectAtIndex:2] integerValue]) {
            
            self.lab_temperature.text = [NSString stringWithFormat:@"%@° ～ %@°", [model.night objectAtIndex:2] ,[model.day objectAtIndex:2]];;

        }else{
            
            self.lab_temperature.text = [NSString stringWithFormat:@"%@° ～ %@°",[model.day objectAtIndex:2],[model.night objectAtIndex:2]];;
        }

    }else{
        
        self.lab_temperature.text = [NSString stringWithFormat:@"%@°",[model.day objectAtIndex:2]];;

    }
    
    self.lab_weather.text = weatherday;

}
@end
