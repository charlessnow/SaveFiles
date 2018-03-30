//
//  SaveDataContext.m
//  SaveFiles
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "SaveDataContext.h"
#import "FilesTool.h"
#import "IdleState.h"


@interface SaveDataContext()


@end
@implementation SaveDataContext

+ (instancetype)shared{
    static SaveDataContext * saveData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saveData = [[SaveDataContext alloc] init];
    });
    return saveData;
}

- (instancetype)init{
    if (self = [super init]) {
        self.temPath =  [FilesTool getPathInDocumentsDirBy:@"SaveFile" createIfNotExist:YES];

        self.timeOut = 2.0;
        self.state = [[IdleState alloc]initWithSaveDataContext:self data:nil];
    } 
    return self;
}

- (void)saveDataWithData:(NSData *)data{
    [self.state saveDataWithData:data];
}

- (void)dealloc{
    
}
@end
