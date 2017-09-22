//
//  main.m
//  Dispatch_Group
//
//  Created by Herbert Hu on 2017/9/22.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Example.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Example *ep = [Example new];
        
        // dispatch_group
//        [ep displayExample_1];
        
        // dispatch_group_notify
//        [ep displayExample_2];
//        [NSThread sleepForTimeInterval:3.0];
        
        // dispatch_group_enter and dispatch_group_leave
        [ep displayExample_3];
        [NSThread sleepForTimeInterval:7.0];
    }
    return 0;
}
