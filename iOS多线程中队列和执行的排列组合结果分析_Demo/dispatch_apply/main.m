//
//  main.m
//  dispatch_apply
//
//  Created by Herbert Hu on 2017/9/22.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
  
        dispatch_queue_t queue = dispatch_queue_create("com.example.applyQueue", DISPATCH_QUEUE_CONCURRENT);
        
        // 并发运行一个block任务5次
        dispatch_apply(5, queue, ^(size_t i) {
            
            NSLog(@"do the job %lu times.", i+1);
        });
    }
    return 0;
}

/*
     dispatch_apply类似一个for循环，会在指定的dispatch queue中运行block任务n次，如果队列是并发队列，则会并发执行block任务，dispatch_apply是一个同步调用，block任务执行n次后才返回。
 */
