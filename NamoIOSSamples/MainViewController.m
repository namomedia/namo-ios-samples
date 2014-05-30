// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "MainViewController.h"
#import "AdViewController.h"
#import "CollectionViewAdPlacerController.h"
#import "TableViewAdPlacerController.h"
#import "CustomStreamGalleryController.h"
#import "CustomStreamCollectionViewController.h"

@interface MainViewController ()
@property(nonatomic, strong) NSMutableArray *sampleItems;
@property(nonatomic, strong) NSMutableArray *customStreamItems;
@end


@interface ListItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) Class collectionLayoutClass;
@property(nonatomic, assign) Class controllerClass;
@end


@implementation ListItem

+ (ListItem *)listItemWithTitle:(NSString *)title
                controllerClass:(Class)controllerClass {
  return [ListItem listItemWithTitle:title
                     controllerClass:controllerClass
               collectionLayoutClass:nil];
}

+ (ListItem *)listItemWithTitle:(NSString *)title
                controllerClass:(Class)controllerClass
          collectionLayoutClass:(Class)collectionLayoutClass {
  ListItem *listItem = [[ListItem alloc] init];
  listItem.title = title;
  listItem.controllerClass = controllerClass;
  listItem.collectionLayoutClass = collectionLayoutClass;
  return listItem;
}

@end


@implementation MainViewController

#pragma mark - Initialization

- (instancetype)init {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.sampleItems = [[NSMutableArray alloc] init];
    self.customStreamItems = [[NSMutableArray alloc] init];
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 195, 26)];
  logoImageView.image = [UIImage imageNamed:@"namomedia-logo"];
  self.navigationItem.titleView = logoImageView;

  // General Samples
  [self.sampleItems addObject:[ListItem listItemWithTitle:@"TableView AdPlacer"
                                          controllerClass:TableViewAdPlacerController.class]];
  [self.sampleItems addObject:[ListItem listItemWithTitle:@"CollectionView AdPlacer"
                                          controllerClass:CollectionViewAdPlacerController.class
                                    collectionLayoutClass:UICollectionViewFlowLayout.class]];
  [self.sampleItems addObject:[ListItem listItemWithTitle:@"NAMOAdView"
                                          controllerClass:AdViewController.class]];

  // Custom Stream Samples
  [self.customStreamItems addObject:[ListItem listItemWithTitle:@"Custom Stream: Gallery"
                                                controllerClass:CustomStreamGalleryController.class]];
  [self.customStreamItems addObject:[ListItem listItemWithTitle:@"Custom Stream: CollectionView"
                                                controllerClass:CustomStreamCollectionViewController.class
                                          collectionLayoutClass:UICollectionViewFlowLayout.class]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController.navigationBar setBackgroundImage:nil
                                                forBarMetrics:UIBarMetricsDefault];

  // setBarTintColor is not supported pre iOS7
  if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
  }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return @"General Samples";
  } else {
    return @"Custom Stream Samples";
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self itemsForSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *const kCellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:kCellIdentifier];
  }
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  NSArray *items = [self itemsForSection:indexPath.section];
  ListItem *item = items[(NSUInteger)indexPath.row];

  cell.textLabel.text = item.title;

  return cell;
}

- (NSArray *)itemsForSection:(NSInteger)section {
  if (section == 0) {
    return self.sampleItems;
  } else {
    return self.customStreamItems;
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *items = [self itemsForSection:indexPath.section];
  ListItem *item = (ListItem *)items[(NSUInteger)indexPath.row];
  UIViewController *controller;
  if (item.collectionLayoutClass) {
    UICollectionViewLayout *layout = [[item.collectionLayoutClass alloc] init];
    controller = [[item.controllerClass alloc] initWithCollectionViewLayout:layout];
  } else {
    controller = [[item.controllerClass alloc] init];
  }

  controller.title = item.title;
  [self.navigationController pushViewController:controller animated:YES];
}

@end
