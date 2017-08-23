//
//  KGAnimationTabBarController.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAnimationTabBarController.h"
#import "GlobelDefine.h"
#import "KGAnimatedTabBarItem.h"
#import "KGShopCarRedDotView.h"
#import "KGShopCartVCTR.h"
#import "KGBaseNavigationController.h"
@interface KGAnimationTabBarController ()
@property (nonatomic,retain)NSMutableArray * MIconsView;
@property (nonatomic,retain)NSArray        * MIconsImageName;
@property (nonatomic,retain)NSArray        * MIconsSelectedImageName;
@property (nonatomic,retain)UIImageView    * MShopCarIcon;

@property (nonatomic,retain)NSMutableArray <CALayer *> * MAnimationLayers;
@property (nonatomic,retain)NSMutableArray <CALayer *> * MAnimationBigLayers;
@end

@implementation KGAnimationTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MIconsView = [[NSMutableArray alloc]init];
    _MIconsImageName = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
    _MIconsSelectedImageName = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchViewControllerDeinit
{
    if (self.MShopCarIcon != nil)
    {
        KGShopCarRedDotView * redDotView = [KGShopCarRedDotView sharedRedDotView];
        redDotView.frame = CGRectMake(21 + 1, -3, 15, 15);
        [_MShopCarIcon addSubview:redDotView];
    }
}
-(NSDictionary *)createViewContainers
{
    NSMutableDictionary * containersDict = [NSMutableDictionary new];
 
    for (int i = 0; i<self.tabBar.items.count; i++)
    {
        UIView * viewContainer = [self createViewContainer:i];
        NSString * key = [NSString stringWithFormat:@"container%d",i];
        [containersDict setValue:viewContainer forKey:key];
    }
    return containersDict;
}

-(UIView *)createViewContainer:(int) index
{
    CGFloat  count = self.tabBar.items.count;
    
    if (!count)
    {
        return  nil;
    }
    
    CGFloat viewWidth   = ScreenWidth/count;
    CGFloat viewHeight  = self.tabBar.bounds.size.height;
    UIView * viewContainer = [[UIView alloc]initWithFrame: CGRectMake(viewWidth * (CGFloat)index , 0, viewWidth, viewHeight)];
    viewContainer.userInteractionEnabled = YES;
    [self.tabBar addSubview:viewContainer];
    viewContainer.tag = index;
  
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabBarClick:)];
    [viewContainer addGestureRecognizer:tap];
    return viewContainer;
    
}

-(void)tabBarClick:(UITapGestureRecognizer *)tap
{
    
}
-(void)createCustomIcons:(NSDictionary *)containers
{
    NSArray<UITabBarItem *> *items = self.tabBar.items;
    
    if (items)
    {
        [items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            NSAssert(obj.image != nil, @"add image icon in UITabBarItem");
            
            NSString * key = [NSString stringWithFormat:@"container%lu",(unsigned long)idx];
            UIView   * container  = [containers objectForKey:key];
            CGFloat imageW = 21;
            CGFloat imageX = (ScreenWidth / (CGFloat)items.count - imageW) * 0.5;
            CGFloat imageY = 8;
            CGFloat imageH = 21;
            UIImageView * icon = [[UIImageView alloc]initWithFrame: CGRectMake(imageX,imageY,imageW, imageH)];
            icon.image = obj.image;
            [icon setTintColor:[UIColor clearColor]];
            //[icon setBackgroundColor:[UIColor redColor]];
             [container addSubview:icon];
            
            UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, ScreenWidth / (CGFloat)items.count, 49 - 32)];
            //textLabel.frame = CGRectMake(0, 32, ScreenWidth / (CGFloat)items.count, 49 - 32);
            textLabel.text = obj.title;
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.font = [UIFont systemFontOfSize:10];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.textColor = [UIColor grayColor];
            textLabel.translatesAutoresizingMaskIntoConstraints = false;
            CGFloat  textLabelWidth = self.tabBar.frame.size.width / (CGFloat)self.tabBar.items.count;
            CGRect frame = textLabel.frame;
            frame.size.width = textLabelWidth;
            textLabel.frame = frame;
           
            [container  addSubview:textLabel];
            if (idx == 2)
            {
                KGShopCarRedDotView * redDotView = [KGShopCarRedDotView sharedRedDotView];
                redDotView.frame = CGRectMake(imageH + 1, -3, 15, 15);
                [icon addSubview:redDotView];
                _MShopCarIcon = icon;
            }
            
            NSDictionary * iconsAndLabels = @{@"icon":icon,@"textLabel":textLabel};
            [_MIconsView addObject:iconsAndLabels];
            obj.image = nil;
            obj.title = @"";
            if (idx == 0)
            {
                self.selectedIndex = 0;
                [self selectItem:0];
            }
        }];
        }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    [self setSelectIndex:self.selectedIndex withTag:item.tag];
}

