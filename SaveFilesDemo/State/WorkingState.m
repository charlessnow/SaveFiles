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
#import "SaveDataEventHandler.h"

@interface WorkingState ()
{
    BOOL _writing;
    //    NSTimer *_timer;
    NSDate *_date;
}
@end

@implementation WorkingState

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self = [super initWithSaveDataContext:ctx data:data]) {
        self.data = data;
        self.ctx = ctx;
        [self writeDataToFileWithCompletion:^(NSString *filePath, NSError *error) {
            if (filePath && !error) {
                _writing = NO;
            }
        }];
    }
    return self;
}

- (void)writeDataToFileWithCompletion:(EventHandler)completion{
    _writing = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error;
        NSString *temPath = [self.ctx.temPath stringByAppendingPathComponent:@"tmpFiles.txt"];
        BOOL isTureWrite = [self.data writeToFile:temPath options:NSDataWritingAtomic error:&error];
        if (isTureWrite) {
            NSLog(@"success");
            NSError *fileError;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *filePath = temPath;
            NSString *moveToPath = [self.ctx.temPath stringByAppendingPathComponent:@"rename.txt"];
            if ([fileManager fileExistsAtPath:moveToPath]) {
                [fileManager removeItemAtPath:moveToPath error:&fileError];
                if (fileError)[self actionForError:fileError];
            }
            BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:&fileError];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isSuccess) {
                    NSLog(@"rename success");
                    completion(filePath,nil);
                    [self actionForSuccessWithFilePath:filePath];
                }else{
                    completion(nil,fileError);
                    NSLog(@"rename fail,%@",fileError);
                    [self actionForError:fileError];
                }
            });
        }else{
            NSLog(@"fail");
            completion(nil,error);
            [self actionForError:error];
        }
    });
}

- (void)actionForError:(NSError *)error{
    if (self.nextData) {
        [self setState:NSStringFromClass([PendingState class]) data:self.nextData];
    }else{
        [self setState:NSStringFromClass([PendingState class]) data:self.data];
    }
}

- (void)actionForSuccessWithFilePath:(NSString *)filePath{
    if (self.nextData) {
        [self setState:NSStringFromClass([PendingState class]) data:self.nextData];
    }else{
        [self setState:NSStringFromClass([IdleState class]) data:nil];
    }
}

- (void)saveDataWithData:(NSData *)data{
    self.nextData = data;
}

- (void)abort{
    //    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //    dispatch_semaphore_wait(sema, 90.0f);
    if (!_date) {
        _date = [NSDate date];
    }
    if (_writing) {
        NSDate *date = [NSDate date];
        double intervalTime = [date timeIntervalSinceReferenceDate] - [_date timeIntervalSinceReferenceDate];
        if (intervalTime<=60.0) {
            [self performSelector:@selector(abort) withObject:nil afterDelay:2.0f];
            return;
        }
    }
    if (self.nextData) {
        self.nextData = nil;
    }
    _date = nil;
    [self setState:NSStringFromClass([IdleState class]) data:nil];
}

@end


@interface WorkingState2 ()



@end

@implementation WorkingState2

- (instancetype)initWithSaveDataContext:(SaveDataContext *)ctx data:(NSData *)data{
    if (self = [super initWithSaveDataContext:ctx data:data]) {
        self.data = data;
        self.ctx = ctx;
    }
    return self;
}

- (void)saveDataWithData:(NSData *)data{

}

-(void)abort{
    
}

@end

@interface AllWorkingState ()

@end

@implementation AllWorkingState

-(void)abort{
    
}
@end


