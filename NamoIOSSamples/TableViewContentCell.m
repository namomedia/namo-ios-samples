// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "TableViewContentCell.h"

@implementation TableViewContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.text = @"Some Content";
  }
  return self;
}

@end
