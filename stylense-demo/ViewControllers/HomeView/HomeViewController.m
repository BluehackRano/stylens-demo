//
//  HomeViewController.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 21..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "HomeViewController.h"

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "NaviBaseViewController.h"

#import <SwaggerClient/SWGApiClient.h>
#import <SwaggerClient/SWGDefaultConfiguration.h>
#import <SwaggerClient/SWGFeedApi.h>
#import <SwaggerClient/SWGProductApi.h>

#import <SwaggerClient/SWGObjectApi.h>

#import "Global.h"
#import "AloImage.h"

#import "HomeCell.h"
#import "HomeCellHeader.h"
#import "HomeCellFooter.h"

#import "ProductDetailViewController.h"

#define HOME_CELL_IDENTIFIER @"HomeCell"
#define HOME_CELL_HEADER_IDENTIFIER @"HomeCellHeader"
#define HOME_CELL_FOOTER_IDENTIFIER @"HomeCellFooter"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(id)initWithFrame:(CGRect)aFrame {
    
    self = [super init];
    if(self) {
        self.app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.frame = aFrame;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

-(void)loadView {
    UIView* aView = [[UIView alloc] initWithFrame:self.frame];
    self.view = aView;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [self updateLayoutForOrientation:toInterfaceOrientation];
//}
//
//- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
//    CHTCollectionViewWaterfallLayout *layout =
//    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
//    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
//}

#pragma mark - Network
- (void)processFeedApi {
    [self.app.baseViewController startIndicator];
    
    SWGFeedApi *apiInstance = [[SWGFeedApi alloc] init];
    [apiInstance getFeedsWithOffset:[NSNumber numberWithInt:0]
                              limit:[NSNumber numberWithInt:100]
                  completionHandler: ^(SWGGetFeedResponse* output, NSError* error) {
                      [self.app.baseViewController.dataManager.productInfos removeAllObjects];
                      [self.app.baseViewController stopIndicator];
                      
                      if (output) {
                          NSLog(@"%@", output);
                          
                          ProductInfo *aProductInfo = nil;
                          for(SWGProduct *aSWGProduct in output.data) {
                              aProductInfo = [[ProductInfo alloc] init];
                              aProductInfo.swgProduct = aSWGProduct;
                              aProductInfo._id = aSWGProduct._id;
                              aProductInfo.mainImageName = aSWGProduct.mainImage;
                              aProductInfo.mobileThumbImageName = aSWGProduct.mainImageMobileThumb;
                              aProductInfo.titleLabel = aSWGProduct.name;
                              aProductInfo.priceLabel = [NSString stringWithFormat:@"%@ %@",
                                                         [Global getStringNumberFormat:aSWGProduct.price],
                                                         [Global getCurrencyUnit:aSWGProduct.currencyUnit]];
 
                              UIImage *anImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aSWGProduct.mainImageMobileThumb]]];
                              aProductInfo.imageSize = [NSValue valueWithCGSize:CGSizeMake(anImage.size.width, anImage.size.height)];
                              
                              [self.app.baseViewController.dataManager.productInfos addObject:aProductInfo];
                          }
                          
//                          [self.collectionView reloadData];
                          [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
                      }
                      if (error) {
                          NSLog(@"Error: %@", error);
                      }
                  }];
}

