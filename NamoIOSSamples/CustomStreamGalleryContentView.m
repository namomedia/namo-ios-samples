// Copyright (c) 2014 Namo Media. All rights reserved.

#import "CustomStreamGalleryContentView.h"

@interface CustomStreamGalleryContentView ()

@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation CustomStreamGalleryContentView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.text = @"<< Swipe >>";
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.textLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

@end
