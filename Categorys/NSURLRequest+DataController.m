//
//  NSURLRequest+DataController.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/1.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSURLRequest+DataController.h"

@implementation NSURLRequest (DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host {
    return YES;
}
@end
