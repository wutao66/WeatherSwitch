//
//  WeatherCell.h
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab_day;
@property (weak, nonatomic) IBOutlet UIImageView *image_weather;
@property (weak, nonatomic) IBOutlet UILabel *lab_temperature;
@property (weak, nonatomic) IBOutlet UILabel *lab_weather;


@property (strong, nonatomic) WeatherModel * model;

@end
