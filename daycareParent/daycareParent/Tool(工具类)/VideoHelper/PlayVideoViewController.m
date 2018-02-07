//
//  PlayVideoViewController.m
//  VideoRecord
//
//  Created by guimingsu on 15/4/27.
//  Copyright (c) 2015年 guimingsu. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayVideoViewController ()<UITextFieldDelegate>

@end

@implementation PlayVideoViewController
{

    AVPlayer *player;
    AVPlayerLayer *playerLayer;
    AVPlayerItem *playerItem;
    
    UIImageView* playImg;
    
}

@synthesize videoURL;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"预览";
    
    float videoWidth = self.view.frame.size.width;
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 64, videoWidth, videoWidth);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    
    UITapGestureRecognizer *playTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playOrPause)];
    [self.view addGestureRecognizer:playTap];
    
    [self pressPlayButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    playImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    playImg.center = CGPointMake(videoWidth/2, videoWidth/2);
    [playImg setImage:[UIImage imageNamed:@"videoPlay"]];
    [playerLayer addSublayer:playImg.layer];
    playImg.hidden = YES;
    
    UIButton *okBtn = [[UIButton alloc] init];
    [self.view addSubview:okBtn];
    [okBtn addTarget:self action:@selector(chooseVideo) forControlEvents:UIControlEventTouchUpInside];
    okBtn.frame = CGRectMake(self.view.frame.size.width-80, self.view.frame.size.height-80, 50, 50);
//    [okBtn setImage:[XCStyleCssParse getImage:@"37x-Checkmark.png"] forState:UIControlStateNormal];
    [okBtn setBackgroundImage:[UIImage imageNamed:@"37x-Checkmark.png"] forState:UIControlStateNormal];
    UIButton *noBtn = [[UIButton alloc] init];
    [self.view addSubview:noBtn];
    [noBtn addTarget:self action:@selector(closeAll) forControlEvents:UIControlEventTouchUpInside];
    noBtn.frame = CGRectMake(30, self.view.frame.size.height-80, 50, 50);
   // [noBtn setImage:[XCStyleCssParse getImage:@"37x-Wrong.png"] forState:UIControlStateNormal];
     [noBtn setBackgroundImage:[UIImage imageNamed:@"37x-Wrong.png"] forState:UIControlStateNormal];
}
- (void)chooseVideo
{
//    XCAddObserverB(<#tag#>, <#type#>, <#blockB#>)
}
- (void)closeAll
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)playOrPause{
    if (playImg.isHidden) {
        playImg.hidden = NO;
        [player pause];
        
    }else{
        playImg.hidden = YES;
        [player play];
    }
}

- (void)pressPlayButton
{
    [playerItem seekToTime:kCMTimeZero];
    [player play];
}

- (void)playingEnd:(NSNotification *)notification
{
    if (playImg.isHidden) {
        [self pressPlayButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
