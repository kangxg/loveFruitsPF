//
//  SDPhotoBrowser.h
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDButton, SDPhotoBrowser;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) int currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign)BOOL  hasShowedFistView;
@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

- (void)show;
@end

@interface SDSinglePhotoBrowser : UIView<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, weak)UIImage * MImage;
@property (nonatomic, assign)BOOL    MisCanScale;
- (void)show;
@end
