// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "CustomStreamGalleryAdView.h"

@interface CustomStreamGalleryAdView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *advertiserIconImageView;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UILabel *advertiserNameLabel;

@end

@implementation CustomStreamGalleryAdView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor orangeColor];

    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];

    self.advertiserIconImageView = [[UIImageView alloc] init];
    [self addSubview:self.advertiserIconImageView];

    self.advertiserNameLabel = [[UILabel alloc] init];
    self.advertiserNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:self.advertiserNameLabel];

    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];

    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 4;
    self.textLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.textLabel];
  }

  return self;
}

- (void)layoutSubviews {
  // TODO: Make this flexible for different screen sizes
  self.imageView.frame = CGRectMake(20, 20, 280, 200);
  self.advertiserIconImageView.frame = CGRectMake(20, 200 + 20 + 5, 20, 20);
  self.advertiserNameLabel.frame = CGRectMake(40 + 5, 200 + 20 + 5, 300 - 45, 20);
  self.textLabel.frame = CGRectMake(20, 200 + 20 + 5 + 20 + 5, 280, 60);
}

+ (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth {
  // TODO: never called, just for cells. remove once the method isn't required anymore
  return CGSizeZero;
}

+ (NSString *)formatIdentifier {
  return NSStringFromClass([self class]);
}

- (void)setAdData:(NAMOAdData *)adData {
  [adData loadImageIntoImageView:self.imageView];
  [adData loadAdvertiserIconIntoImageView:self.advertiserIconImageView];
  [adData loadAdvertiserNameIntoLabel:self.advertiserNameLabel];
  [adData loadTextIntoLabel:self.textLabel];
}

@end
