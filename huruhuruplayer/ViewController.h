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

@interface ViewController : UIViewController<AVAudioPlayerDelegate>
- (IBAction)segmentswitch:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *animationlabel;
@property (weak, nonatomic) IBOutlet UIImageView *blackview;
@property (weak, nonatomic) IBOutlet UIImageView *hitsujiview;
@property CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *yurayuralabel;
@end

