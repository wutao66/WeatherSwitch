//
//  SDweatherViewController.m
//  Sendong_Sport
//
//  Created by Macx on 2016/12/12.
//  Copyright © 2016年 Sendong. All rights reserved.
//

#import "SDweatherViewController.h"
#import "SDHttp.h"
#import "CurrentWeatherView.h"
#import "UIView+Add.h"
#import "WeatherCell.h"
#import "WeatherModel.h"
#import "WeatherOtherModel.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "PINCache.h"
#import "CityChooseViewController.h"

//屏幕宽、高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define USER_DEFAULT        [NSUserDefaults standardUserDefaults]
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface SDweatherViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) CurrentWeatherView * currentWeatherView;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * arrary_data;

@property (nonatomic, strong) UIView * mianView;

@end

@implementation SDweatherViewController


- (NSMutableArray *)arrary_data {
    if (!_arrary_data) {
        _arrary_data = [NSMutableArray array];
    }
    return _arrary_data;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self loadUI];
    
    [self loadCache];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)rigthtap{

    //城市选择
    CityChooseViewController *vc = [CityChooseViewController new];
    //选择以后的回调
    [vc returnCityInfo:^(NSString *province, NSString *area) {

            [USER_DEFAULT setObject:area forKey:@"SDcity"];
        
            [self loadWeb:area andHasHUD:YES];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)loadMainView:(NSString *)weather{
    if ([weather isEqualToString:@"多云"] || [weather isEqualToString:@"阴"] ) {
        [self setGradientViewStartColor:SDColor(70, 98, 255, 1) andendColor:SDColor(140, 201, 254, 1)];
    }else if ([weather isEqualToString:@"下雪"]){
        [self setGradientViewStartColor:SDColor(31, 21, 239, 1) andendColor:SDColor(120, 232, 252, 1)];
    }else if ([weather isEqualToString:@"雾"]){
        [self setGradientViewStartColor:SDColor(122, 85, 250, 1) andendColor:SDColor(206, 174, 223, 1)];
    }else if ([weather isEqualToString:@"小雨"] || [weather isEqualToString:@"中雨"] || [weather isEqualToString:@"大雨"] || [weather isEqualToString:@"雷阵雨"] || [weather isEqualToString:@"阵雨"]){
        [self setGradientViewStartColor:SDColor(33, 169, 239, 1) andendColor:SDColor(120,252, 179, 1)];
    }else{
        [self setGradientViewStartColor:SDColor(250, 90, 57, 1) andendColor:SDColor(247, 144, 44, 1)];
    }
}

- (void)loadUI{

    self.mianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_mianView];
    
    [self loadMainView:[USER_DEFAULT objectForKey:@"Weather_state"]];
    
    self.currentWeatherView  = [[CurrentWeatherView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 380)];
    [self.view addSubview:_currentWeatherView];
    
    self.currentWeatherView.lab_city.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * switchWeather = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rigthtap)];
    [_currentWeatherView.lab_city addGestureRecognizer:switchWeather];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.currentWeatherView.sd_maxY, SCREEN_WIDTH, SCREEN_HEIGHT - self.currentWeatherView.sd_maxY)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeatherCell class]) bundle:nil] forCellReuseIdentifier:@"WeatherCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setGradientViewStartColor:(UIColor*)startColor andendColor:(UIColor*)endColor{
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = self.view.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)startColor.CGColor,
                             (id)endColor.CGColor];
    //  设置三种颜色变化点，取值范围 0.0~1.0
    //        gradientLayer.locations = @[@(0.1f) ,@(0.4f)];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //  添加渐变色到创建的 UIView 上去
    [_mianView.layer addSublayer:gradientLayer];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrary_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
    
    if (self.arrary_data.count > 0) {
        WeatherModel *listModel = self.arrary_data[indexPath.row];
        if (listModel) {
            cell.model = listModel;
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadCache{
    
    

    [[PINCache sharedCache] objectForKey:[USER_DEFAULT objectForKey:@"SDcity"]?[USER_DEFAULT objectForKey:@"SDcity"]:@"广州" block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        
        if(object){
            
            [self setJSONData:object andWebpath:[USER_DEFAULT objectForKey:@"SDcity"]?[USER_DEFAULT objectForKey:@"SDcity"]:@"广州" andBackstageRefresh:YES];

        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{

            [self loadWeb:[USER_DEFAULT objectForKey:@"SDcity"]?[USER_DEFAULT objectForKey:@"SDcity"]:@"广州" andHasHUD:YES];

            });

        }
    }];
    
}

