//
//  CurrentWeatherView.m
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import "CurrentWeatherView.h"
#import "UIView+Add.h"

#define USER_DEFAULT        [NSUserDefaults standardUserDefaults]


@implementation CurrentWeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lab_date = [[UILabel alloc] initWithFrame:CGRectMake(22, 16, 240, 20)];
        _lab_date.textColor = [UIColor whiteColor];
        _lab_date.font = [UIFont systemFontOfSize:11];
        _lab_date.text = @"暂无数据";
        [self addSubview:_lab_date];
        
        _lab_city = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 40 - 22, 16, 40, 20)];
        _lab_city.textColor = [UIColor whiteColor];
        _lab_city.font = [UIFont systemFontOfSize:14];
        _lab_city.text = [USER_DEFAULT objectForKey:@"SDcity"]?[USER_DEFAULT objectForKey:@"SDcity"]:@"广州";
        [self addSubview:_lab_city];//定位
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_lab_city.text];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"Weather定位"];
        attch.bounds = CGRectMake(-2, -2, 10, 13);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];
        _lab_city.attributedText = attri;

        [_lab_city sizeToFit];
        
        _lab_city.frame = CGRectMake(frame.size.width - _lab_city.sd_width - 22 - 5, 16, _lab_city.sd_width + 10, 20);
        
        
        _image_weather = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - 70, 44, 140, 140)];
        _image_weather.image = [UIImage imageNamed:@"Max晴"];
        _image_weather.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_image_weather];

        _lab_temperature = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2 - 40, _image_weather.sd_maxY + 10, 80, 80)];
        _lab_temperature.textColor = [UIColor whiteColor];
        _lab_temperature.adjustsFontSizeToFitWidth = YES;
        _lab_temperature.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _lab_temperature.text = @"暂无数据";
        _lab_temperature.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_temperature];
        _lab_temperature.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _lab_temperature.font = [UIFont systemFontOfSize:300.f];

        
        _lab_updateTime = [[UILabel alloc] initWithFrame:CGRectMake(_lab_temperature.sd_maxX, _lab_temperature.sd_y + _lab_temperature.sd_height/2, 100, 30)];
        _lab_updateTime.textColor = [UIColor whiteColor];
        _lab_updateTime.font = [UIFont systemFontOfSize:12];
        _lab_updateTime.text = @"";
        _lab_updateTime.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lab_updateTime];
        
        
        _lab_weather = [[UILabel alloc] initWithFrame:CGRectMake(0, _lab_temperature.sd_maxY + 4, frame.size.width, 20)];
        _lab_weather.textColor = [UIColor whiteColor];
        _lab_weather.font = [UIFont systemFontOfSize:14];
        _lab_weather.text = @"暂无数据";
        _lab_weather.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_weather];
        
        _lab_humidity = [[UILabel alloc] initWithFrame:CGRectMake(0, _lab_weather.sd_maxY + 4, frame.size.width, 20)];
        _lab_humidity.textColor = [UIColor whiteColor];
        _lab_humidity.font = [UIFont systemFontOfSize:14];
        _lab_humidity.text = @"暂无数据";
        _lab_humidity.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_humidity];

        
        _lab_windspeed = [[UILabel alloc] initWithFrame:CGRectMake(0, _lab_humidity.sd_maxY + 4, frame.size.width, 20)];
        _lab_windspeed.textColor = [UIColor whiteColor];
        _lab_windspeed.font = [UIFont systemFontOfSize:14];
        _lab_windspeed.text = @"暂无数据";
        _lab_windspeed.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_windspeed];
        
        
        _lab_breathindex = [[UILabel alloc] initWithFrame:CGRectMake(0, _lab_windspeed.sd_maxY + 4, frame.size.width, 20)];
        _lab_breathindex.textColor = [UIColor whiteColor];
        _lab_breathindex.font = [UIFont systemFontOfSize:14];
        _lab_breathindex.text = @"暂无数据";
        _lab_breathindex.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_breathindex];

        
    }
    
    return self;
}
- (void)refreshWeatherData:(WeatherOtherModel *)model{

    if (model.date) {
        self.lab_date.text = model.date;
    }
    
    if (model.updateTime) {
        _lab_updateTime.text = [NSString stringWithFormat:@"[%@]更新",model.updateTime];
    }
    
    if (model.city) {
        self.lab_city.text = model.city;
    }
    
    if (model.weather) {

        if ([model.weather isEqualToString:@"多云"] || [model.weather isEqualToString:@"阴"] ) {
            self.image_weather.image = [UIImage imageNamed:@"Max多云"];
        }else if ([model.weather isEqualToString:@"晴"]){
            self.image_weather.image = [UIImage imageNamed:@"Max晴"];
        }else if ([model.weather isEqualToString:@"下雪"]){
            self.image_weather.image = [UIImage imageNamed:@"Max下雪"];
        }else if ([model.weather isEqualToString:@"雾"]){
            self.image_weather.image = [UIImage imageNamed:@"Max雾"];
        }else if ([model.weather isEqualToString:@"小雨"] || [model.weather isEqualToString:@"阵雨"]){
            self.image_weather.image = [UIImage imageNamed:@"Max下雨"];
        }else if ([model.weather isEqualToString:@"中雨"]){
            self.image_weather.image = [UIImage imageNamed:@"Max下雨"];
        }else if ([model.weather isEqualToString:@"大雨"]){
            self.image_weather.image = [UIImage imageNamed:@"Max下雨"];
        }else if ([model.weather isEqualToString:@"雷阵雨"]){
            self.image_weather.image = [UIImage imageNamed:@"Max下雨"];
        }
    
    }

    if (model.temperature) {
        self.lab_temperature.text = [NSString stringWithFormat:@"%@°",model.temperature];
    }

    if (model.weather) {
        self.lab_weather.text = [NSString stringWithFormat:@"天气: %@",model.weather];
    }

    if (model.humidity) {
        self.lab_humidity.text = model.humidity;
    }

    if (model.windspeed) {
        self.lab_windspeed.text = model.windspeed;
    }

    if (model.breathindex) {
        self.lab_breathindex.text = model.breathindex;
    }

    
    _lab_city.text = [USER_DEFAULT objectForKey:@"SDcity"]?[USER_DEFAULT objectForKey:@"SDcity"]:@"广州";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_lab_city.text];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"Weather定位"];
    attch.bounds = CGRectMake(-2, -2, 10, 13);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    _lab_city.attributedText = attri;
    
    [_lab_city sizeToFit];


}
@end
