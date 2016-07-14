//
//  AppDelegate.h
//  MyTempMap
//
//  Created by Financialbrain on 2016/7/14.
//  Copyright © 2016年 DarisCode. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JUMP_TO_NOTIFICATION @"JUMP_TO_FUNC_NOTIFICATION"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString * jumpToFuncParameter;


@end

