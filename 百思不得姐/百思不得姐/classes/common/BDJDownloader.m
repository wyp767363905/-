//
//  BDJDownloader.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "BDJDownloader.h"

@implementation BDJDownloader

+ (void)downloadWithUrlString:(NSString *)urlString finish:(FINISHBLOCK)finishBlock failure:(FAILBLOCK)failBlock{
    
    //1.NSURL
    NSURL *url = [NSURL URLWithString:urlString];
    //2.NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    //4.NSURLSessionDataTask
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            failBlock(error);
        }else{
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            if (httpRes.statusCode == 200) {
                finishBlock(data);
            }else{
                NSError *tmpError = [NSError errorWithDomain:urlString code:httpRes.statusCode userInfo:@{@"msg":@"请求数据失败"}];
                failBlock(tmpError);
            }
        }
        
    }];
    //5.下载
    [task resume];
    
}

@end
