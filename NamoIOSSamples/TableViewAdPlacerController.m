// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import <Namo/Namo.h>

#import "TableViewAdPlacerController.h"
#import "TableViewContentCell.h"
#import "TableViewAdCell.h"

@interface TableViewAdPlacerController ()

@property(nonatomic, strong) NAMOTableViewAdPlacer *adPlacer;

@end

@implementation TableViewAdPlacerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self.tableView registerClass:[TableViewContentCell class] forCellReuseIdentifier:@"TVC"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // set table view separators to a single line with no inset
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
  if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    self.tableView.separatorInset = UIEdgeInsetsZero;
  }

  // Namo setup
  self.adPlacer = [NAMOTableViewAdPlacer placerForTableView:self.tableView viewController:self];
  [self.adPlacer registerAdFormat:TableViewAdCell.class];

  [self.adPlacer requestAdsWithTargeting:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewContentCell
      *cell = (TableViewContentCell *)[self.tableView namo_dequeueReusableCellWithIdentifier:
      @"TVC"];

  if (!cell) {
    cell = [[TableViewContentCell alloc]
        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TVC"];
  }

  return cell;
}

@end
