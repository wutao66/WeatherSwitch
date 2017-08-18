//
//  WeatherModel.h
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic,copy) NSString * week;
@property (nonatomic,strong) NSDictionary * info;
@property (nonatomic,strong) NSArray * dawn;
@property (nonatomic,strong) NSArray * day;
@property (nonatomic,strong) NSArray * night;


@end
