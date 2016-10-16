//
//  JFAVPlayerViewController.m
//  VideoPlayerDemo
//
//  Created by je_ffy on 2016/10/16.
//  Copyright © 2016年 je_ffy. All rights reserved.
//

#import "JFAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface JFAVPlayerViewController ()

@end

@implementation JFAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MediaPlayer";

}
- (IBAction)avPlayertap:(id)sender {
    NSString *path= [[NSBundle mainBundle] pathForResource:@"a" ofType:@"mp4"];
    NSURL *sourceMovieURL = [[NSURL alloc] initFileURLWithPath:path];
    
    
    AVAsset *movieAsset= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.view.layer.bounds;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
}
- (IBAction)avPlayerControllertap:(id)sender {
    NSString *path= [[NSBundle mainBundle] pathForResource:@"a" ofType:@"mp4"];
    NSURL *sourceMovieURL = [[NSURL alloc] initFileURLWithPath:path];
    
    AVPlayerViewController *player = [[AVPlayerViewController alloc]init];
    
    player.player = [[AVPlayer alloc]initWithURL:sourceMovieURL];
    
    [self presentViewController:player animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
