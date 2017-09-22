//
//  main.m
//  并发队列_同步执行
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 并发队列 同步执行
//        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_CONCURRENT);
//
//        for (int i=0; i<10; i++) {
//
//            dispatch_sync(q, ^{
//
//                NSLog(@"%@ %d", [NSThread currentThread], i);
//            });
//        }
        
        
        // 这个运行结果和第1种的串行队列，同步执行是一模一样的。 因为同步任务的概念就是按顺序执行，后面都要等。言外之意就是不允许多开线程。 同步和异步则是决定开一条还是开多条
     
        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_CONCURRENT);
        // 1. 用户登录，必须要第一个执行
        dispatch_sync(q, ^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"用户登录 %@", [NSThread currentThread]);
        });
        // 2. 扣费
        dispatch_async(q, ^{
            NSLog(@"扣费 %@", [NSThread currentThread]);
        });
        // 3. 下载
        dispatch_async(q, ^{
            NSLog(@"下载 %@", [NSThread currentThread]);
        });
      
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"董铂然 come here");
      
        
        /*
        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_CONCURRENT);
        
        void(^task)() = ^{
          
            dispatch_sync(q, ^{
                
                NSLog(@"用户登录 %@", [NSThread currentThread]);
            });
            
            dispatch_async(q, ^{
                
                NSLog(@"扣费 %@", [NSThread currentThread]);
            });
            
            dispatch_async(q, ^{
                
                NSLog(@"下载 %@", [NSThread currentThread]);
            });
        };
        
        dispatch_async(q, task);
        
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"123321");
         */
    }
    return 0;
}