-(void)selectItem:(NSInteger )index
{
    NSArray<UITabBarItem *> *items = self.tabBar.items;
    UIImageView *  selectIcon = [_MIconsView[index] objectForKey:@"icon"];
    selectIcon.image = [UIImage imageNamed:_MIconsSelectedImageName[index]];
    KGAnimatedTabBarItem  * item = (KGAnimatedTabBarItem *)items[index];
    
    [item selectedState:selectIcon textLabel:[_MIconsView[index] objectForKey:@"textLabel"]];
    
}

-(void)setSelectIndex:(NSInteger)from withTag:(NSInteger)tag
{
//    if (tag == 2 )
//    {
//        UIViewController * vc = self.childViewControllers[self.selectedIndex];
//        KGShopCartVCTR * shopCar = [[KGShopCartVCTR alloc]init];
//        KGBaseNavigationController * nav = [[KGBaseNavigationController alloc]initWithRootViewController:shopCar];
//        [vc presentViewController:nav animated:YES completion:nil];
//          return;
//    }
    self.selectedIndex = tag;
    UIImageView * fromIV = [_MIconsView[from] objectForKey:@"icon"];
    fromIV.image = [UIImage imageNamed:_MIconsImageName[from]];
    KGAnimatedTabBarItem * item =  (KGAnimatedTabBarItem *) self.tabBar.items[from];
    [item deselectAnimation:fromIV textLabel:[_MIconsView[from] objectForKey:@"textLabel"] defaultTextColor:[UIColor grayColor]];
    
    UIImageView * toIV = [_MIconsView[tag] objectForKey:@"icon"];
    toIV.image = [UIImage imageNamed:_MIconsSelectedImageName[tag]];
    KGAnimatedTabBarItem * item2 =  (KGAnimatedTabBarItem *) self.tabBar.items[tag];
    [item2 playAnimation:toIV textLabel:[_MIconsView[tag] objectForKey:@"textLabel"] ];
  

    
    
    
}

-(NSMutableArray<CALayer *> *)MAnimationLayers
{
    if (_MAnimationLayers == nil)
    {
        _MAnimationLayers = [[NSMutableArray alloc]init];
    }
    return  _MAnimationLayers;
}

-(NSMutableArray<CALayer *> *)MAnimationBigLayers
{
    if (_MAnimationBigLayers == nil)
    {
        _MAnimationBigLayers = [[NSMutableArray alloc]init];
    }
    return  _MAnimationBigLayers;
}
-(void)addProductsAnimation:(UIImageView *)imageView
{
    if (!imageView)
    {
        return;
    }
    if (_MAnimationLayers == nil)
    {
        _MAnimationLayers = [[NSMutableArray alloc]init];
    }
    
    CGRect  frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *  transitionLayer = [CALayer layer];
    
    transitionLayer.frame = frame;
    
    transitionLayer.contents = imageView.layer.contents;
    
    [self.view.layer addSublayer:transitionLayer];
    
    [_MAnimationLayers  addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    float width = self.view.frame.size.width;
    CGPoint p3 = CGPointMake(width -width/4 - width / 8 , self.view.layer.bounds.size.height - 40);
    
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path  = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y -30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation * opacityAnimation =  [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.5);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    
    CABasicAnimation * transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    transformAnimation.fromValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
    
    
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.1, 0.2, 1)];
    
    
    CAAnimationGroup *  groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];
}
-(void)addProductsToBigShopCarAnimation:(UIImageView *)imageView
{
    if (!imageView)
    {
        return;
    }
    if (self.MAnimationBigLayers == nil)
    {
        _MAnimationBigLayers = [[NSMutableArray alloc]init];
    }
    
    CGRect  frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *  transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    
    [_MAnimationBigLayers  addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    float width = self.view.frame.size.width;
    CGPoint p3 = CGPointMake(width - 40, self.view.layer.bounds.size.height - 40);
    
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path  = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y -30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    
    CABasicAnimation * opacityAnimation =  [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.9);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    
    CABasicAnimation * transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    transformAnimation.fromValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
    
    
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    
    CAAnimationGroup *  groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"BigShopCarAnimation"];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.MAnimationLayers.count)
    {
        CALayer *  transitionLayer = _MAnimationLayers[0];
        transitionLayer.hidden = YES;
        
        [transitionLayer removeFromSuperlayer];
        [_MAnimationLayers removeObject:_MAnimationLayers.firstObject];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
        
    }
    if (self.MAnimationBigLayers.count)
    {
        CALayer *  transitionLayer = _MAnimationBigLayers[0];
        transitionLayer.hidden = YES;
        
        [transitionLayer removeFromSuperlayer];
        [_MAnimationBigLayers removeObject:_MAnimationBigLayers.firstObject];
        [self.view.layer removeAnimationForKey:@"BigShopCarAnimation"];
        
    }
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
