//
//  LLAVPlayerViewController.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLAVPlayerViewController.h"
#import "LLAVPlayerView.h"

@interface LLAVPlayerViewController ()

@property (nonatomic, strong) AVPlayer *avplayer;
@property (nonatomic, strong) AVPlayerLayer *avplayerLayer;
@property (nonatomic, strong) AVQueuePlayer *avqueuePlayer;
// view
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) LLAVPlayerView *avplayerView;
// model
@property (nonatomic, strong) AVPlayerItem *item;
@property (nonatomic, strong) NSURL *contentURL;

@end

@implementation LLAVPlayerViewController

#pragma mark - init
- (instancetype)initWithURL:(NSURL *)URL {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.contentURL = URL;
    }
    return self;
}

- (instancetype)initWithURLs:(NSArray *)URLs {
    NSAssert((![URLs isKindOfClass:[NSArray class]] || URLs.count == 0), @"多URL非法");
    return [self initWithURL:[URLs firstObject]];
}

#pragma mark - controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeItems];
    [self makeConstraints];
    [self bindItemsAction];
}

- (void)initializeItems {
    self.view = self.contentView;
    [self.contentView addSubview:self.avplayerView];
    [self.avplayerLayer setPlayer:self.avplayer];
}

- (void)makeConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self.avplayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}

- (void)bindItemsAction {
    ;
}

#pragma mark - player
- (void)play {
    [self.avplayer play];
}

#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}

#pragma mark - set
- (void)setItem:(AVPlayerItem *)item {
    if (item != _item) {
        _item = item;
        [_item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}

#pragma mark - lazyload
- (AVPlayer *)avplayer {
    if (!_avplayer) {
        _avplayer = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithURL:self.contentURL]];
    }
    return _avplayer;
}

- (AVPlayerLayer *)avplayerLayer {
    if (!_avplayerLayer) {
        _avplayerLayer = (AVPlayerLayer *)self.avplayerView.layer;
        _avplayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    }
    return _avplayerLayer;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor blackColor];
    }
    return _contentView;
}

- (LLAVPlayerView *)avplayerView {
    if (!_avplayerView) {
        _avplayerView = [[LLAVPlayerView alloc] initWithFrame:CGRectZero];
    }
    return _avplayerView;
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
