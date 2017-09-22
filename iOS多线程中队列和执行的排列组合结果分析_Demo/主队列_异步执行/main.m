//
//  main.m
//  主队列_异步执行
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        dispatch_queue_t q = dispatch_get_main_queue();
        
        for (int i = 0; i<10; i++) {
            dispatch_async(q, ^{
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        }
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"%@", [NSThread currentThread]);
    }
    return 0;
}
