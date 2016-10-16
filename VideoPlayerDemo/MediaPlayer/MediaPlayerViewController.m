//
//  MediaPlayerViewController.m
//  VideoPlayerDemo
//
//  Created by je_ffy on 2016/10/16.
//  Copyright © 2016年 je_ffy. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface MediaPlayerViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerVC;
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerView;

@end

@implementation MediaPlayerViewController
-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MediaPlayer";
    
    
    
}
- (IBAction)playerVCLocalTap:(id)sender {
    self.moviePlayerVC.contentURL = [self getFileUrl];
    [self.moviePlayerVC play];

}

- (IBAction)playerVCURLTap:(id)sender {
    self.moviePlayerVC.contentURL = [self getNetworkUrl];
    [self.moviePlayerVC play];
}

- (IBAction)playerViewLocalTap:(id)sender {
    self.moviePlayerView.moviePlayer.contentURL = [self getFileUrl];
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerView];
    self.moviePlayerView.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
    [self.moviePlayerView.moviePlayer play];

}

- (IBAction)playerViewURLTap:(id)sender {
    self.moviePlayerView.moviePlayer.contentURL = [self getNetworkUrl];
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerView];
    self.moviePlayerView.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
    [self.moviePlayerView.moviePlayer play];
}


#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *path= [[NSBundle mainBundle] pathForResource:@"a" ofType:@"mp4"];
    NSURL *URL = [[NSURL alloc] initFileURLWithPath:path];
    return URL;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayerVC{
    if (!_moviePlayerVC) {
        
        _moviePlayerVC=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@""]];
        [self.view addSubview:_moviePlayerVC.view];
        _moviePlayerVC.view.frame=self.view.bounds;
        _moviePlayerVC.shouldAutoplay = YES;
        [_moviePlayerVC setFullscreen:YES animated:YES];

        _moviePlayerVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_moviePlayerVC prepareToPlay];
        [self addMPMoviePlayerNotification];

    }
    return _moviePlayerVC;
}

-(MPMoviePlayerViewController *)moviePlayerView{
    if (!_moviePlayerView) {
        _moviePlayerView=[[MPMoviePlayerViewController alloc]initWithContentURL:nil];
        _moviePlayerView.view.frame=self.view.bounds;
        [self addMPMoviePlayerViewNotification];
        
    }
    return _moviePlayerView;
}


/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addMPMoviePlayerNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerVC];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerVC];
    
}
- (void)addMPMoviePlayerViewNotification {
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerView.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerView.moviePlayer];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    MPMoviePlayerController * moviePlayerVC = (MPMoviePlayerController *)notification.object;
    switch (moviePlayerVC.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",moviePlayerVC.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayerVC.playbackState);
    [_moviePlayerVC.view removeFromSuperview];
    _moviePlayerVC = nil;
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
