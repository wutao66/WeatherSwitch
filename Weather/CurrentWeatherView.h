//
//  CurrentWeatherView.h
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherOtherModel.h"

@interface CurrentWeatherView : UIView

@property (nonatomic,strong) UILabel * lab_date;

@property (nonatomic,strong) UILabel * lab_city;

@property (nonatomic,strong) UIImageView * image_weather;

@property (nonatomic,strong) UILabel * lab_temperature;

@property (nonatomic,strong) UILabel * lab_updateTime;

@property (nonatomic,strong) UILabel * lab_weather;

@property (nonatomic,strong) UILabel * lab_humidity;

@property (nonatomic,strong) UILabel * lab_windspeed;

@property (nonatomic,strong) UILabel * lab_breathindex;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)refreshWeatherData:(WeatherOtherModel *)model;

@end
