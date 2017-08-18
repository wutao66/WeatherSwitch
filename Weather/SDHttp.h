//
//  SDHttp.h
//  SDHttp
//
//  Created by Macx on 2017/8/17.
//  Copyright © 2017年 wt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDHttp : NSObject

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
