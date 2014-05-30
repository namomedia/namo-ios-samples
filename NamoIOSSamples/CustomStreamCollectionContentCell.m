// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "CustomStreamCollectionContentCell.h"

@implementation CustomStreamCollectionContentCell

+ (NSString *)reuseIdentifier {
  return @"CustomStreamCollectionContentCell";
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:self.titleLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  UIView *contentView = self.contentView;
  self.titleLabel.frame = CGRectMake(8.0f, 8.0f,
      contentView.bounds.size.width - 16.0f,
      contentView.bounds.size.height - 16.0f);
}

@end
