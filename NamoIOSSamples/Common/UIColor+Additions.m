// Copyright (c) 2014 Namo Media. All rights reserved.

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)randomColor {
  CGFloat hue = (arc4random() % 256 / 256.0);
  CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
  CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;

  return [UIColor colorWithHue:hue
                    saturation:saturation
                    brightness:brightness
                         alpha:1];
}

@end
