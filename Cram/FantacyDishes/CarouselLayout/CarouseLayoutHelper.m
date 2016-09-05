//
//  CarouseLayoutHelper.m
//  MogoRenter
//
//  Created by Harly on 16/6/2.
//  Copyright © 2016年 MogoRoom. All rights reserved.
//
#import "CarouseLayoutHelper.h"
#import "PBDCarouselCollectionViewLayout.h"

@implementation CarouseLayoutHelper

+ (void)resetLayoutItemSize:(CGSize)size andItemSpace:(CGFloat)itemSpace inCollectionView:(id)collectionView
{
    UICollectionView* view = collectionView;
    PBDCarouselCollectionViewLayout *layout = (PBDCarouselCollectionViewLayout*)view.collectionViewLayout;
    layout.itemSize = size;
    layout.interItemSpace = itemSpace;
}
@end
