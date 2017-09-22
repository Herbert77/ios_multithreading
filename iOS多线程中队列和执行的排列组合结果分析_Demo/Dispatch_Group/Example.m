//
//  Example.m
//  Dispatch_Group
//
//  Created by Herbert Hu on 2017/9/22.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "Example.h"

@implementation Example

- (void)displayExample_1 {
    
    //当我们想在gcd queue中所有的任务执行完毕之后做些特定事情的时候，也就是队列的同步问题，如果队列是串行的话，那将该操作最后添加到队列中即可，但如果队列是并行队列的话，这时候就可以利用dispatch_group来实现了，dispatch_group能很方便的解决同步的问题。dispatch_group_create可以创建一个group对象，然后可以添加block到该组里面
    dispatch_queue_t queue = dispatch_queue_create("com.example.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    // 将任务异步添加到group中去执行
    dispatch_group_async(group, queue, ^{
        NSLog(@"block1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"block2");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"Continue to run.");
}

- (void)displayExample_2 {
    
    //dispatch_group_notify
    //功能与dispatch_group_wait类似，不过该过程是异步的，不会阻塞该线程，dispatch_group_notify有三个参数
    
    dispatch_queue_t queue = dispatch_queue_create("com.example.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"block1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"excute on main queue.");
       
    });
    
    NSLog(@"Continue to excute.");
}

- (void)displayExample_3 {
    
    //  dispatch_group_enter：通知group，下面的任务马上要放到group中执行了。
    //  dispatch_group_leave：通知group，任务完成了，该任务要从group中移除了。
    //  这两种通知可以在多线程间自由穿梭的。
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_enter(group);
    
    // 模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        
        sleep(3);
        NSLog(@"block1 %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, globalQueue, ^{
        
        sleep(3);
        NSLog(@"block2 %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"block3 %@", [NSThread currentThread]);
    });
    
}


@end
