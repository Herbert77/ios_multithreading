//
//  main.m
//  串行队列_异步执行
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 串行队列 异步执行
        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_SERIAL);
        
        for (int i=0; i<10; i++) {
            
            dispatch_async(q, ^{
            
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        }
        
        [NSThread sleepForTimeInterval:3];
        NSLog(@"%@", [NSThread currentThread]);
        
        // 新开了一个线程2，在线程2按顺序执行
    }
    return 0;
}
