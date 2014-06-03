// Copyright (c) 2014 Namo Media Inc. All rights reserved.

#import "CollectionViewAdPlacerController.h"
#import "CollectionViewAdPlacerAdCell.h"
#import "CollectionViewAdPlacerContentCell.h"

@interface CollectionViewAdPlacerController ()

@property(nonatomic, strong) NAMOCollectionViewAdPlacer *adPlacer;

@end

@implementation CollectionViewAdPlacerController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:CollectionViewAdPlacerContentCell.class
          forCellWithReuseIdentifier:[CollectionViewAdPlacerContentCell reuseIdentifier]];

  self.adPlacer = [NAMOCollectionViewAdPlacer placerForCollectionView:self.collectionView
                                                       viewController:self];
  [self.adPlacer registerAdFormat:CollectionViewAdPlacerAdCell.class];

  [self.adPlacer requestAdsWithTargeting:nil];
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CollectionViewAdPlacerContentCell *cell = (CollectionViewAdPlacerContentCell *)[collectionView
      namo_dequeueReusableCellWithReuseIdentifier:[CollectionViewAdPlacerContentCell reuseIdentifier]
                                     forIndexPath:indexPath];

  cell.titleLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
  return cell;
}

#pragma mark - Collection View delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(100.0f, 60.0f);
}
@end
