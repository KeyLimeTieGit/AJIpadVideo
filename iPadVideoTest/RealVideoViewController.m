//
//  RealVideoViewController.m
//  iPadVideoTest
//
//  Created by Sameer Siddiqui on 10/17/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "RealVideoViewController.h"
#import <CTVideoPlayerView/CTVideoViewCommonHeader.h>

@interface RealVideoViewController () <CTVideoViewTimeDelegate, CTVideoViewOperationDelegate>

@property (weak, nonatomic) IBOutlet CTVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIButton    *closeButton;
@property (weak, nonatomic) IBOutlet UIButton    *playButton;
@property (weak, nonatomic) IBOutlet UIButton    *option1Button;
@property (weak, nonatomic) IBOutlet UIButton    *option2Button;
@property (weak, nonatomic) IBOutlet UIButton    *playbigButton;
@property (weak, nonatomic) IBOutlet UILabel     *selectPathLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation RealVideoViewController {
    UIView *blackView;
    BOOL    cont;
}

+ (RealVideoViewController *)create{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    RealVideoViewController *main = [[UIStoryboard storyboardWithName:@"Main" bundle:frameworkBundle] instantiateViewControllerWithIdentifier:NSStringFromClass([RealVideoViewController class])];
    return main;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _selectPathLabel.layer.cornerRadius = 4.0;
    _option1Button.layer.cornerRadius   = 4.0;
    _option2Button.layer.cornerRadius   = 4.0;
    _selectPathLabel.alpha  = 0.0;
    _option1Button.alpha    = 0.0;
    _option2Button.alpha    = 0.0;
    _selectPathLabel.hidden = YES;
    _option1Button.hidden   = YES;
    _option2Button.hidden   = YES;
    
    cont = NO;

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    [self setupVideoView];
    [self showBigPlayButton];
}

#pragma mark - utils

- (void)setupVideoView{
    _videoView.operationDelegate = self;
    _videoView.timeDelegate      = self;

    _videoView.shouldShowCoverViewBeforePlay  = YES;
    _videoView.shouldPlayAfterPrepareFinished = NO;

    UIButton *customPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [customPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [customPlay setTitle:@"" forState:UIControlStateNormal];
    _videoView.playButton = customPlay;
    
    _videoView.backgroundColor = [UIColor blackColor];
    _videoView.videoContentMode = CTVideoViewContentModeResizeAspectFill;
    _videoView.videoUrl        = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];

    [_videoView setShouldObservePlayTime:YES withTimeGapToObserve:100.0f];
    [_videoView prepare];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    if (_videoView.isPlaying) {
        [_videoView pause];
        [self.playButton setImage:[UIImage imageNamed:@"playwhite"] forState:UIControlStateNormal];
    }
    else{
        [self hideTheaterView];
    }
}

- (void)showBigPlayButton {
    _playbigButton.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        _playbigButton.alpha = 1.0;
    }
     completion:nil];
}

- (void)hideBigPlayButton {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        _playbigButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        _playbigButton.hidden = YES;
    }];
}

- (void)showTheaterView {
    if (blackView) {
        [blackView removeFromSuperview];
        blackView = nil;
    }
    blackView = [[UIView alloc] initWithFrame:self.view.frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.0;
    [self.view addSubview:blackView];
    [self.view bringSubviewToFront:_videoView];
    [self.view bringSubviewToFront:_logo];
    [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveLinear  animations:^{
        blackView.alpha = 1.0;
    } completion:nil];

}

- (void)hideTheaterView {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        blackView.alpha = 0.0;
    } completion:nil];

}

- (void)showStoryOptions {
    _selectPathLabel.hidden = NO;
    _option1Button.hidden   = NO;
    _option2Button.hidden   = NO;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        _selectPathLabel.alpha  = 1.0;
        _option1Button.alpha    = 1.0;
        _option2Button.alpha    = 1.0;
    } completion:nil];

}

- (void)hideStoryOptions {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        _selectPathLabel.alpha  = 0.0;
        _option1Button.alpha    = 0.0;
        _option2Button.alpha    = 0.0;
        
    } completion:^(BOOL finished) {
        _selectPathLabel.hidden = YES;
        _option1Button.hidden   = YES;
        _option2Button.hidden   = YES;
        
    }];

}

#pragma mark - Video View Delegate methods
- (void)videoViewWillStartPlaying:(CTVideoView *)videoView {
    [self showTheaterView];
//    [self hideBigPlayButton];
}

- (void)videoView:(CTVideoView *)videoView didPlayToSecond:(CGFloat)second {
    NSLog(@"%f",second);
    if (second >= 9 && second < 10) {
        if (!cont ) {
            cont = YES;
            [_videoView pause];
            [self showStoryOptions];
        }
    }
    if (second >= 10 ) {
        cont = NO;
    }
}

- (void)videoViewWillPause:(CTVideoView *)videoView {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        blackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Actions

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playButtonpressed:(id)sender {
    if (_videoView.isPlaying) {
        [_videoView pause];
        [self.playButton setImage:[UIImage imageNamed:@"playwhite"] forState:UIControlStateNormal];
        [self showBigPlayButton];
    }
    else{
        [_videoView play];
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self hideBigPlayButton];
    }
}

- (IBAction)refreshButtonPressed:(id)sender {
    [_videoView replay];
    [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    cont = NO;
}

- (IBAction)option1Pressed:(id)sender {
    [self playButtonpressed:nil];
    [self hideStoryOptions];
}

- (IBAction)option2Pressed:(id)sender {
    [_videoView moveToSecond:28 shouldPlay:YES];
    [self hideStoryOptions];
}
- (IBAction)playbigButtonPressed:(id)sender {
    if (_videoView.isPlaying) {
        [_videoView pause];
        [self.playButton setImage:[UIImage imageNamed:@"playwhite"] forState:UIControlStateNormal];
        [self showBigPlayButton];
    }
    else{
        [_videoView play];
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self hideBigPlayButton];
    }
}



@end
