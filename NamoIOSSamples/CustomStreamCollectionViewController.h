// Copyright (c) 2014 Namo Media Inc. All rights reserved.
//
// Example of using a NAMOCustomStreamAdPlacer in a collection view.

#import <Namo/Namo.h>
#import <UIKit/UIKit.h>

@interface CustomStreamCollectionViewController : UICollectionViewController<
    UICollectionViewDataSource, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout, NAMOAdPlacerDelegate>

@end
