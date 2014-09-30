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
    AVAudioPlayer *kirakiraboshi_Player;
    AVAudioPlayer *youkaiwhotch_Player;
    AVAudioPlayer *happinesspuricure_Player;

    UIProgressView * progress1;
   
    NSTimer *timer;
    UIView *animationView;
    UIImageView *imageView;
    NSInteger switchnumber;
    CGFloat cx;
    CGFloat cy;
    CGPoint pt;
    NSInteger tenki;
    NSString *tenkistring;
    UIActionSheet *actionsheet;
    NSString *idString;
    NSString *user_todouhuken;
    UIActionSheet *sheet;
    NSString *url_tenki;
    NSArray *orugoru_mp3;
    NSString *orugoru_string;
    NSInteger orugoru_number;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (user_todouhuken == nil) {
        self.basholabel.text = @"徳島県";
        NSLog(@"徳島がデフォルトです");
        idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=360010";
        [self bashoTenkiView];
        
    }else
    [self bashoTenkiView];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    switchnumber = 0;
    cx = 0;
    cy = 0;
    tenki = 0;
    orugoru_Player = 0;
    
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
    if ( error1 != nil )
    {
        NSLog(@"Error %@", [error1 localizedDescription]);
    }
    [mizunooto_Player setDelegate:self];// 自分自身をデリゲートに設定
    
    NSError *error2 = nil;
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"kirakiraboshi" ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url_2 = [[NSURL alloc] initFileURLWithPath:path2];
    kirakiraboshi_Player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_2 error:&error2];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error2 != nil )
    {
        NSLog(@"Error %@", [error2 localizedDescription]);
    }
    [kirakiraboshi_Player setDelegate:self];// 自分自身をデリゲートに設定
    
    NSError *error3 = nil;
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"youkaiwhotch" ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url_3 = [[NSURL alloc] initFileURLWithPath:path3];
    youkaiwhotch_Player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_3 error:&error3];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error3 != nil )
    {
        NSLog(@"Error %@", [error3 localizedDescription]);
    }
    [youkaiwhotch_Player setDelegate:self];// 自分自身をデリゲートに設定

    NSError *error4 = nil;
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"happinesspuricure" ofType:@"mp3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url_4 = [[NSURL alloc] initFileURLWithPath:path4];
    happinesspuricure_Player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_4 error:&error4];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error4 != nil )
    {
        NSLog(@"Error %@", [error4 localizedDescription]);
    }
    [happinesspuricure_Player setDelegate:self];// 自分自身をデリゲートに設定
   
    
    //プログレスバーの表示の調整
    progress1 = [  [ UIProgressView alloc ] initWithProgressViewStyle:UIProgressViewStyleDefault ];
    progress1.frame = CGRectMake( 10, 450, 300, 300 );
    //progress1.transform = CGAffineTransformMakeRotation( -90.0f * M_PI / 180.0f ); // 反時計回りに90度回転して表示する
    progress1.transform = CGAffineTransformMakeScale( 1.0f, 10.0f ); // 横方向に1倍、縦方向に3倍して表示する
    progress1.progressTintColor = [UIColor whiteColor];
    //progress1.alpha = 0.5;
    
    [self.view addSubview:progress1 ];
    progress1.hidden = YES;
    //self.basholabel.text = @"徳島県";
    self.modorubuttonview.hidden = YES;
    self.movinghitsujiimage.hidden = YES;
    self.yurayuralabel.hidden = YES;
    self.hitsujiview.hidden = NO;
    self.basho.hidden = NO;
    self.change_orugarulabel.hidden = YES;
    
    //ユーザが選択した都道府県があればそれをデフォルトとして表示する、保存されている都道府県を取り出してラベルに表示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user_todouhuken = [defaults stringForKey:@"initialLetters"];
    self.basholabel.text = user_todouhuken;
    
    //保存されているはずのユーザが選択した都道府県に対応する天気APIのURLを取り出す
    NSUserDefaults *defaults_1 = [NSUserDefaults standardUserDefaults];
    idString = [defaults_1 stringForKey:@"initialLetters_1"];
    NSLog(@"%@",idString);
    url_tenki = idString;//後で生成するurlrequestのためにurl_tenkiに代入しておく
    
    orugoru_mp3 = [NSArray arrayWithObjects:@"キラキラ星", @"妖怪ウォッチ", @"プリキュア", @"デフォルト", nil];

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
    self.modorubuttonview.hidden = NO;
    if (sender.selectedSegmentIndex == 0) {
        switchnumber = 0;
        self.animationlabel.hidden = NO;
        [self animationlabelAnimation];
        progress1.hidden = NO;
        self.yurayuralabel.hidden = YES;
        self.movinghitsujiimage.hidden = YES;
        self.blackview.hidden = NO;
        self.change_orugarulabel.hidden = NO;

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
        self.yurayuralabel.hidden = YES;
        self.movinghitsujiimage.hidden = NO;
        self.basho.hidden = YES;
        self.blackview.hidden = NO;
        self.hitsujiview.hidden = YES;
        self.change_orugarulabel.hidden = YES;


        //[timer invalidate];
        //[orugoru_Player stop];

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
        NSLog(@"シェイクされました");
        self.basho.hidden = YES;
        self.blackview.hidden = NO;
        [timer invalidate];
        progress1.hidden = NO;
        self.modorubuttonview.hidden = NO;
        self.change_orugarulabel.hidden = NO;


        [progress1 setProgress:(progress1.progress+0.5) animated:YES ]; // アニメーション付きで進捗を指定
        [orugoru_Player play];
        [self timer];
    }else
        nil;
    
}

