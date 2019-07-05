//
//  ViewController.m
//  ThreadLive
//
//  Created by Zhang on 2019/7/5.
//  Copyright © 2019 cue. All rights reserved.
//

#import "ViewController.h"
#import "JPermanentThread.h"

@interface ViewController ()

@property (nonatomic, strong) JPermanentThread *permanentThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (JPermanentThread *)permanentThread {
    if (!_permanentThread) {
        _permanentThread = [[JPermanentThread alloc] init];
    }
    return _permanentThread;
}

- (IBAction)start {
    for (NSInteger i = 0; i < 100; i++) {
        [self execute];
    }
}

- (IBAction)stop {
    [self.permanentThread stop];
}

- (IBAction)execute {
    [self.permanentThread executeTask:^{
        NSLog(@"%s - %@", __func__, [NSThread currentThread]);
    }];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
