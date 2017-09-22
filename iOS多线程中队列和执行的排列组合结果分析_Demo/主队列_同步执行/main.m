//
//  main.m
//  主队列_同步执行
//
//  Created by Herbert Hu on 16/4/15.
//  Copyright © 2016年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        dispatch_queue_t q = dispatch_get_main_queue();
        
        NSLog(@"卡死了吗？");
        
        dispatch_sync(q, ^{
            NSLog(@"我来了");
        });
        
        NSLog(@"come here");
        
       // 卡死的原因是循环等待，主队列的东西要等主线程执行完，而因为是同步执行不能开线程，所以下面的任务要等上面的任务执行完，所以卡死。这是排列组合中唯一一个会卡死的组合
    }
    return 0;
}