//傾けられるとこのメソッドが呼ばれる
-(void)startMoving{
    [timer invalidate];
    [orugoru_Player stop];
    
    
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
                                                 if (centerY < 100 && centerY >= 0) {
                                                     [mizunooto_Player play];
                                                  NSLog(@"ゆらゆらされました");}else if (centerY > 468 && centerY >= 568 ){
                                                         [mizunooto_Player play];
                                                                                                    }else if(centerY == 284){
                                                                                                        [mizunooto_Player stop];
                                                                                                    }
                                                 self.yurayuralabel.center = CGPointMake(self.yurayuralabel.center.x, centerY);
                                                 self.movinghitsujiimage.center= CGPointMake(self.yurayuralabel.center.x, centerY);
                                             }];
   
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

//天気によってファーストビューの画像を変える
-(void)selectImage{
    self.hitsujiview.contentMode = UIViewContentModeScaleAspectFit;
    if (tenki == 0) {
        self.hitsujiview.image = [UIImage imageNamed:@"TOP-2-1.png"];
    }else if (tenki == 1){
        self.hitsujiview.image = [UIImage imageNamed:@"TOP-2-2.png"];
    }else if (tenki == 2){
        self.hitsujiview.image = [UIImage imageNamed:@"TOP-2-3.png"];
    }
}

//都道府県をアクションシートの中のボタンで選択してもらうので、そのためのアクションシートとボタンを生成
- (IBAction)bashobutton:(UIButton *)sender {
    sheet = [[UIActionSheet alloc]initWithTitle:@"選んでください"
                                                      delegate:self
                                             cancelButtonTitle:@"キャンセル"
                                        destructiveButtonTitle:NULL
                                             otherButtonTitles:@"北海道",@"青森県",@"岩手県",@"宮城県",@"秋田県",@"山形県",@"福島県",@"茨城県",@"栃木県",@"群馬県",
                            @"埼玉県",@"千葉県",@"東京都",@"神奈川県",@"新潟県",@"富山県",@"石川県",@"福井県",@"山梨県",@"長野県",
                            @"岐阜県",@"静岡県",@"愛知県",@"三重県",@"滋賀県",@"京都府",@"大阪府",@"兵庫県",@"奈良県",@"和歌山県",
                            @"鳥取県",@"島根県",@"岡山県",@"広島県",@"山口県",@"徳島県",@"香川県",@"愛媛県",@"高知県",@"福岡県",
                            @"佐賀県",@"長崎県",@"熊本県",@"大分県",@"宮崎県",@"鹿児島県",@"沖縄県", nil];
    [sheet showInView:self.view];

}

