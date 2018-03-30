//
//  FilesTool.m
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "FilesTool.h"

@implementation FilesTool
+ (NSString*)getPathInDocumentsDirBy:(NSString*)subFolder createIfNotExist:(BOOL)needCeate
{
    NSString* subPath;
    
    NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    subPath = [dir stringByAppendingPathComponent:subFolder];
    
    if (![FilesTool fileExistsAtPath:subPath])
    {
        if (needCeate)
        {
            NSError* error = nil;
            if (![[NSFileManager new] createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"创建%@失败,Error=%@", subFolder,error);
            }
        }
    }
    
    return subPath;
}

+ (BOOL)fileExistsAtPath:(NSString *)path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = [fileManager fileExistsAtPath:path];
    
    // NSLog(@"fileExistsAtPath:%@ = %@",path, (isExist ? @"YES" : @"NO"));
    
    return isExist;
    
}

@end
