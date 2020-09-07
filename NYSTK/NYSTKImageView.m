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
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
 
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (data == nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}
 
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    connection = nil;
     
    [self setImage:[UIImage imageWithData:data]];
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    data = nil;
}
 
- (void)dealloc {
    [connection cancel];
}

@end
