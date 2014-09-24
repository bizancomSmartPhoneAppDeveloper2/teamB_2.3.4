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
    AVAudioPlayer *audioPlayer;
    UIProgressView * progress1;
   
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //タイマースタートと同時に効果音鳴らす
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"yurikagonouta" ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error != nil )
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    [audioPlayer setDelegate:self];// 自分自身をデリゲートに設定
    
    
    progress1 = [  [ UIProgressView alloc ] initWithProgressViewStyle:UIProgressViewStyleDefault ];
    progress1.frame = CGRectMake( 10, 400, 300, 300 );
    //progress1.transform = CGAffineTransformMakeRotation( -90.0f * M_PI / 180.0f ); // 反時計回りに90度回転して表示する
    progress1.transform = CGAffineTransformMakeScale( 1.0f, 10.0f ); // 横方向に1倍、縦方向に3倍して表示する

    [self.view addSubview:progress1 ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startbutton:(UIButton *)sender {
    
    if (progress1.progress != 0) {
        [audioPlayer play];
            }else
        nil;
}

// 今回は、ボタンを押す毎に進捗度合いを0.2ずつ増加させる例となります。
-(IBAction)addFive:(id)sender {
   // [timer invalidate];
   // [progress1 setProgress:(progress1.progress+0.2) animated:YES ]; // アニメーション付きで進捗を指定
    
   // [audioPlayer play];
   // [self timer];

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
        [audioPlayer stop];
        NSLog(@"音楽停止");
        [timer invalidate];
    }
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [timer invalidate];
    [progress1 setProgress:(progress1.progress+0.2) animated:YES ]; // アニメーション付きで進捗を指定
    
    [audioPlayer play];
    [self timer];

}
@end