//アクションシートのボタンで都道府県を選択されたらこのメソッドが呼ばれる
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //アクションシートで押されたボタンのインデクス
    //idstringは天気APIで使うURL,都道府県によって異なるURL
    switch (buttonIndex) {
        case 0:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=016010";
            //id = 016010;
            self.basholabel.text = @"北海道";//ボタンに重ねてあるラベルに選択された都道府県名を表示する
            break;
        case 1:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=020010";
            //id = 020010;
            self.basholabel.text = @"青森県";
            break;
        case 2:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=030010";
            //id = 030010;
            self.basholabel.text = @"岩手県";
            break;
        case 3:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=040010";
            //id = 040010;
            self.basholabel.text = @"宮城県";
            break;
        case 4:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=050010";
            //id = 050010;
            self.basholabel.text = @"秋田県";
            break;
        case 5:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=060010";
            //id = 060010;
            self.basholabel.text = @"山形県";
            break;
        case 6:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=070010";
            //id = 070010;
            self.basholabel.text = @"福島県";
            break;
        case 7:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=080010";
            //id = 080010;
            self.basholabel.text = @"茨城県";
            break;
        case 8:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=090010";
            //id = 090010;
            self.basholabel.text = @"栃木県";
            break;
        case 9:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=100010";
            //id = 100010;
            self.basholabel.text = @"群馬県";
            break;
        case 10:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=110010";
            //id = 110010;
            self.basholabel.text = @"埼玉県";
            break;
        case 11:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=120010";
            //id = 120010;
            self.basholabel.text = @"千葉県";
            break;
        case 12:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";
            //id = 130010;
            self.basholabel.text = @"東京都";
            break;
        case 13:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=140010";
            //id = 140010;
            self.basholabel.text = @"神奈川県";
            break;
        case 14:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=150010";
            //id = 150010;
            self.basholabel.text = @"新潟県";
            break;
        case 15:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=160010";
            //id = 160010;
            self.basholabel.text = @"富山県";
            break;
        case 16:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=170010";
            //id = 170010;
            self.basholabel.text = @"石川県";

            break;
        case 17:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=180010";
            //id = 180010;
            self.basholabel.text = @"福井県";

            break;
        case 18:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=190010";
            //id = 190010;
            self.basholabel.text = @"山梨県";

            break;
        case 19:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=200010";
            //id = 200010;
            self.basholabel.text = @"長野県";

            break;
        case 20:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=210010";
            //id = 210010;
            self.basholabel.text = @"岐阜県";

            break;
        case 21:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=220010";
            //id = 220010;
            self.basholabel.text = @"静岡県";

            break;
        case 22:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=230010";
            //id = 230010;
            self.basholabel.text = @"愛知県";

            break;
        case 23:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=240010";
            //id = 240010;
            self.basholabel.text = @"三重県";

            break;
        case 24:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=250010";
            //id = 250010;
            self.basholabel.text = @"滋賀県";

            break;
        case 25:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=260010";
            //id = 260010;
            self.basholabel.text = @"京都府";

            break;
        case 26:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=270010";
            //id = 270010;
            self.basholabel.text = @"大阪県";

            break;
        case 27:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=280010";
            //id = 280010;
            self.basholabel.text = @"兵庫県";

            break;
        case 28:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=290010";
            //id = 290010;
            self.basholabel.text = @"奈良県";

            break;
        case 29:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=300010";
            //id = 300010;
            self.basholabel.text = @"和歌山県";

            break;
        case 30:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=310010";
            //id = 310010;
            self.basholabel.text = @"鳥取県";

            break;
        case 31:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=320010";
            //id = 320010;
            self.basholabel.text = @"島根県";
            break;
        case 32:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=330010";
            //id = 330010;
            self.basholabel.text = @"岡山県";

            break;
        case 33:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=340010";
            //id = 340010;
            self.basholabel.text = @"広島県";

            break;
        case 34:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=350010";
            //id = 350010;
            self.basholabel.text = @"山口県";

            break;
        case 35:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=360010";
            //id = 360010;
            self.basholabel.text = @"徳島県";

            break;
        case 36:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=370010";
            //id = 370010;
            self.basholabel.text = @"香川県";

            break;
        case 37:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=380010";
            //id = 380010;
            self.basholabel.text = @"愛媛県";

            break;
        case 38:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=390010";
            //id = 390010;
            self.basholabel.text = @"高知県";

            break;
        case 39:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=400010";
            //id = 400010;
            self.basholabel.text = @"福岡県";

            break;
        case 40:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=410010";
            //id = 410010;
            self.basholabel.text = @"佐賀県";

            break;
        case 41:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=420010";
            //id = 420010;
            self.basholabel.text = @"長崎県";

            break;
        case 42:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=430010";
            //id = 430010;
            self.basholabel.text = @"熊本県";

            break;
        case 43:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=440010";
            //id = 440010;
            self.basholabel.text = @"大分県";

            break;
        case 44:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=450010";
            //id = 450010;
            self.basholabel.text = @"宮崎県";

            break;
        case 45:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=460010";
            //id = 460010;
            self.basholabel.text = @"鹿児島県";

            break;
        case 46:
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=471010";
            //id = 471010;
            self.basholabel.text = @"沖縄県";

            break;
    
        case 47:
            //ボタン意外の場所を押したとき
            idString = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

            break;
        default:
            break;
    }
    url_tenki = idString;
    [self bashoTenkiView];
    user_todouhuken = self.basholabel.text;//ユーザが選んだ都道府県を代入しておく
    
    //ユーザが選択した都道府県のデータの保存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user_todouhuken forKey:@"initialLetters"];
    
    //ユーザが選択した都道府県に対応するのURLの保存
    NSUserDefaults *defaults_1 = [NSUserDefaults standardUserDefaults];
    [defaults_1 setObject:idString forKey:@"initialLetters_1"];
    
    NSLog(@"%@",idString);
}

