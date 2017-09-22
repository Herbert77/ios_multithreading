//
//  main.m
//  全局队列
//
//  Created by Herbert Hu on 2017/9/21.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        dispatch_queue_t q = dispatch_get_global_queue(0, 0);
        
        for (int i=0; i<10; i++) {
            
            dispatch_async(q, ^{
                
                NSLog(@"%@ %d", [NSThread currentThread], i);
            });
        }
        
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"123321");
        
    }
    return 0;
}
