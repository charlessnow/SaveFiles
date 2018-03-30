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

- (IBAction)saveFilesButtonClick:(UIButton *)sender {
    NSString *string = @"save";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [[SaveDataContext shared] saveDataWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
