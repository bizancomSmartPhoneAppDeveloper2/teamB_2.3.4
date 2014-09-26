//
//  ViewController.h
//  huruhuruplayer
//
//  Created by ビザンコムマック０４ on 2014/09/24.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>
-(IBAction)addFive:(id)sender ;
- (IBAction)startbutton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *animationlabel;
@property (weak, nonatomic) IBOutlet UIImageView *blackview;
@end

