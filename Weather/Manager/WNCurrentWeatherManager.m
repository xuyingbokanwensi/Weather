//
//  WNCurrentWeatherManager.m
//  Weather
//
//  Created by WuNan on 15/6/14.
//  Copyright (c) 2015年 WuNan. All rights reserved.
//

#import "WNCurrentWeatherManager.h"
#import "WNNetWorkManager.h"
#import "WNLocationManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation WNCurrentWeatherManager
+(void)getCurrentWeatherByCityName:(NSString *)cityName success:(void (^)(id))successBlock{
    NSDictionary * params = @{@"q":cityName};
    [self getCurrentWeatherByParams:params success:successBlock];
}
+(void)getCurrentWeatherByID:(NSString *)id success:(void (^)(id))successBlock{
    NSDictionary * params = @{@"id":id};
    [self getCurrentWeatherByParams:params success:successBlock];
}
+(void)getCurrentWeatherByCurrentLocationSuccess:(void (^)( id responseObject))successBlock {
    [[WNLocationManager shareInstance]getCurrentLocationSuccess:^(CLLocationManager *manager, CLLocation *location) {
        [self getCurrentWeatherByLocation:location success:successBlock];
    } failed:^(CLLocationManager *manager, NSError *err) {
        [SVProgressHUD showErrorWithStatus:@"Can't Get Current Location!"];
    }];
}
+(void)getCurrentWeatherByLocation:(CLLocation*)location success:(void (^)( id responseObject))successBlock {
    NSDictionary * params = @{@"lat":@(location.coordinate.latitude),
                              @"lon":@(location.coordinate.longitude)
                              };
    [self getCurrentWeatherByParams:params success:successBlock];
}

+(void)getCurrentWeatherByParams:(NSDictionary*)params success:(void (^)( id responseObject))successBlock{
    NSString* urlStr = @"http://api.openweathermap.org/data/2.5/weather";
    NSMutableDictionary* tempParams = [params mutableCopy];
    [tempParams addEntriesFromDictionary:@{
                                           @"lang":@"zh_cn",
                                           @"units":@"metric"
                                           }];
    [WNNetWorkManager GET:urlStr params:tempParams success:successBlock];
}




@end
