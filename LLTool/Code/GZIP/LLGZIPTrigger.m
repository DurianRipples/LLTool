//
//  LLGZIPTrigger.m
//  LLTool
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLGZIPTrigger.h"
#import "GZIP.h"

@implementation LLGZIPTrigger

- (void)sendGZIPString:(NSString *)string {
    NSString *requestURL = @"https://stadig.ifeng.com/vplayer.js";
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestURL parameters:nil error:nil];
    request.timeoutInterval = 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[[string dataUsingEncoding:NSUTF8StringEncoding] gzippedData]];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        ;
    }] resume];
}

@end
