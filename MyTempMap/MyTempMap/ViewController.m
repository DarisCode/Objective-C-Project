//
//  ViewController.m
//  MyTempMap
//
//  Created by Financialbrain on 2016/7/14.
//  Copyright © 2016年 DarisCode. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //串起handleJumpToFuncNotification的方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleJumpToFuncNotification:) name:JUMP_TO_NOTIFICATION object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if(appDelegate.jumpToFuncParameter != nil)
    {
        [self doJumpToFunc:appDelegate.jumpToFuncParameter];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleJumpToFuncNotification:(NSNotification*) notify
{
    [self doJumpToFunc:notify.object];
}


- (void) doJumpToFunc:(NSString*) parameter
{
    
    NSString * segueIdentify = [NSString stringWithFormat:@"gofunction%@",parameter];
    
    [self performSegueWithIdentifier:segueIdentify sender:nil];
    
    //Clear junpToFuncParameter
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.jumpToFuncParameter = nil;
    
}
@end