- (void)loadWeb:(NSString *)path andHasHUD:(BOOL)isHUD{
    
    if (isHUD) {
        [SVProgressHUD show];
    }
    
    [SDHttp getWithURL:path params:nil success:^(id json) {
        
        if([[json objectForKey:@"error_code"] integerValue] == 0){
            
            [SVProgressHUD dismiss];
            
            [[PINCache sharedCache] setObject:json forKey:[[NSURL URLWithString:path] absoluteString]];
            
            [self setJSONData:json andWebpath:path andBackstageRefresh:NO];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json objectForKey:@"reason"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取天气失败,请稍后再试"];
    }];
}

- (void)setJSONData:(id)json andWebpath:(NSString *)path andBackstageRefresh:(BOOL)isRefresh{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    NSArray * array = [WeatherModel mj_objectArrayWithKeyValuesArray:[[json[@"result"] objectForKey:@"data"] objectForKey:@"weather"]];
    
    NSDictionary * dict = [json[@"result"] objectForKey:@"data"];
    
    NSMutableArray *modeArr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i ++){
        
        WeatherModel *model = array[i];
        WeatherModel *otherModel = [WeatherModel mj_objectWithKeyValues:model.info];
        
        model.dawn = otherModel.dawn;
        model.day = otherModel.day;
        model.night = otherModel.night;
        
        [modeArr addObject:model];
    }
    
    // refresh   _currentWeatherView
    
    WeatherOtherModel *headModel = [[WeatherOtherModel alloc] init];
    headModel.date = [NSString stringWithFormat:@"%@ %@ 星期%@",[[dict objectForKey:@"realtime"] objectForKey:@"date"],[[dict objectForKey:@"realtime"] objectForKey:@"time"],[(WeatherModel *)modeArr.firstObject week]];
    
    NSDictionary * dict_weather = [[dict objectForKey:@"realtime"] objectForKey:@"weather"];
    NSDictionary * dict_wind = [[dict objectForKey:@"realtime"] objectForKey:@"wind"];
        
    NSDictionary * dict_pm25;
    if ([[dict objectForKey:@"pm25"] count] > 0) {
        if ([[[dict objectForKey:@"pm25"] allKeys] containsObject:@"pm25"]) {
            dict_pm25 = [[dict objectForKey:@"pm25"] objectForKey:@"pm25"];
        }else{
            dict_pm25 = @{@"curPm":@"未知",@"quality":@""};
        }
    }else{
        dict_pm25 = @{@"curPm":@"未知",@"quality":@""};
    }
    
    headModel.weather = [dict_weather objectForKey:@"info"];
    headModel.temperature = [dict_weather objectForKey:@"temperature"];
    headModel.updateTime = [[dict objectForKey:@"realtime"] objectForKey:@"time"];
    headModel.humidity = [NSString stringWithFormat:@"湿度: %@%@",[dict_weather objectForKey:@"humidity"],@"%"];
    headModel.windspeed = [NSString stringWithFormat:@"风速: %@ %@",[dict_wind objectForKey:@"direct"],[dict_wind objectForKey:@"power"]];
    headModel.breathindex = [NSString stringWithFormat:@"空气指数: %@ (%@)",[dict_pm25 objectForKey:@"curPm"],[dict_pm25 objectForKey:@"quality"]];
    
    [USER_DEFAULT setObject:headModel.weather forKey:@"Weather_state"];
        
    dispatch_async(dispatch_get_main_queue(), ^{

    [_currentWeatherView refreshWeatherData:headModel];
    
    [self loadMainView:headModel.weather];
    
    self.arrary_data = [NSMutableArray array];
        
    [self.arrary_data addObjectsFromArray:modeArr];
    
    [self.tableView reloadData];
    
    });

    if (isRefresh) {
        [self loadWeb:path andHasHUD:NO];
    }
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
