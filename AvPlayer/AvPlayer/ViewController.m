//
//  ViewController.m
//  AvPlayer
//
//  Created by Financialbrain on 2016/7/13.
//  Copyright © 2016年 DarisCode. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
{
    AVPlayer * player;
    AVPlayerLayer * playerLayer;
}
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

@property (strong, nonatomic) AVPlayer * player2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playWithURL:(NSURL*)url {
    
    //如果有舊的會被移除掉
    [self stopBtnPressed:nil];
    
    player = [[AVPlayer alloc] initWithURL:url];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    // _resultImageView變成對位的基準
    // 再按一次會被覆蓋
    playerLayer.frame = _resultImageView.frame;
    [self.view.layer addSublayer:playerLayer];
    [player play];
    
}


- (IBAction)playRemoteMovieBtnPressed:(id)sender {
    
    //Youtube 不行
    NSURL * url = [NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/playlist.m3u8"];
    
    [self playWithURL:url];
    
//    [self playWithURL:[NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/playlist.m3u8"]];
    
    
    
}

- (IBAction)playLocalMovieBtnPressed:(id)sender {
//    NSString *filePathName = [[NSBundle mainBundle]
//                              pathForResource:@"/Users/financialbrain/Documents" ofType:@"mov"];
    
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"123.mov" withExtension:nil];
    
//#if 0
//    if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePathName)==YES)
//    {
//        UISaveVideoAtPathToSavedPhotosAlbum(filePathName, nil, nil, nil);
//    }
//#endif
    
    [self playWithURL:url];
}
- (IBAction)playRemoteMP3BtnPressed:(id)sender {
    [self playWithURL:[NSURL URLWithString:@"https://dl.dropbox.com/u/12116609/00_KentClass/Sample.mp3"]];
    
}
- (IBAction)getThumbnailBtnPressed:(id)sender {
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"123.mov" withExtension:nil];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    //appliesPreferredTrackTransform 參考影片本身打直打橫的特性旋轉
    
    generator.appliesPreferredTrackTransform = true;
    
    NSError *error;
    //假設每秒十張 拿第三十張 ＝ 第三秒那格
    //CMTimeMake
    //&error 如果真的有異常就去 NSError *error宣告一塊記憶體
    CGImageRef cgImage = [generator copyCGImageAtTime:CMTimeMake(30, 10)
                                           actualTime:nil
                                                error:&error];
    
    if(error)
    {
        // ....Handle the error
    }
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    _resultImageView.image = image;
    
}
- (IBAction)stopBtnPressed:(id)sender
{
    
    if(player != nil)
    {
        player.rate = 0.0;
        [playerLayer removeFromSuperlayer];
        player = nil;
        playerLayer = nil;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fullscreenPlayback"])
    {
         NSURL * url = [NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/playlist.m3u8"];
        AVPlayerViewController * vc = segue.destinationViewController;
        vc.player = [[AVPlayer alloc] initWithURL:url];
        [vc.player play];
    };
   
}

@end
