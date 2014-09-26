//
//  ViewController.m
//  huruhuruplayer
//
//  Created by ビザンコムマック０４ on 2014/09/24.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    AVAudioPlayer *orugoru_Player;
    AVAudioPlayer *mizunooto_Player;
    UIProgressView * progress1;
   
    NSTimer *timer;
    UIView *animationView;
    UIImageView *imageView;
    NSString *url;
    NSInteger switchnumber;
    CGFloat cx;
    CGFloat cy;
    CGPoint pt;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //http://weather.livedoor.com/forecast/webservice/json/v1
    NSString *url_2 = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=400040";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_2]];
    NSData *json_raw_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jstr = [[NSString alloc] initWithData:json_raw_data encoding:NSUTF8StringEncoding];
    NSString *cricket_left = @"[";
    NSString *cricket_right = @"]";
    
    jstr = [[cricket_left stringByAppendingString:jstr] stringByAppendingString:cricket_right];
    NSData *json_data = [jstr dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSError *error_2=nil;
    NSArray *jarray = [NSJSONSerialization JSONObjectWithData:json_data
                                                      options:NSJSONReadingAllowFragments
                                                        error:&error_2];
    NSDictionary *dic;
    
    for (NSDictionary *obj in jarray)
        {
            dic = obj;
        }
    
    NSLog(@"%@",[[[dic objectForKey:@"forecasts"] objectAtIndex:0] objectForKey:@"telop"]);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    switchnumber = 0;
    cx = 0;
    cy = 0;
    
    
    //タイマースタートと同時に効果音鳴らす
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"yurikagonouta" ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url_0 = [[NSURL alloc] initFileURLWithPath:path];
    orugoru_Player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_0 error:&error];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error != nil )
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    [orugoru_Player setDelegate:self];// 自分自身をデリゲートに設定
    
    NSError *error1 = nil;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"mizunonaka"
                                                      ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url_1 = [[NSURL alloc] initFileURLWithPath:path1];
    mizunooto_Player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_1 error:&error1];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error != nil )
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    [mizunooto_Player setDelegate:self];// 自分自身をデリゲートに設定

    
    //プログレスバーの表示の調整
    progress1 = [  [ UIProgressView alloc ] initWithProgressViewStyle:UIProgressViewStyleDefault ];
    progress1.frame = CGRectMake( 10, 65, 300, 300 );
    //progress1.transform = CGAffineTransformMakeRotation( -90.0f * M_PI / 180.0f ); // 反時計回りに90度回転して表示する
    progress1.transform = CGAffineTransformMakeScale( 1.0f, 10.0f ); // 横方向に1倍、縦方向に3倍して表示する
    //progress1.progressTintColor = [UIColor whiteColor];

    //progress1.alpha = 0.5;
    [self.view addSubview:progress1 ];
    progress1.hidden = YES;
}


//ラベルのアニメーション
- (void)viewDidAppear:(BOOL)animated{
    [self animationlabelAnimation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)segmentswitch:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        switchnumber = 0;
        self.animationlabel.hidden = NO;
        [self animationlabelAnimation];
        progress1.hidden = NO;
        self.yurayuralabel.hidden = YES;
        if(progress1.progress > 0){
            [timer invalidate];
            [orugoru_Player play];
            [self timer];
            NSLog(@"オルゴール");
        }else nil;
        }
    else if(sender.selectedSegmentIndex == 1){
        switchnumber = 1;
        
        //[self yurayuralabelAnimation];
        NSLog(@"水の音");
        [self startMoving];
        progress1.hidden = YES;
        self.yurayuralabel.hidden = NO;
        [timer invalidate];
        [orugoru_Player stop];

    }
    
}


//タイマーで１秒ずつ引いて行く
-(void)timer{
    //1秒ごとにこのタイマー呼ばれてcountdownメソッドを繰り返し実行します
       timer = [NSTimer
             scheduledTimerWithTimeInterval:2
             target: self
             selector:@selector(countdown)
             userInfo:nil
             repeats:YES];
}

-(void)countdown{
    progress1.progress = (progress1.progress-0.1);
    if (progress1.progress == 0) {
        [orugoru_Player stop];
        NSLog(@"音楽停止");
        [timer invalidate];
    }
}

//シェイクさせれるとこのメソッドが呼ばれる
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (switchnumber == 0) {
        self.blackview.hidden = NO;
        [timer invalidate];
        progress1.hidden = NO;
        [progress1 setProgress:(progress1.progress+0.5) animated:YES ]; // アニメーション付きで進捗を指定
        [orugoru_Player play];
        [self timer];
    }else
        nil;
    
}


//傾けられるとこのメソッドが呼ばれる
-(void)startMoving{
    self.blackview.hidden = NO;
    self.motionManager = [[CMMotionManager alloc]init];
    
    //1秒の60分の１に一回のペースで加速度の動きを検知する
    self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0;
    
    //メインスレッドで動作させる
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [self.motionManager startAccelerometerUpdatesToQueue:queue
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 CMAcceleration acceleration = accelerometerData.acceleration;
                                                 float centerY;
                                                 centerY = 284.0 -acceleration.y *284.0;
                                                 if (centerY < 284) {
                                                     [mizunooto_Player play];                                          }else if (centerY > 284){
                                                         [mizunooto_Player play];
                                                                                                    }else if(centerY == 284){
                                                                                                        [mizunooto_Player stop];
                                                                                                    }
                                                 self.yurayuralabel.center = CGPointMake(self.yurayuralabel.center.x, centerY);                                             }];
}

//-(void)yurayuralabelAnimation{
//    self.yurayuralabel.hidden = NO;
//    UIViewAnimationOptions animeOptions =
//    UIViewAnimationOptionCurveEaseInOut
//    | UIViewAnimationOptionAutoreverse
//    | UIViewAnimationOptionRepeat;
    
//    cx = self.yurayuralabel.center.x+50;
//    cy = self.yurayuralabel.center.y+80;
//    pt = CGPointMake(cx, cy-50);
    
//    [UIView animateWithDuration:1.5
//                          delay:1
//                        options:animeOptions animations:^{
//                            self.yurayuralabel.center = pt;
//                            self.yurayuralabel.alpha = 0.2;
//                        } completion:nil];
    
//}

-(void)animationlabelAnimation{
    UIViewAnimationOptions animeOptions =
    UIViewAnimationOptionCurveEaseInOut
    | UIViewAnimationOptionAutoreverse
    | UIViewAnimationOptionRepeat;
    
    cx = self.animationlabel.center.x+50;
    cy = self.animationlabel.center.y+80;
    pt = CGPointMake(cx, cy-50);
    
    [UIView animateWithDuration:1.5
                          delay:1
                        options:animeOptions animations:^{
                            self.animationlabel.center = pt;
                            self.animationlabel.alpha = 0.2;
                        } completion:nil];
}

@end
