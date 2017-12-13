//
//  ProductDetailViewController.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 12. 4..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "NaviBaseViewController.h"

#import <SwaggerClient/SWGApiClient.h>
#import <SwaggerClient/SWGDefaultConfiguration.h>
#import <SwaggerClient/SWGProductApi.h>

#import "Global.h"
#import "AloImage.h"

#import "ProductDetailCell.h"
#import "ProductDetailCellHeader.h"
#import "ProductDetailCellFooter.h"

#import "EditorViewController.h"
#import "ProductWebViewController.h"

#define PRODUCT_DETAIL_CELL_IDENTIFIER @"ProductDetailCell"
#define PRODUCT_DETAIL_CELL_HEADER_IDENTIFIER @"ProductDetailCellHeader"
#define PRODUCT_DETAIL_CELL_FOOTER_IDENTIFIER @"ProductDetailCellFooter"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

CGFloat mainImageHeight;
NSMutableArray<ProductInfo*>* productInfos;

#pragma mark - Life Cycle
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

-(void)loadView {
    [super loadView];
    
    self.app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    
    productInfos = [[NSMutableArray alloc] init];
    
    // back button
    UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize aButtonSize = CGSizeMake(48*self.app.widthRatio, 48*self.app.heightRatio);
    aButton.frame = CGRectMake(10*self.app.widthRatio, (statusBarHeight+10)*self.app.heightRatio, aButtonSize.width, aButtonSize.height);
    [aButton setImage:[UIImage imageNamed:@"btnBackNor"] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    self.backButton = aButton;
}

#pragma mark - Network
-(void)processGetProductsApi {
    SWGProductApi *apiInstance = [[SWGProductApi alloc] init];
    [apiInstance getProductsWithProductId:self.productInfo._id
                                   offset:[NSNumber numberWithInt:0]
                                    limit:[NSNumber numberWithInt:5]
                        completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
                            if (output) {
                                NSLog(@"%@", output);
                                [productInfos removeAllObjects];
                                
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
                                    [productInfos addObject:aProductInfo];
                                }
//                                [self.collectionView reloadData];
                                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
                            }
                            if (error) {
                                NSLog(@"Error: %@", error);
                            }
                        }];
}

#pragma mark - Accessors
-(void)setProductInfo:(ProductInfo *)aProductInfo {
    _productInfo = aProductInfo;
    
    NSString *imageUrl = _productInfo.mainImageName;
    [AloImage imageWithUrl:imageUrl WithCompletionBlock:^(BOOL bSuccess, NSError *error, UIImage *anImage) {
        if (bSuccess) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                // calc mainImageHeight for HeaderCell
                mainImageHeight = [Global calcImageHeight:anImage];
                [self.view addSubview:self.collectionView];
                [self.view bringSubviewToFront:self.backButton];
            }];
        }
    }];
    
    [self processGetProductsApi];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(7*self.app.widthRatio, 7*self.app.heightRatio, 7*self.app.widthRatio, 7*self.app.heightRatio);
        layout.headerHeight = [ProductDetailCellHeader heightWithMainImageHeight:mainImageHeight];
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 6*self.app.widthRatio;
        layout.minimumInteritemSpacing = 6*self.app.heightRatio;
        layout.columnCount = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ProductDetailCell class]
            forCellWithReuseIdentifier:PRODUCT_DETAIL_CELL_IDENTIFIER];
        [_collectionView registerClass:[ProductDetailCellHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:PRODUCT_DETAIL_CELL_HEADER_IDENTIFIER];
        [_collectionView registerClass:[ProductDetailCellFooter class] 
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:PRODUCT_DETAIL_CELL_FOOTER_IDENTIFIER];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [productInfos count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailCell *cell = (ProductDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PRODUCT_DETAIL_CELL_IDENTIFIER
                                                forIndexPath:indexPath];
    //    cell.homeViewController = self;
    cell.productInfo = [productInfos objectAtIndex:indexPath.row];
    
    NSString *imageUrl = [productInfos objectAtIndex:indexPath.row].mobileThumbImageName;
    [AloImage imageWithUrl:imageUrl WithCompletionBlock:^(BOOL bSuccess, NSError *error, UIImage *anImage) {
        if (bSuccess) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                // set image
                cell.imageView.image = anImage;
            }];
        }
    }];
//    cell.imageView.image = [UIImage imageNamed:[productInfos objectAtIndex:indexPath.row].mobileThumbImageName];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    ProductDetailCellHeader *cellHeader = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        cellHeader = (ProductDetailCellHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:PRODUCT_DETAIL_CELL_HEADER_IDENTIFIER
                                                                                   forIndexPath:indexPath];
        cellHeader.productInfo = self.productInfo;
        cellHeader.productDetailViewController = self;
        return cellHeader;
    }
    else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:PRODUCT_DETAIL_CELL_FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailViewController *aNewViewPush = [[ProductDetailViewController alloc] initWithSize:self.app.screenRect.size];
    aNewViewPush.bShowToolbar = NO;
    aNewViewPush.productInfo = [productInfos objectAtIndex:indexPath.row];
    [self.app.baseViewController.aloNavi pushViewController:aNewViewPush animated:YES];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[productInfos objectAtIndex:indexPath.row].imageSize CGSizeValue];
}

#pragma mark - Methods
-(void)backButtonClicked:(id)sender {
    [self.app.baseViewController.aloNavi popViewCointroller:YES];
}

-(void)pushToEditorView {
    EditorViewController *aNewViewPush = [[EditorViewController alloc] initWithSize:self.app.screenRect.size];
    aNewViewPush.bShowToolbar = NO;
    aNewViewPush.productInfo = self.productInfo;
    [self.app.baseViewController.aloNavi pushViewController:aNewViewPush animated:YES];
}

-(void)pushToProductWebView {
    ProductWebViewController *aNewViewPush = [[ProductWebViewController alloc] initWithSize:self.app.screenRect.size];
    aNewViewPush.bShowToolbar = NO;
    aNewViewPush.urlForLoad = self.productInfo.swgProduct.productUrl; // @"http://www.google.com"; // self.productInfo.swgProduct.productUrl;
    [self.app.baseViewController.aloNavi pushViewController:aNewViewPush animated:YES];
}

@end
