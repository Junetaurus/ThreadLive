//
//  JPermanentThread.m
//  ThreadLive
//
//  Created by Zhang on 2019/7/5.
//  Copyright © 2019 cue. All rights reserved.
//

#import "JPermanentThread.h"

@interface JPermanentThread ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation JPermanentThread

- (NSThread *)thread {
    if (!_thread) {
        _thread = [[NSThread alloc] initWithBlock:^{
            
            CFRunLoopSourceContext context = {0};
            
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            CFRelease(source);
            
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        [_thread start];
    }
    return _thread;
}

- (void)executeTask:(void (^)(void))task {
    if (!task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!_thread) return;
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)__executeTask:(void (^)(void))task {
    task();
}

- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    if (![_thread isCancelled]) [_thread cancel];
    _thread = nil;
}

- (void)dealloc {
    if (!_thread) return;
    [self stop];
}

@end
