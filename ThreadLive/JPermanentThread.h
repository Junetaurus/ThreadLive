//
//  JPermanentThread.h
//  ThreadLive
//
//  Created by Zhang on 2019/7/5.
//  Copyright © 2019 cue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JPermanentThread : NSObject

/**
 执行任务

 @param task 任务
 */
- (void)executeTask:(void(^)(void))task;

/**
 停止执行任务的线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
