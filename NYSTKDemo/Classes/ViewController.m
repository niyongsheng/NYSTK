//
//  ViewController.m
//  NYSTKDemo <https://github.com/niyongsheng/NYSTK>
//
//  Created by 倪永胜 on 2020/9/3.
//  Copyright © 2020 倪永胜. All rights reserved.
//

#import "ViewController.h"
#import "NYSTK.h"
#import "Model.h"
#import "DemoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 300
#define NAV_HEIGHT 64

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bottomImgView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.tableView];
    [self.topView addSubview:self.imgView];
    self.imgView.center = CGPointMake(self.topView.center.x, self.topView.center.y - 30);
    [self.topView addSubview:self.nameLabel];
    self.nameLabel.frame = CGRectMake(0, self.imgView.frame.size.height + self.imgView.frame.origin.y + 10, self.view.frame.size.width, 25);
    [self.topView addSubview:self.segmentedControl];
    self.segmentedControl.center = CGPointMake(self.topView.center.x, self.nameLabel.center.y + 40);
    self.tableView.tableHeaderView = self.topView;
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Model *model = self.dataSource[section];
    return model.detailTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Model *model = self.dataSource[section];
    return model.header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *header = @"customHeader";
    UITableViewHeaderFooterView *vHeader;
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    
    if (!vHeader) {
        vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
    }
    vHeader.tintColor = [UIColor blackColor];
    vHeader.textLabel.text = [self tableView:tableView titleForHeaderInSection:section];

    return vHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    cell.imageView.image = [UIImage imageNamed:@"logo"];
    
    Model *model = self.dataSource[indexPath.section];
    NSString *str = [[model titles] count] > 0 ? [model titles][indexPath.row] : [[model header] stringByAppendingFormat:@" %zd", indexPath.row];
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSString *detailStr = [model detailTitles][indexPath.row];
    cell.detailTextLabel.text = detailStr;
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DemoViewController *demoVC = DemoViewController.new;
    demoVC.indexPath = indexPath;
    demoVC.tintModel = self.segmentedControl.selectedSegmentIndex;
    demoVC.title = [self.dataSource[indexPath.section] detailTitles][indexPath.row];
    
    demoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:demoVC animated:YES completion:^{
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.frame.size.height + scrollView.contentInset.top;
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        CGFloat y = cell.center.y - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(-70, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        Model *model_0 = [Model new];
        model_0.header = @"Toast Demo";
        model_0.detailTitles = @[@"simple toast", @"image toast"];
        
        Model *model_1 = [Model new];
        model_1.header = @"Colorful Toast Demo";
        model_1.detailTitles = @[@"up", @"down", @"left", @"right"];
        
        Model *model_2 = [Model new];
        model_2.header = @"Custom Image Demo";
        model_2.titles = @[@"Sign-in Demo1", @"Sign-in Demo2", @"Custom Image Demo1", @"Custom Image Demo2"];
        model_2.detailTitles = @[@"Colourbar", @"Snow", @"Rain", @"Fireworks"];
        
        Model *model_3 = [Model new];
        model_3.header = @"Message Demo";
        model_3.titles = @[@"Success", @"Erroe", @"warning"];
        model_3.detailTitles = @[@"Colourbar", @"Rain", @"Snow"];
        
        Model *model_4 = [Model new];
        model_4.header = @"Alert Demo";
        model_4.titles = @[@"Alert1", @"Alert2"];
        model_4.detailTitles = @[@"None", @"Colourbar"];
        
        _dataSource = @[model_0, model_1, model_2, model_3, model_4];
    }
    return _dataSource;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, IMAGE_HEIGHT)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIImageView *)bottomImgView {
    if (_bottomImgView == nil) {
        _bottomImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomImage"]];
        _bottomImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    return _bottomImgView;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
        _imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewOnclicked:)];
        [_imgView addGestureRecognizer:tap];
        _imgView.bounds = CGRectMake(0, 0, 90, 90);
        _imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imgView.layer.borderWidth = 2;
        _imgView.layer.cornerRadius = 45;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"NYSTK";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:22];
    }
    return _nameLabel;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Light Model", @"Dark Model"]];
        _segmentedControl.tintColor = [UIColor lightGrayColor];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

- (AVPlayer *)player {
    if (!_player) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"meteor.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:playItem];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.frame = CGRectMake(0, 0, NYSTK_ScreenWidth, NYSTK_ScreenHeight);
        [self.view.layer insertSublayer:layer atIndex:0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        NSError *setCategoryError = nil;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    }
    return _player;
}

#pragma mark - video end
- (void)playToEnd {
    [self.player seekToTime:kCMTimeZero];
}

- (void)iconViewOnclicked:(UIImageView *)imageView {
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:FrameworkURL] entersReaderIfAvailable:YES];
    [self presentViewController:safariVC animated:YES completion:nil];
}

#pragma mark - Screen Orientation Control
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
