// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import <Namo/Namo.h>

#import "AdViewController.h"

@implementation AdViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NAMOAdView *adView = [[NAMOAdView alloc]
      initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.bounds) - 20, 80)];
  [adView registerAdFormat:NAMOAdFormatSample1.class];
  [self.view addSubview:adView];

  [adView requestAdWithTargeting:nil];
}

@end
