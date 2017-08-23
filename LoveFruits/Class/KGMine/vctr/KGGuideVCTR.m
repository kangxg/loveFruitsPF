//
//  KGGuideVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGGuideVCTR.h"
#import "GlobelDefine.h"
#import "KGGuideCell.h"
@interface KGGuideVCTR()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,retain)UICollectionView * MCollectView;
@property (nonatomic,retain)UIPageControl    * MPageController;
@property (nonatomic,retain)NSArray          * MImageNames;
@property (nonatomic,assign)BOOL               MIsHiddenNextButton;
@end

@implementation KGGuideVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    _MImageNames = @[@"guide_40_1", @"guide_40_2", @"guide_40_3", @"guide_40_4"];
    _MIsHiddenNextButton   = true;
    [self buildCollectionView];
    [self buildPageController];
}

-(void)buildCollectionView
{
    if (_MCollectView == nil)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing      = 0;
        layout.minimumLineSpacing           = 0;
        layout.itemSize                     = ScreenBounds.size;
        layout.scrollDirection              = UICollectionViewScrollDirectionHorizontal;
        
        
        _MCollectView = [[UICollectionView alloc]initWithFrame:ScreenBounds collectionViewLayout:layout];
        
        _MCollectView.delegate     = self;
        _MCollectView.dataSource    = self;
        _MCollectView.showsVerticalScrollIndicator  = false;
        _MCollectView.showsHorizontalScrollIndicator = false;
        _MCollectView.pagingEnabled  = true;
        _MCollectView.bounces        = false;
        [_MCollectView registerClass:[KGGuideCell class] forCellWithReuseIdentifier:@"GuideCell"];
        [self.view addSubview:_MCollectView];

        
    }
    
}

-(void)buildPageController
{
    if (_MPageController == nil)
    {
        _MPageController =  [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 20)];
        _MPageController.numberOfPages = _MImageNames.count;
        _MPageController.currentPage   = 0;
        [self.view addSubview:_MPageController];
        
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _MImageNames.count;

}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KGGuideCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuideCell" forIndexPath:indexPath];
    cell.KGImageView.image = [UIImage imageNamed:_MImageNames[indexPath.row]];
    if (indexPath.row != _MImageNames.count-1)
    {
        [cell setNextButtonHidden:true];
    }
    return cell;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == ScreenWidth *(_MImageNames.count -1))
    {
        KGGuideCell * cell  =(KGGuideCell * )[_MCollectView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_MImageNames.count -1 inSection:0]];
        [cell setNextButtonHidden:false];
        _MIsHiddenNextButton = false;
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    if (scrollView.contentOffset.x != ScreenWidth *(_MImageNames.count -1)  && _MIsHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * (_MImageNames.count - 2))
    {
        KGGuideCell * cell  =(KGGuideCell * )[_MCollectView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_MImageNames.count -1 inSection:0]];
        [cell setNextButtonHidden:true];
        _MIsHiddenNextButton = true;

    }
    
    _MPageController.currentPage  = scrollView.contentOffset.x / ScreenWidth + 0.5;
}
@end
