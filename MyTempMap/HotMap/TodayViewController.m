//
//  TodayViewController.m
//  HotMap
//
//  Created by Financialbrain on 2016/7/14.
//  Copyright © 2016年 DarisCode. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

            /* 當通知中心被拉下來即時開啟*/

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    [self doRefreshWithCompletionHandler:completionHandler];
    completionHandler(NCUpdateResultNewData);
}


- (IBAction)launchBtnPressed:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"hotMapWidgetApp://2"];
    
    //
    [self.extensionContext openURL:url completionHandler:nil];
    

}
- (IBAction)refreshBtnPressed:(id)sender
{
    [self doRefreshWithCompletionHandler:nil];
    
}

-(void) doRefreshWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.cwb.gov.tw/V7/observe/temperature/Data/temp.jpg"];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask * task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        if(error)
        {
            
            NSLog(@"NSURLSession Error: %@",error);
            if (completionHandler != nil)
            {
                completionHandler(NCUpdateResultNewData);
            }
        }
        
            if(error == nil)
            {
                UIImage *image = [UIImage imageWithData:data];
                
                dispatch_async(dispatch_get_main_queue(),
                ^{
                    
                    _mainImage.image = image;
                    
                });
                
                if (completionHandler != nil) {
                    completionHandler(NCUpdateResultNewData);
                }
            }
    }];
    
    [task resume];
    
}

        /* 佔滿整個螢幕的寬 */
- (UIEdgeInsets) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

@end
