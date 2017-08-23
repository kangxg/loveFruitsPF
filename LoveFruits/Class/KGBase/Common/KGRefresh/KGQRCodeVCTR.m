//
//  KGQRCodeVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGQRCodeVCTR.h"
#import <AVFoundation/AVFoundation.h>
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
@interface KGQRCodeVCTR()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,retain)UILabel                     *    MTitleLabel;
@property (nonatomic,retain)UIImageView                 *    MAnimationLineView;
@property (nonatomic,retain)NSTimer                     *    MTimer;
@property (nonatomic,retain)AVCaptureSession            *    MCaptureSession;
@property (nonatomic,retain)AVCaptureVideoPreviewLayer  *    MPreviewLayer;
@property (nonatomic,retain)CALayer                     *    MTargetLayer;
@property (nonatomic, strong)NSMutableArray             *    MCodeObjects;
@end



@implementation KGQRCodeVCTR

CGMutablePathRef createPathForPoints(NSArray* points)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point;
    if ([points count] > 0)
    {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)[points objectAtIndex:0], &point);
        CGPathMoveToPoint(path, nil, point.x, point.y);
        int i = 1;
        while (i < [points count])
        {
            CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)[points objectAtIndex:i], &point);
            CGPathAddLineToPoint(path, nil, point.x, point.y);
            i++;
        }
        CGPathCloseSubpath(path);
    }
    return path;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildNavigationItem];
    [self buildInputAVCaptureDevice];
    [self buildFrameImageView];
    [self.view addSubview:self.MTitleLabel];
    [self buildAnimationLineView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_MTimer != nil)
    {
        [_MTimer invalidate];
        _MTimer = nil;
    }
    [self stopRunning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}
-(void)buildNavigationItem
{
    [self.navigationItem setTitle:@"店铺二维码"];
    self.navigationController.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor;
    
}

-(void)buildInputAVCaptureDevice
{

  [self.MCaptureSession startRunning];
    
}
-(AVCaptureSession *)MCaptureSession
{
    if (_MCaptureSession == nil)
    {
        _MCaptureSession = [AVCaptureSession new];
        AVCaptureDevice * captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError * error;
        if (captureDevice.isAutoFocusRangeRestrictionSupported)
        {
            if ([captureDevice lockForConfiguration:&error])
            {
                [captureDevice setAutoFocusRangeRestriction:AVCaptureAutoFocusRangeRestrictionNear];
                [captureDevice unlockForConfiguration];
            }
        }
        self.MTitleLabel.text           = @"将店铺二维码对准方块内既可收藏店铺";
        
        AVCaptureDeviceInput * input    = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        
        if (input ==nil)
        {
            
            self.MTitleLabel.text           = @"没有摄像头你描个蛋啊~换真机试试";
        }
        
        if ([self.MCaptureSession canAddInput:input])
        {
            [self.MCaptureSession addInput:input];
        }
        
        AVCaptureMetadataOutput * captureMetadataOutput = [AVCaptureMetadataOutput new];
        
        if ([self.MCaptureSession canAddOutput:captureMetadataOutput])
        {
            dispatch_queue_t   dispatchQueue = dispatch_queue_create("myQueue", nil);
            [self.MCaptureSession addOutput:captureMetadataOutput];
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
            captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
        }
        
        
        
        
        
        
        _MPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_MCaptureSession];
        _MPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _MPreviewLayer.frame        = self.view.frame;
        [self.view.layer addSublayer:_MPreviewLayer];
        captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1);
//        [captureMetadataOutput setRectOfInterest:CGRectMake(100,100,ScreenWidth * 0.6, ScreenWidth * 0.6)];
        _MTargetLayer = [CALayer layer];
        _MTargetLayer.frame = self.view.bounds;
        [self.view.layer addSublayer:_MTargetLayer];
        
    }
    return _MCaptureSession;
}
-(void)buildFrameImageView
{

    NSArray * lineT = @[[NSValue valueWithCGRect:CGRectMake(0, 0, ScreenWidth, 100)],
                        [NSValue valueWithCGRect:CGRectMake(0, 100, ScreenWidth * 0.2, ScreenWidth * 0.6)],
                        [NSValue valueWithCGRect:CGRectMake(0, 100 + ScreenWidth * 0.6, ScreenWidth, ScreenHeight - 100 - ScreenWidth * 0.6)],
                        [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8, 100, ScreenWidth * 0.2, ScreenWidth * 0.6)]];
    for (NSValue * value in lineT)
    {
        [self buildTransparentView:value];
    }
    
    NSArray * lineR =  @[[NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.2, 100, ScreenWidth * 0.6, 2)],
                 [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.2, 100, 2, ScreenWidth * 0.6)],
                 [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8 - 2, 100, 2, ScreenWidth * 0.6)],
                         [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.2, 100 + ScreenWidth * 0.6, ScreenWidth * 0.6, 2)]];
    for (NSValue * value in lineR)
    {
        [self buildTransparentView:value];
    }
    
    CGFloat yellowHeight  = 4;
    CGFloat yellowWidth   = 30;
    CGFloat yellowX       = ScreenWidth * 0.2;
    CGFloat bottomY       = 100 + ScreenWidth * 0.6;
    
    NSArray * lineY       = @[[NSValue valueWithCGRect:CGRectMake(yellowX, 100, yellowWidth, yellowHeight)],
                              [NSValue valueWithCGRect:CGRectMake(yellowX, 100, yellowHeight, yellowWidth)],
                              [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8 - yellowHeight, 100, yellowHeight, yellowWidth)],
                              [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8 - yellowWidth, 100, yellowWidth, yellowHeight)],
                              [NSValue valueWithCGRect:CGRectMake(yellowX, bottomY - yellowHeight + 2, yellowWidth, yellowHeight)],
                              [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8 - yellowWidth, bottomY - yellowHeight + 2, yellowWidth, yellowHeight)],
                              [NSValue valueWithCGRect:CGRectMake(yellowX, bottomY - yellowWidth, yellowHeight, yellowWidth)],
                              [NSValue valueWithCGRect:CGRectMake(ScreenWidth * 0.8 - yellowHeight, bottomY - yellowWidth, yellowHeight, yellowWidth)]];
    for (NSValue * value in lineY)
    {
        [self buildYellowLineView:value];
    }
    
}
-(UILabel *)MTitleLabel
{
    if (_MTitleLabel == nil)
    {
        _MTitleLabel                 =   [[UILabel alloc]init];
        _MTitleLabel.textColor       =   [UIColor whiteColor];
        _MTitleLabel.font            =   [UIFont systemFontOfSize:16];
        _MTitleLabel.frame           =   CGRectMake(0, 340, ScreenWidth, 30);
        _MTitleLabel.textAlignment   =   NSTextAlignmentCenter;
    }
    return  _MTitleLabel;
}
-(void)buildAnimationLineView
{
    [self.view addSubview:self.MAnimationLineView];
    NSRunLoop * runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.MTimer forMode:NSRunLoopCommonModes];
    [self.MTimer fire];
}

