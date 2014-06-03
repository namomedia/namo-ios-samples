// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import <Namo/Namo.h>

#import "CustomStreamCollectionViewController.h"

#import "CustomStreamCollectionAdCell.h"
#import "CustomStreamCollectionContentCell.h"

@interface CustomStreamCollectionViewController ()

@property(nonatomic, strong) NAMOCustomStreamAdPlacer *adPlacer;

@end

@implementation CustomStreamCollectionViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:CustomStreamCollectionContentCell.class
          forCellWithReuseIdentifier:[CustomStreamCollectionContentCell reuseIdentifier]];

  // need to register ad cell as well
  [self.collectionView registerClass:CustomStreamCollectionAdCell.class
          forCellWithReuseIdentifier:[CustomStreamCollectionAdCell formatIdentifier]];

  self.adPlacer = [NAMOCustomStreamAdPlacer placerForViewController:self];
  [self.adPlacer registerAdFormat:CustomStreamCollectionAdCell.class];
  self.adPlacer.delegate = self;

  [self.adPlacer requestAdsWithTargeting:nil];
}

#pragma mark - NAMOAdPlacerDelegate data source

- (void)didFailWithError:(NSError *)error {
  NSLog(@"NAMOCustomStreamAdPlacer didFailWithError:%@", error);
}

- (void)didReceiveAds {
  [self insertNewAds];
}

- (void)didReceiveMoreAds {
  [self insertMoreAds];
}

- (void)insertNewAds {
  UICollectionView *collectionView = self.collectionView;

  [collectionView performBatchUpdates:^() {
    // Clear the existing ad cells since the set has been refreshed.
    NSArray *adPositions = [self.adPlacer adPositions]; //TODO: What to use here?
    if (adPositions.count > 0) {
      NSMutableArray *adIndexPaths = [NSMutableArray arrayWithCapacity:adPositions.count];
      for (NSNumber *position in adPositions) {
        [adIndexPaths addObject:[NSIndexPath indexPathForRow:[position integerValue]
                                                   inSection:0]];
      }
      [self.collectionView deleteItemsAtIndexPaths:adIndexPaths];
    }

    [self insertAdsLogic:collectionView];
  }                        completion:nil];
}

- (void)insertMoreAds {
  UICollectionView *collectionView = self.collectionView;

  // Dispatched here because we can't insert items and modify the data source in a single iOS event loop.
  [collectionView performBatchUpdates:^() {
    [self insertAdsLogic:collectionView];
  }                        completion:nil];
}

- (void)insertAdsLogic:(UICollectionView *)collectionView {
  // Generate index paths for positions that have not yet been inserted.
  NSUInteger numItems = 30;
  NSMutableArray *indexPathsToInsert = [NSMutableArray array];
  NSArray *positionsToInsert = [self.adPlacer positionsToInsertAdsForItemCount:numItems];
  for (NSNumber *position in positionsToInsert) {
    // Dequeue immediately so that the adjusted count is modified.
    [self.adPlacer dequeueAdForPosition:[position unsignedIntegerValue]];
    [indexPathsToInsert addObject:[NSIndexPath indexPathForItem:[position unsignedIntegerValue]
                                                      inSection:0]];
  }

  // Insert them.
  if (indexPathsToInsert.count > 0) {
    [collectionView insertItemsAtIndexPaths:indexPathsToInsert];
  }
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  // return 30 + the number of ads inserted
  int i = [self.adPlacer adjustedNumberOfItems:30];
  return i;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  // Should there be an ad at this position?
  NSUInteger row = (NSUInteger)indexPath.row;
  BOOL isAd = [self.adPlacer isAdAtPosition:row];
  NAMOAd *ad;
  if (isAd) {
    ad = [self.adPlacer dequeueAdForPosition:row];
  }

  if (ad) {
    // if an ad goes here, dequeue the ad cell and fill it with the NAMOAd
    CustomStreamCollectionAdCell *adCell = (CustomStreamCollectionAdCell *)
        [collectionView dequeueReusableCellWithReuseIdentifier:[CustomStreamCollectionAdCell formatIdentifier]
                                                  forIndexPath:indexPath];
    [ad attachReusableView:adCell];
    return adCell;
  } else {
    // if a content cell goes here, get its adjusted position and display
    CustomStreamCollectionContentCell *cell = (CustomStreamCollectionContentCell *)
        [collectionView dequeueReusableCellWithReuseIdentifier:[CustomStreamCollectionContentCell reuseIdentifier]
                                                  forIndexPath:indexPath];

    NSInteger originalRow = [self.adPlacer originalPosition:row];
    cell.titleLabel.text = [NSString stringWithFormat:@"Row %d", originalRow];
    return cell;
  }
}

#pragma mark - Collection View delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger position = (NSUInteger)indexPath.row;

  BOOL isAd = [self.adPlacer isAdAtPosition:position];
  NAMOAd *ad;
  if (isAd) {
    ad = [self.adPlacer dequeueAdForPosition:position];
  }

  if (isAd && ad) {
    return [CustomStreamCollectionAdCell sizeWithMaxWidth:320.0f];
  }

  return CGSizeMake(100.0f, 60.0f);
}

@end
