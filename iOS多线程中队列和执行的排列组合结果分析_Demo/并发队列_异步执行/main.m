//
//  main.m
//  并发队列_异步执行
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 并发队列 异步执行
        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_CONCURRENT);
        
        for (int i=0; i<10; i++) {
            
            dispatch_async(q, ^{
                
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        }
        
        [NSThread sleepForTimeInterval:3];
        NSLog(@"%@", [NSThread currentThread]);
        
        // 异步线程互不相让，系统开了多条线程，执行完成的次序无法预计
    }
    return 0;
}
