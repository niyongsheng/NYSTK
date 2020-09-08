//
//  NYSTKImageView.m
//  NYSTKDemo
//
//  Created by 倪永胜 on 2020/9/4.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "NYSTKImageView.h"

@implementation NYSTKImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 
- (void)setImageWithURL:(nullable NSURL *)imageURL placeholder:(nullable UIImage *)placeholder {
    [self setImage:placeholder];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0f];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

    session = [NSURLSession sessionWithConfiguration:config
                                            delegate:self
                                       delegateQueue:[NSOperationQueue mainQueue]];
    task = [session dataTaskWithRequest:request];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    _mData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [_mData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"network error:%@", error.description);
    } else {
        session = nil;
        [self setImage:[UIImage imageWithData:_mData]];
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _mData = nil;
    }
}
 
- (void)dealloc {
    [task cancel];
}

@end
