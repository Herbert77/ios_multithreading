//
//  main.m
//  iOS多线程中队列和执行的排列组合结果分析_Demo
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 1. 串行队列，同步执行
        dispatch_queue_t q = dispatch_queue_create("com.test.dantesx", DISPATCH_QUEUE_SERIAL);
        
        for (int i=0; i<10; i++) {
            
            dispatch_sync(q, ^{
                
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        }
        
        // 在主线程执行， 按照数序依次执行 task（Block）
        
    }
    return 0;
}
