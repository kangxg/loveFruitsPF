//
//  KGADViewController.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGADViewController.h"
#import "UIDevice+Extension.h"
#import "UIImageView+WebCache.h"
#import "GlobelDefine.h"
#import "KGBaseNetworkService.h"
#import "KGMainAD.h"
@interface KGADViewController ()
@property (nonatomic,retain)UIImageView * MBackImageView ;
@property (nonatomic,retain)NSMutableArray< AD  *>  *dataArr;

@end

@implementation KGADViewController
-(id)init
{
    if (self = [super init])
    {
        _dataArr = [[NSMutableArray alloc]init];
        [self loadAdImages];
    }
    return self;
}


-(void)loadImageFail
{

     [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadFail object:nil];

    
}

-(void)loadAdView:(int )order  imageName:(NSArray *)arr
{
    if (arr.count<1) {
        [self loadImageFail];
        return;
    }
    KGWEAKOBJECT(weakSelf);
    if (order > arr.count-1)
    {

        [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationFade];
        dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.5);
        dispatch_after(time1, dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadSecussed object:self.MBackImageView.image];
        });
        return;
    }
    NSString * placeholderImageName = nil;
    
    int  t  =   [UIDevice currentDeviceScreenMeasurement];
    
    switch (t)
    {
        case 3:
            placeholderImageName = @"iphone4";
            break;
            
        case 4:
            placeholderImageName = @"iphone5";
            break;
            
        case 5:
            placeholderImageName = @"iphone6";
            break;
            
        default:
            placeholderImageName = @"iphone6s";
            break;
    }
 
    AD * ad = arr[order];
    if (!ad)
    {
         [weakSelf loadImageFail];
        return;
    }
    UIImage * image = self.MBackImageView.image ?self.MBackImageView.image :[UIImage imageNamed:placeholderImageName];
    [self.MBackImageView sd_setImageWithURL:[NSURL URLWithString:ad.img_name] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error)
        {
            NSLog(@"加载广告失败");
            [weakSelf loadImageFail];
            
        }
        if (image !=nil)
        {
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.0);
            dispatch_after(time, dispatch_get_main_queue(), ^
                           {
                            
                               [weakSelf loadAdView:(order+1) imageName:arr];
                           });
            
        }
        else
        {
            NSLog(@"加载广告失败");
            [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadFail object:nil];
        }
    }];

    
}
-(void)loadADView:(NSString *)imageName
{
    KGWEAKOBJECT(weakSelf);
    NSString * placeholderImageName = nil;
    
    int  t  =   [UIDevice currentDeviceScreenMeasurement];
    
    switch (t)
    {
        case 3:
            placeholderImageName = @"iphone4";
            break;
            
        case 4:
            placeholderImageName = @"iphone5";
            break;
            
        case 5:
            placeholderImageName = @"iphone6";
            break;
            
        default:
            placeholderImageName = @"iphone6s";
            break;
    }
    if (imageName == nil)
    {
        self.MBackImageView.image = [UIImage imageNamed:placeholderImageName];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.0);
        dispatch_after(time, dispatch_get_main_queue(), ^
                       {
                           [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationFade];
                           dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.5);
                           dispatch_after(time1, dispatch_get_main_queue(), ^{
                               [weakSelf loadImageFail];
//                               [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadSecussed object:placeholderImageName];
                           });
                       });

    }
    else
    {
        [self.MBackImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error)
            {
                NSLog(@"加载广告失败");
                [weakSelf loadImageFail];
                
            }
            if (image !=nil)
            {
                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.0);
                dispatch_after(time, dispatch_get_main_queue(), ^
                               {
                                   [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationFade];
                                   dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.5);
                                   dispatch_after(time1, dispatch_get_main_queue(), ^{
                                       [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadSecussed object:image];
                                   });
                               });
                
            }
            else
            {
                NSLog(@"加载广告失败");
                [[NSNotificationCenter defaultCenter] postNotificationName:ADImageLoadFail object:nil];
            }
        }];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createbackImageView];
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:false];
    
    
   
    // Do any additional setup after loading the view.
}

-(void)loadAdImages
{
    KGWEAKOBJECT(weakSelf);
    NSDictionary  * dic = @{@"splash_type":@"zwsjpfapp"};
    [KGBaseNetworkService POST:URL(KGBaseUrl, @"/course_api/splash")
                        params:dic
                       success:^(id object)
     {
         NSMutableDictionary * jsonDic = nil;
         if ([object isKindOfClass:[NSDictionary class]]) {
             jsonDic = object;
         }
         else
         {
             jsonDic=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
         }
         
         
         float sucess = [[jsonDic objectForKey:@"status"] boolValue];
         
         if (sucess)
         {
             
             NSArray  * arr  =    [jsonDic valueForKey:@"data"];
             [weakSelf putDataArr:arr];
           
         }
         else
         {
             [weakSelf loadImageFail];
         }
         
     }
     
     failed:^(id object)
     {
         [weakSelf loadImageFail];
         
     }];

}

-(void)putDataArr:(NSArray *)arr
{
    if (arr == nil || arr.count == 0)
    {
         [self loadImageFail];
         return;
    }
    for (NSDictionary  * dic  in arr)
    {
        AD * ad = [[AD alloc]init];
        [ad putInDataFordic:dic];
        [_dataArr addObject:ad];
    }
    
    if (_dataArr.count)
    {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"picOrder" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
        [_dataArr sortUsingDescriptors:descriptors];
    }
  
    [self loadAdView:0 imageName:_dataArr];
}

-(UIImageView *)MBackImageView
{
    if (_MBackImageView == nil)
    {
        _MBackImageView = [[UIImageView alloc]init];
        _MBackImageView.frame = ScreenBounds;
        NSString * placeholderImageName = nil;
        int  t  =   [UIDevice currentDeviceScreenMeasurement];
        switch (t)
        {
            case 3:
                placeholderImageName = @"iphone4";
                break;
                
            case 4:
                placeholderImageName = @"iphone5";
                break;
                
            case 5:
                placeholderImageName = @"iphone6";
                break;
                
            default:
                placeholderImageName = @"iphone6s";
                
                break;
        }
        _MBackImageView.image = [UIImage imageNamed:placeholderImageName];
        [self.view addSubview:_MBackImageView];
        
    }
    return _MBackImageView;

}
-(void)createbackImageView
{
    [self.view addSubview:self.MBackImageView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@interface KGADTopViewController ()
@property (nonatomic,retain)UIImageView * MBackImageView ;


@end
@implementation KGADTopViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.MBackImageView];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:false];
}
-(UIImageView *)MBackImageView
{
    if (_MBackImageView == nil)
    {
        _MBackImageView = [[UIImageView alloc]init];
        _MBackImageView.frame = ScreenBounds;
        NSString * placeholderImageName = nil;
        int  t  =   [UIDevice currentDeviceScreenMeasurement];
        switch (t)
        {
            case 3:
                placeholderImageName = @"iphone4";
                break;
                
            case 4:
                placeholderImageName = @"iphone5";
                break;
                
            case 5:
                placeholderImageName = @"iphone6";
                break;
                
            default:
                placeholderImageName = @"iphone6s";
                
                break;
        }
        _MBackImageView.image = [UIImage imageNamed:placeholderImageName];
        [self.view addSubview:_MBackImageView];
        
    }
    return _MBackImageView;
    
}
@end
