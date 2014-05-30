// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import <UIKit/UIKit.h>

@interface CustomStreamCollectionContentCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *titleLabel;

+ (NSString *)reuseIdentifier;

@end