-(void)bashoTenkiView{
    //都道府県がユーザに選択されていない場合はデフォルト徳島県を適用
    NSLog(@"%@",user_todouhuken);
   
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_tenki]];
    NSData *json_raw_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jstr = [[NSString alloc] initWithData:json_raw_data encoding:NSUTF8StringEncoding];
    NSString *cricket_left = @"[";
    NSString *cricket_right = @"]";
    
    jstr = [[cricket_left stringByAppendingString:jstr] stringByAppendingString:cricket_right];
    
    
    NSData *json_data = [jstr dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSError *error=nil;
    NSArray *jarray = [NSJSONSerialization JSONObjectWithData:json_data                       options:NSJSONReadingAllowFragments
                                                        error:&error];
    
    NSDictionary *dic;
    
    for (NSDictionary *obj in jarray)
    {
        dic = obj;
    }
    NSLog(@"%@",[[[dic objectForKey:@"forecasts"] objectAtIndex:1] objectForKey:@"telop"]);
    
    //ファーストビューを天気によって変える準備
    tenkistring = [[[dic objectForKey:@"forecasts"] objectAtIndex:1] objectForKey:@"telop"];
    if ([tenkistring isEqualToString:@"晴れ"] || [tenkistring isEqualToString:@"晴のち曇"] || [tenkistring isEqualToString:@"晴のち雨"]  || [tenkistring isEqualToString:@"晴時々雨"]  || [tenkistring isEqualToString:@"晴時々曇"]) {
        NSLog(@"晴れ画像表示");
        tenki = 0;
    }else if ([tenkistring isEqualToString:@"曇り"] || [tenkistring isEqualToString:@"曇のち晴"] || [tenkistring isEqualToString:@"曇のち雨"] || [tenkistring isEqualToString:@"曇時々雨"]  || [tenkistring isEqualToString:@"曇時々晴"]){
        NSLog(@"曇り画像表示");
        tenki = 1;
    }else if ([tenkistring isEqualToString:@"雨"] || [tenkistring isEqualToString:@"雨のち曇"] || [tenkistring isEqualToString:@"雨のち晴"]
              || [tenkistring isEqualToString:@"雨時々曇"]  || [tenkistring isEqualToString:@"雨時々晴"]){
        NSLog(@"雨画像表示");
        tenki = 2;
    }
    [self selectImage];//天気に合うファーストビューを表示
    
    

}