-(void)processGetProductsApiWithProductId:(NSString*)productId atIndex:(int)index {
    [self.app.baseViewController startIndicator];
    
    SWGProductApi *apiInstance = [[SWGProductApi alloc] init];
    [apiInstance getProductsWithProductId:productId
                                   offset:[NSNumber numberWithInt:0]
                                    limit:[NSNumber numberWithInt:1]
                        completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
                            [self.app.baseViewController stopIndicator];
                            
                            if (output) {
                                NSLog(@"%@", output);
                                
                                if ([output.data count] <= 0) {
                                    return;
                                }
                                
//                                __block NSInteger theFirstIndexForInsertingCells = [self.app.baseViewController.dataManager.productInfos count];
                                
                                SWGProduct *aSWGProduct = nil;
                                ProductInfo *aProductInfo = nil;
                                for (NSInteger i=([output.data count] - 1); i>=0; i--) {
                                    aSWGProduct = [output.data objectAtIndex:i];
                                    aProductInfo = [[ProductInfo alloc] init];
                                    aProductInfo.swgProduct = aSWGProduct;
                                    aProductInfo._id = aSWGProduct._id;
                                    aProductInfo.mainImageName = aSWGProduct.mainImage;
                                    aProductInfo.mobileThumbImageName = aSWGProduct.mainImageMobileThumb;
                                    aProductInfo.titleLabel = aSWGProduct.name;
                                    aProductInfo.priceLabel = [NSString stringWithFormat:@"%@ %@",
                                                               [Global getStringNumberFormat:aSWGProduct.price],
                                                               [Global getCurrencyUnit:aSWGProduct.currencyUnit]];
                                    
                                    UIImage *anImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aSWGProduct.mainImageMobileThumb]]];
                                    aProductInfo.imageSize = [NSValue valueWithCGSize:CGSizeMake(anImage.size.width, anImage.size.height)];
                                    
                                    [self.app.baseViewController.dataManager.productInfos insertObject:aProductInfo atIndex:index+1];
                                }
                                
                                
//                                for(SWGProduct *aSWGProduct in output.data) {
//                                    aProductInfo = [[ProductInfo alloc] init];
//                                    aProductInfo.swgProduct = aSWGProduct;
//                                    aProductInfo._id = aSWGProduct._id;
//                                    aProductInfo.mainImageName = aSWGProduct.mainImage;
//                                    aProductInfo.mobileThumbImageName = aSWGProduct.mainImageMobileThumb;
//                                    aProductInfo.titleLabel = aSWGProduct.name;
//                                    aProductInfo.priceLabel = [NSString stringWithFormat:@"%@ %@",
//                                                               [Global getStringNumberFormat:aSWGProduct.price],
//                                                               [Global getCurrencyUnit:aSWGProduct.currencyUnit]];
//                                    
//                                    UIImage *anImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aSWGProduct.mainImageMobileThumb]]];
//                                    aProductInfo.imageSize = [NSValue valueWithCGSize:CGSizeMake(anImage.size.width, anImage.size.height)];
//                                    
//                                    [self.app.baseViewController.dataManager.productInfos insertObject:aProductInfo atIndex:index+1];
//                                }
                                
                                
//                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                    NSMutableArray* indexes = [[NSMutableArray alloc] init];
//                                    for( NSInteger aRowIndex = 0; aRowIndex < [self.app.baseViewController.dataManager.productInfos count] - theFirstIndexForInsertingCells; aRowIndex++ ) {
//                                        [indexes insertObject:[NSIndexPath indexPathForRow:(theFirstIndexForInsertingCells + aRowIndex) inSection:0] atIndex:index+1];
//                                        [indexes addObject:[NSIndexPath indexPathForRow:(theFirstIndexForInsertingCells + aRowIndex) inSection:0]];
                                        
//                                    }
//                                    [self.collectionView insertItemsAtIndexPaths:indexes];
//                                }];
                                
                                [self.collectionView reloadData];
                                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
                            }
                            if (error) {
                                NSLog(@"Error: %@", error);
                            }
                        }];

}

#pragma mark - Accessors
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(7*self.app.widthRatio, 7*self.app.heightRatio, 7*self.app.widthRatio, 7*self.app.heightRatio);
        layout.headerHeight = 5*self.app.heightRatio;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 6*self.app.widthRatio;
        layout.minimumInteritemSpacing = 6*self.app.heightRatio;
        layout.columnCount = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HomeCell class]
            forCellWithReuseIdentifier:HOME_CELL_IDENTIFIER];
        [_collectionView registerClass:[HomeCellHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HOME_CELL_HEADER_IDENTIFIER];
        [_collectionView registerClass:[HomeCellFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:HOME_CELL_FOOTER_IDENTIFIER];
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.app.baseViewController.dataManager.productInfos count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HOME_CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];

    cell.homeViewController = self;
    cell.productInfo = [self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row];
    // cell.imageView.image = [UIImage imageNamed:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row].imageName];
    
    NSString *imageUrl = [self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row].mobileThumbImageName;
    [AloImage imageWithUrl:imageUrl WithCompletionBlock:^(BOOL bSuccess, NSError *error, UIImage *anImage) {
        if (bSuccess) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                // set image
                cell.imageView.image = anImage;
            }];
        }
    }];
