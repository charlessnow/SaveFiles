//
//  BaseState.m
//  SaveFiles
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "BaseState.h"

@implementation BaseState

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self = [super init]) {
        self.ctx = ctx;
        self.data = data;
        self.ctx.state = self;
    }
    return self;
}


- (void)setState:(NSString *)state data:(NSData *)data{
    BaseState *s = [[NSClassFromString(state) alloc] initWithSaveDataContext:self.ctx data:data];
    NSLog(@"%@, %@",state, s);
}

- (void)abort{
    
}

- (void)saveDataWithData:(NSData *)data{
    
}

-(void)dealloc{
    
}

@end