- (IBAction)modorubutton:(UIButton *)sender {
    [self defaultpege];
    self.basho.hidden = NO;
    [orugoru_Player stop];
    orugoru_Player.currentTime = 0;
    [kirakiraboshi_Player stop];
    kirakiraboshi_Player.currentTime = 0;
    [youkaiwhotch_Player stop];
    youkaiwhotch_Player.currentTime = 0;
    [happinesspuricure_Player stop];
    happinesspuricure_Player.currentTime = 0;
}

-(void)defaultpege{
    [timer invalidate];
    progress1.progress = 0;
    [orugoru_Player stop];
    [mizunooto_Player stop];
    
    //再生位置を頭(currentTime = 0)に戻す
    orugoru_Player.currentTime = 0;
    [self.view addSubview:progress1 ];
    progress1.hidden = YES;
    self.movinghitsujiimage.hidden = YES;
    self.hitsujiview.hidden = NO;
    self.yurayuralabel.hidden = YES;
    self.modorubuttonview.hidden = YES;
    self.blackview.hidden = YES;
    self.change_orugarulabel.hidden = YES;
    [self bashoTenkiView];
    
    if (switchnumber == 1) {
        self.animationlabel.hidden = YES;
        self.yurayuralabel.hidden = NO;
        [self startMoving];
    }else if(switchnumber == 0){
        self.animationlabel.hidden = NO;
        self.yurayuralabel.hidden = YES;
    }
}
- (IBAction)change_orugoru:(UIButton *)sender {
    //orugoru_mp3配列から順番に取り出す
    switch (orugoru_number) {
        case 0:
            orugoru_string = [orugoru_mp3 objectAtIndex:0];
            NSLog(@"%@",orugoru_string);
            orugoru_number++;
            [orugoru_Player stop];
            orugoru_Player.currentTime = 0;
            [kirakiraboshi_Player play];

            break;
        case 1:
            orugoru_string = [orugoru_mp3 objectAtIndex:1];
            NSLog(@"%@",orugoru_string);
            orugoru_number++;
            [kirakiraboshi_Player stop];
            kirakiraboshi_Player.currentTime = 0;
            [youkaiwhotch_Player play];

            break;
        case 2:
            orugoru_string = [orugoru_mp3 objectAtIndex:2];
            NSLog(@"%@",orugoru_string);
            orugoru_number++;
            [youkaiwhotch_Player stop];
            youkaiwhotch_Player.currentTime = 0;
            [happinesspuricure_Player play];
            break;
        case 3:
            orugoru_string = [orugoru_mp3 objectAtIndex:3];
            NSLog(@"%@",orugoru_string);
            orugoru_number = 0;
            [happinesspuricure_Player stop];
            happinesspuricure_Player.currentTime = 0;
            [orugoru_Player play];
            break;
        default:
            break;
    }
}


@end
