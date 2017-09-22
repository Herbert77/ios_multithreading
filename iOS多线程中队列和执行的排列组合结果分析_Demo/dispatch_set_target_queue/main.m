//
//  main.m
//  dispatch_set_target_queue
//
//  Created by Herbert Hu on 2017/9/21.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        // dispatch_set_target_queue 用法一：
        dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);//目标队列
        dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);//串行队列
        dispatch_queue_t queue2 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);//并发队列
        //设置参考
        dispatch_set_target_queue(queue1, targetQueue);
        dispatch_set_target_queue(queue2, targetQueue);
        
        dispatch_async(queue2, ^{
            NSLog(@"job3 in");
            [NSThread sleepForTimeInterval:2.f];
            NSLog(@"job3 out");
        });
        dispatch_async(queue2, ^{
            NSLog(@"job2 in");
            [NSThread sleepForTimeInterval:1.f];
            NSLog(@"job2 out");
        });
        dispatch_async(queue1, ^{
            NSLog(@"job1 in");
            [NSThread sleepForTimeInterval:3.f];
            NSLog(@"job1 out");
        });
        
        [NSThread sleepForTimeInterval:6.5f];
        
        // ********
        
        // dispatch_set_target_queue 用法二：
        dispatch_queue_t serialQueue = dispatch_queue_create("com.example.myQueue", NULL);
        dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        
        // 把 serialQueue 的优先级设为 globalQueue 具备的优先级
        dispatch_set_target_queue(serialQueue, globleQueue);
    }
    return 0;
}

/*
     dispatch_set_target_queue 用法一：
     总结：
     通过打印的结果说明我们设置了queue1和queue2队列以targetQueue队列为参照对象，那么queue1和queue2中的任务将按照targetQueue的队列处理。
 
     适用场景：
     一般都是把一个任务放到一个串行的queue中，如果这个任务被拆分了，被放置到多个串行的queue中，但实际还是需要这个任务同步执行，那么就会有问题，因为多个串行queue之间是并行的。这时候dispatch_set_target_queue将起到作用。
 
     *********
 
     dispatch_set_target_queue 用法二：
     总结：
     dispatch_set_target_queue的第一个参数为要设置优先级的queue,第二个参数是对应的优先级参照物
 */
