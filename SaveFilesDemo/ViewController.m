//
//  ViewController.m
//  SaveFilesDemo
//
//  Created by wisnuc-imac on 2018/3/28.
//  Copyright © 2018年 wisnuc-imac. All rights reserved.
//

#import "ViewController.h"
#import "SaveDataContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//- (IBAction)test:(id)sender {
//    NSString * urlString = @"App-Prefs:root=WIFI";
//
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
//            if (@available(iOS 10.0, *)) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
//            } else {
//                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//            }
//    }
//}

- (IBAction)cancelButtonClick:(UIButton *)sender {
   [[SaveDataContext shared] cancelSaveFiles];
}

- (IBAction)saveFilesButtonClick:(UIButton *)sender {
    NSString *string = @"save";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [[SaveDataContext shared] saveDataWithData:data completion:^(NSString *filePath, NSError *error) {
        NSLog(@"%@",filePath);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
