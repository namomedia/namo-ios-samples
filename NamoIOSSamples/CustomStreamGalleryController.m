// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "UIColor+Additions.h"

#import "CustomStreamGalleryController.h"
#import "CustomStreamGalleryAdView.h"
#import "CustomStreamGalleryContentView.h"

@interface CustomStreamGalleryController ()<UIPageViewControllerDataSource>
@property(nonatomic, strong) NAMOCustomStreamAdPlacer *customStreamAdPlacer;
@property(nonatomic, strong) NSArray *positions;
@end

@implementation CustomStreamGalleryController

- (instancetype)init {
  self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                options:nil];
  if (self) {
    [self setViewControllers:@[[self viewControllerForPageAtIndex:0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    self.dataSource = self;
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.wantsFullScreenLayout = NO;
  if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }

  self.customStreamAdPlacer = [NAMOCustomStreamAdPlacer placerForViewController:self];
  [self.customStreamAdPlacer registerAdFormat:[CustomStreamGalleryAdView class]];
  [self.customStreamAdPlacer setDelegate:self];
  [self.customStreamAdPlacer requestAdsWithTargeting:nil];
}

- (void)didReceiveAds {
  self.positions = [self.customStreamAdPlacer positionsToInsertAdsForItemCount:100];
}

- (void)didFailWithError:(NSError *)error {
  // Nothing to do.
}

- (UIViewController *)viewControllerForPageAtIndex:(NSInteger)index {
  UIViewController *viewController = [UIViewController new];

  if ([self.positions containsObject:@(index)]) {
    // show an ad
    NAMOAd *ad = [self.customStreamAdPlacer dequeueAdForPosition:(NSUInteger)index];
    UIView *adView = [ad createViewWithFrame:[self.view bounds]];
    [viewController setView:adView];
  } else {
    // show content
    CustomStreamGalleryContentView *contentView = [[CustomStreamGalleryContentView alloc] init];
    [contentView setBackgroundColor:[UIColor randomColor]];
    [viewController setView:contentView];
  }

  // Set tag to keep track of the view controller's position (the data source makes use of this)
  [[viewController view] setTag:index];

  return viewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
  NSInteger currentViewControllerIndex = [[viewController view] tag];
  return [self viewControllerForPageAtIndex:(currentViewControllerIndex - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
  NSInteger currentViewControllerIndex = [[viewController view] tag];
  return [self viewControllerForPageAtIndex:(currentViewControllerIndex + 1)];
}

@end
