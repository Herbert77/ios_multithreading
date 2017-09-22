//
//  main.m
//  dispatch_barrier_async
//
//  Created by Herbert Hu on 2017/9/22.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        dispatch_queue_t queue = dispatch_queue_create("com.example.database", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"reading data1.");
        });
        
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"reading data2.");
        });
        
        dispatch_barrier_async(queue, ^{
            
            NSLog(@"writing data1.");
            [NSThread sleepForTimeInterval:1.f];
        });
        
        dispatch_sync(queue, ^{
            
            [NSThread sleepForTimeInterval:1];
            NSLog(@"reading data3");
        });
    }
    return 0;
}

/*
     dispatch_barrier_async 用户等待前面的任务执行完毕后自己才执行，而它后面的任务需要等待它完成之后才执行。
 */
