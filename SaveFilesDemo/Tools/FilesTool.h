//
//  FilesTool.h
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilesTool : NSObject
+ (NSString*)getPathInDocumentsDirBy:(NSString*)subFolder createIfNotExist:(BOOL)needCeate;
@end
