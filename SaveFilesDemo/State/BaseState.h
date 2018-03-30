//
//  BaseState.h
//  SaveFiles
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveDataEventHandler.h"
#import "SaveDataContext.h"

@class SaveDataContext;

@interface BaseState : NSObject
@property (nonatomic)SaveDataContext *ctx;
@property (nonatomic)NSData *data;

- (void)saveDataWithData:(NSData *)data;
- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data;
- (void)setState:(NSString *)state data:(NSData *)data;
- (void)abort;
@end
