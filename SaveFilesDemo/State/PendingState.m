//
//  PendingState.m
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "PendingState.h"
#import "WorkingState.h"
#import "IdleState.h"

@implementation PendingState

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self =  [super initWithSaveDataContext:ctx data:data]) {
        self.ctx = ctx;
        [self saveDataWithData:self.data];
    }
    return self;
}

- (void)saveDataWithData:(NSData *)data{
    if (self.timer)[self.timer invalidate];
    self.timer = nil;
    self.data = data;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.ctx.timeOut target:self  selector:@selector(timerFired:) userInfo:nil repeats:NO];
}

- (void)timerFired:(NSTimer *)timer{
    [self setState:NSStringFromClass([WorkingState class]) data:self.data];
}

- (void)abort{
    if (self.timer)[self.timer invalidate];
    self.timer = nil;
    self.data = nil;
    [self setState:NSStringFromClass([IdleState class]) data:nil];
}


- (void)dealloc{
    if (self.timer)[self.timer invalidate];
    self.timer = nil;
}

@end
