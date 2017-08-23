//
//  KGAnimationViewController.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAnimationViewController.h"
@interface KGAnimationViewController()

@property (nonatomic,retain)NSMutableArray <CALayer *> * MAnimationBigLayers;
@end

@implementation KGAnimationViewController
-(NSMutableArray<CALayer *> *)MAnimationLayers
{
    if (_KGAnimationLayers == nil)
    {
        _KGAnimationLayers = [[NSMutableArray alloc]init];
    }
    return  _KGAnimationLayers;
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
    if (_KGAnimationLayers == nil)
    {
        _KGAnimationLayers = [[NSMutableArray alloc]init];
    }
    
    CGRect  frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *  transitionLayer = [CALayer layer];
    
    transitionLayer.frame = frame;
    
    transitionLayer.contents = imageView.layer.contents;
    
    [self.view.layer addSublayer:transitionLayer];
    
    [_KGAnimationLayers  addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    float width = self.view.frame.size.width;
    CGPoint p3 = CGPointMake(width -width/4 - width / 8 - 6, self.view.layer.bounds.size.height - 40);
    
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
 

    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    
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
        CALayer *  transitionLayer = _KGAnimationLayers[0];
        transitionLayer.hidden = YES;
        
        [transitionLayer removeFromSuperlayer];
        [_KGAnimationLayers removeObject:_KGAnimationLayers.firstObject];
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
@end
