//
//  ViewController.h
//  huruhuruplayer
//
//  Created by ビザンコムマック０４ on 2014/09/24.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *basholabel;
- (IBAction)segmentswitch:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *animationlabel;
@property (weak, nonatomic) IBOutlet UIImageView *blackview;
@property (weak, nonatomic) IBOutlet UIImageView *hitsujiview;
@property CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *yurayuralabel;
- (IBAction)bashobutton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *basho;
@property (weak, nonatomic) IBOutlet UIImageView *movinghitsujiimage;
- (IBAction)modorubutton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *modorubuttonview;
- (IBAction)change_orugoru:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *change_orugarulabel;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@end

