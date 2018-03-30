//
//  IdleState.m
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "IdleState.h"
#import "PendingState.h"

@implementation IdleState

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self = [super initWithSaveDataContext:ctx data:data]) {
        self.data = data;
        self.ctx = ctx;
    }
    return self;
}

- (void)saveDataWithData:(NSData *)data{
    [self setState:NSStringFromClass([PendingState class]) data:data];
}

@end
