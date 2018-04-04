//
//  WorkingState.h
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "BaseState.h"

@interface WorkingState : BaseState
@property (nonatomic)NSData *nextData;
@end

@interface WorkingState2: BaseState

@end

@interface AllWorkingState: BaseState
@property (nonatomic) WorkingState *workingState;
@property (nonatomic) WorkingState2 *workingState2;
@end
