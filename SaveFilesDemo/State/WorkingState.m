//
//  WorkingState.m
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "WorkingState.h"
#import "PendingState.h"
#import "IdleState.h"

@implementation WorkingState

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self = [super initWithSaveDataContext:ctx data:data]) {
        self.data = data;
        self.ctx = ctx;
        [self writeDataToFile];
      
    }
    return self;
}


- (void)writeDataToFile{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error;
        NSString *temPath = [self.ctx.temPath stringByAppendingPathComponent:@"tmpFiles.txt"];
        BOOL isTureWrite = [self.data writeToFile:temPath options:NSDataWritingAtomic error:&error];
        if (isTureWrite) {
            NSLog(@"success");
            __weak typeof(self) weakself = self;
            [self renameFileWithName:@"realFile" tempPath:temPath completion:^(BOOL success, NSString *filePath,NSError *fileError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success && filePath) {
                        [weakself actionForSuccess];
                    }else{
                        [weakself actionForError:fileError];
                    }
                });
            }];
        }else{
            NSLog(@"fail");
            [self actionForError:error];
        }
    });
}

- (void)renameFileWithName:(NSString *)name tempPath:(NSString *)path completion:(void(^)(BOOL success,NSString *filePath,NSError *error))completion{
    //通过移动该文件对文件重命名
    NSError *fileError;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = path;
    NSString *moveToPath = [self.ctx.temPath stringByAppendingPathComponent:@"rename.txt"];
    if ([fileManager fileExistsAtPath:moveToPath]) {
        [fileManager removeItemAtPath:moveToPath error:&fileError];
        if (fileError)completion(false,nil,fileError);
    }
    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:&fileError];
    if (isSuccess) {
        NSLog(@"rename success");
        completion(true,moveToPath,nil);
    }else{
        NSLog(@"rename fail,%@",fileError);
        completion(false,nil,fileError);
    }
}

- (void)actionForError:(NSError *)error{
    if (self.nextData) {
        [self setState:NSStringFromClass([PendingState class]) data:self.nextData];
    }else{
        [self setState:NSStringFromClass([PendingState class]) data:self.data];
    }
}

- (void)actionForSuccess{
    if (self.nextData) {
        [self setState:NSStringFromClass([PendingState class]) data:self.nextData];
    }else{
        [self setState:NSStringFromClass([IdleState class]) data:nil];
    }
}

- (void)saveDataWithData:(NSData *)data{
    self.nextData = data;
}
@end