-(UIImageView *)MAnimationLineView
{
    if (_MAnimationLineView == nil)
    {
        _MAnimationLineView = [[UIImageView alloc]init];
        _MAnimationLineView.image = [UIImage imageNamed:@"yellowlight"];
        
    }
    return _MAnimationLineView;
}

-(NSTimer *)MTimer
{
    if (_MTimer == nil)
    {
        _MTimer = [NSTimer timerWithTimeInterval:2.5f target:self selector:@selector(startYellowViewAnimation) userInfo:nil repeats:YES];
    }
    
    return _MTimer;
}

-(void)startYellowViewAnimation
{
    __weak KGQRCodeVCTR * weakSelf = self;
    self.MAnimationLineView.frame = CGRectMake(ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, 100, ScreenWidth * 0.5, 20);
    [UIView animateWithDuration:2.5 animations:^{
        CGRect frame = weakSelf.MAnimationLineView.frame;
        frame.origin.y += ScreenWidth * 0.55;
        weakSelf.MAnimationLineView.frame = frame;
    }];
}
-(void)buildTransparentView:(NSValue *)value
{
  
    UIView * tView = [[UIView alloc]initWithFrame:[value CGRectValue]];
    tView.backgroundColor = [UIColor blackColor];
    tView.alpha = 0.5;
    [self.view addSubview:tView];

}

-(void)buildLineView:(NSValue *)value
{
    UIView * tView = [[UIView alloc]initWithFrame:[value CGRectValue]];
    tView.backgroundColor =  [UIColor colorWithCustom:230 withGreen:230 withBlue:230];
   
    [self.view addSubview:tView];
}

-(void)buildYellowLineView:(NSValue *)value
{
    UIView * tView = [[UIView alloc]initWithFrame:[value CGRectValue]];
    tView.backgroundColor =  LFBNavigationYellowColor;
    [self.view addSubview:tView];
}
- (void)startRunning
{
    self.MCodeObjects = nil;
    [self.MCaptureSession startRunning];
}

- (void)stopRunning
{
    [self.MCaptureSession stopRunning];
    self.MCaptureSession = nil;
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self.MCaptureSession stopRunning];
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
        _MTitleLabel.text = obj.stringValue;
        //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:obj.stringValue]];
    }
    
//    self.MCodeObjects = nil;
//    for (AVMetadataObject *metadataObject in metadataObjects)
//    {
//        AVMetadataObject *transformedObject = [self.MPreviewLayer transformedMetadataObjectForMetadataObject:metadataObject];
//        [self.MCodeObjects addObject:transformedObject];
//    }
    
    [self clearTargetLayer];
//    [self showDetectedObjects];
    [self playSound];
    [self stopRunning];

}
-(void)playSound
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"qrcode_found" ofType:@"wav"];
    
    
    
    if (path.length)
    {
        SystemSoundID soundID = 0;
        NSURL * soundURL =  [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &soundID);
        
        AudioServicesPlayAlertSound(soundID);

        
    }
    

    
}
-(NSMutableArray *)MCodeObjects
{
    if (_MCodeObjects == nil)
    {
        _MCodeObjects = [NSMutableArray new];
    }
    return _MCodeObjects;
}
- (void)clearTargetLayer
{
    NSArray *sublayers = [[self.MTargetLayer sublayers] copy];
    for (CALayer *sublayer in sublayers)
    {
        [sublayer removeFromSuperlayer];
    }
}

- (void)showDetectedObjects
{
    for (AVMetadataObject *object in self.MCodeObjects)
    {
        if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]])
        {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.strokeColor = [UIColor redColor].CGColor;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = 2.0;
            shapeLayer.lineJoin = kCALineJoinRound;
            CGPathRef path = createPathForPoints([(AVMetadataMachineReadableCodeObject *)object corners]);
            shapeLayer.path = path;
            CFRelease(path);
            shapeLayer.backgroundColor = [UIColor redColor].CGColor;
            [self.MTargetLayer addSublayer:shapeLayer];
        }
    }
}
@end


