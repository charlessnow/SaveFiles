//
//  SaveDataContext.h
//  SaveFiles
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseState.h"
#import "SaveDataEventHandler.h"
@class BaseState;

@interface SaveDataContext : NSObject
@property (nonatomic) BaseState *state;
@property (nonatomic) NSString *temPath;
@property (nonatomic) NSString *fileName;
@property (nonatomic) NSTimeInterval timeOut;

- (void)saveDataWithData:(NSData *)data completion:(EventHandler)completion;

+ (instancetype)shared;


- (void)cancelSaveFiles;


@end