//    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row].imageName]]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HOME_CELL_HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HOME_CELL_FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self pushViewController];
    
    NSLog(@"%@", [self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row]._id);
    
    [self pushToProductDetailWithProductInfo:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row]];
    
//    SWGProductApi *apiInstance = [[SWGProductApi alloc] init];
//    [apiInstance getProductByIdWithProductId:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row]._id
//                  completionHandler: ^(SWGGetProductResponse* output, NSError* error) {
//                      if (output) {
//                          NSLog(@"%@", output);
//                      }
//                      if (error) {
//                          NSLog(@"Error: %@", error);
//                      }
//                  }];
    
//    SWGProductApi *apiInstance = [[SWGProductApi alloc] init];
//    [apiInstance getProductsWithProductId:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row]._id
//                    offset:[NSNumber numberWithInt:0]
//                    limit:[NSNumber numberWithInt:5]
//                           completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
//                               if (output) {
//                                   NSLog(@"%@", output);
//                               }
//                               if (error) {
//                                   NSLog(@"Error: %@", error);
//                               }
//                           }];
    
//    SWGObjectApi *apiInstance = [[SWGObjectApi alloc] init];
//    [apiInstance getObjectsByProductIdWithProductId:[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row]._id
//                        completionHandler: ^(SWGGetObjectsResponse* output, NSError* error) {
//                            if (output) {
//                                NSLog(@"%@", output);
//                            }
//                            if (error) {
//                                NSLog(@"Error: %@", error);
//                            }
//                        }];
    
    
    
//    FeedInfo *aFeedInfo = nil;
//    for(int i = 0; i < 5; i++ ) {
//        aFeedInfo = [[FeedInfo alloc] init];
//        aFeedInfo._id = @"aaaa_xx";
//        aFeedInfo.title = @"ITEM_XXX";
//        aFeedInfo.imageName = @"cat5.jpg";
//        aFeedInfo.price = [NSNumber numberWithInt:(10000+i)];
//        
//        UIImage *anImage = [UIImage imageNamed:aFeedInfo.imageName];
//        aFeedInfo.imageSize = [NSValue valueWithCGSize:CGSizeMake(anImage.size.width, anImage.size.height)];
//        
//        [self.app.baseViewController.dataManager.feedInfos insertObject:aFeedInfo atIndex:indexPath.row+1];
//    }
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
}

#pragma mark - Methods
-(void)pushToProductDetailWithProductInfo:(ProductInfo*)aProductInfo {
    ProductDetailViewController *aNewViewPush = [[ProductDetailViewController alloc] initWithSize:self.app.screenRect.size];
    aNewViewPush.bShowToolbar = NO;
    aNewViewPush.productInfo = aProductInfo;
    [self.app.baseViewController.aloNavi pushViewController:aNewViewPush animated:YES];
}

-(void)sameProductButtonClicked:(ProductInfo*)aParamProductInfo {
    if (!aParamProductInfo) {
        return;
    }
    
    NSMutableArray<ProductInfo*>* productInfosCopied = [self.app.baseViewController.dataManager.productInfos copy];
    for (int i=0; i<[productInfosCopied count]; i++) {
        if ([aParamProductInfo._id isEqualToString:[productInfosCopied objectAtIndex:i]._id]) {
            [self processGetProductsApiWithProductId:aParamProductInfo._id atIndex:i];
            return;
        }
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.app.baseViewController.dataManager.productInfos objectAtIndex:indexPath.row].imageSize CGSizeValue];
}

@end
