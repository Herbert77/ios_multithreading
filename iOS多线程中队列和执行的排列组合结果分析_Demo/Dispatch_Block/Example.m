//
//  Example.m
//  Dispatch_Block
//
//  Created by Herbert Hu on 2017/9/22.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "Example.h"

@implementation Example

- (void)displayExample_1 {
    
    // 我们可以创建block 并添加到queue中去执行
    dispatch_queue_t queue = dispatch_queue_create("com.example.blockQueue", NULL);
    
    // 创建block
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"finish some tasks.");
    });
    
    dispatch_async(queue, block);
}

- (void)displayExample_2 {
    
    // 我们可以创建block 并添加到queue中去执行
    dispatch_queue_t queue = dispatch_queue_create("com.example.blockQueue", NULL);
    
    // 在创建 block 时，我们可以通过设置QoS,指定block对应的优先级
    dispatch_block_t block2 = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
        NSLog(@"finish some tasks with QoS");
    });
    dispatch_async(queue, block2);
    
    // 当需要等待前面任务完成时，我们可以使用 dispatch_block_wait.
    // 设置等待时间为 DISPATCH_TIME_FOREVER 会一直等待直到前面的任务完成.
    dispatch_block_wait(block2, DISPATCH_TIME_FOREVER);
    NSLog(@"Continue to excute.");
}

- (void)displayExample_3 {
    
    //dispatch_block_notify当观察的某个block执行结束之后立刻通知提交另一特定的block到指定的queue中执行，该函数有三个参数，第一参数是需要观察的block，第二个参数是被通知block提交执行的queue，第三参数是当需要被通知执行的block
    dispatch_queue_t queue = dispatch_queue_create("com.example.queue3", NULL);
    
    dispatch_block_t previousBlock = dispatch_block_create(0, ^{
        
        NSLog(@"previousBlock begin.");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"previousBlock done.");
    });
    dispatch_async(queue, previousBlock);
    
    dispatch_block_t notifiedBlock = dispatch_block_create(0, ^{
        
        NSLog(@"notifiedBlock has excuted.");
    });
    
    // 当 previousBlock 执行完毕后， 提交 notifyBlock 到 global queue 中执行
    dispatch_block_notify(previousBlock, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), notifiedBlock);
    
    [NSThread sleepForTimeInterval:5.0];
}

- (void)displayExample_4 {
    
    dispatch_queue_t queue = dispatch_queue_create("com.example.queue4", NULL);
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"block1 begin.");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"block1 done.");
    });
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"block2");
    });
    
    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_block_cancel(block2);
    
    [NSThread sleepForTimeInterval:3.0];
}

@end
