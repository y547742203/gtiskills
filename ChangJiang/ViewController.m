//
//  ViewController.m
//  ChangJiang
//
//  Created by Yevgeny on 15/10/9.
//  Copyright © 2015年 gaoxiang. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (strong, nonatomic) MPMoviePlayerController *player;
@property (strong, nonatomic) UIImageView *imageView;
- (IBAction)startPlay:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlString = @"http://182.92.10.18:8080/mj/videos/20150801201024.mp4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //1设置播放器的大小
    [self.player.view setFrame:CGRectMake(0, 0, 320, 180)]; //16:9是主流媒体的样式
    //2将播放器视图添加到根视图
    [self.view addSubview:self.player.view];
    
    [self.player setShouldAutoplay:NO];
    //4播放
    //[self.player play];
    //通过通知中心，以观察者模式监听视频播放状态
    //1 监听播放状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stateChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    //2 监听播放完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishedPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //3视频截图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caputerImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    //3视频截图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caputerImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    //4退出全屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //异步视频截图,可以在attimes指定一个或者多个时间。
    [self.player requestThumbnailImagesAtTimes:@[@10.0f, @20.0f] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    UIImageView *thumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 200, 160, 90)];
    self.imageView = thumbnailImageView;
    [self.view addSubview:thumbnailImageView];
    
}

#pragma mark 退出全屏
- (void)exitFullScreen
{
    NSLog(@"退出全屏");
}

#pragma mark -播放器事件监听
#pragma mark 视频截图 这个方法是异步方法
- (void)caputerImage:(NSNotification *)notification
{
    NSLog(@"截图 %@", notification);
    UIImage *image = notification.userInfo[@"MPMoviePlayerThumbnailImageKey"];
    [self.imageView setImage:image];
}

#pragma mark 播放器事件监听
#pragma mark 播放完成
- (void)finishedPlay
{
    NSLog(@"播放完成");
}

#pragma mark 播放器视频的监听
#pragma mark 播放状态变化
/*
 MPMoviePlaybackStateStopped,  //停止
 MPMoviePlaybackStatePlaying,  //播放
 MPMoviePlaybackStatePaused,   //暂停
 MPMoviePlaybackStateInterrupted,  //中断
 MPMoviePlaybackStateSeekingForward, //快进
 MPMoviePlaybackStateSeekingBackward  //快退
 */
- (void)stateChange
{
    switch (self.player.playbackState) {
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStatePlaying:
            //设置全屏播放
            //[self.player setFullscreen:YES animated:YES];
            NSLog(@"播放");
            break;
        case MPMoviePlaybackStateStopped:
            //注意：正常播放完成，是不会触发MPMoviePlaybackStateStopped事件的。
            //调用[self.player stop];方法可以触发此事件。
            NSLog(@"停止");
            break;
        default:
            break;
    }
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

- (IBAction)startPlay:(id)sender {
    [self.player pause];
}
@end
