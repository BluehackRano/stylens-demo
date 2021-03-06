//
//  HomeCell.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 22..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "HomeCell.h"

#import "AppDelegate.h"

#import "HomeViewController.h"

@implementation HomeCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        self.app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        [self.contentView addSubview:self.imageView];
        
        // title bg view
        UIView* aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, 30*self.app.heightRatio)];
        aView.backgroundColor = [UIColor blackColor];
        aView.alpha = 0.4;
        [self.imageView addSubview:aView];
        
        CGFloat labelMargin = 9*self.app.widthRatio;
        
        // titleLabel
        UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin, 0, aView.frame.size.width, 30*self.app.heightRatio)];
        aLabel.textAlignment = NSTextAlignmentLeft;
        aLabel.font = [UIFont fontWithName:cMainFontBoldName size:10*self.app.widthRatio];
        aLabel.adjustsFontSizeToFitWidth = YES;
        aLabel.textColor = [UIColor whiteColor];
        [self.imageView addSubview:aLabel];
        self.titleLabel = aLabel;
        
        // priceLabel
        aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aView.frame.size.width - labelMargin, 30*self.app.heightRatio)];
        aLabel.textAlignment = NSTextAlignmentRight;
        aLabel.font = [UIFont fontWithName:cMainFontBoldName size:10*self.app.widthRatio];
        aLabel.adjustsFontSizeToFitWidth = YES;
        aLabel.textColor = [UIColor whiteColor];
        [self.imageView addSubview:aLabel];
        self.priceLabel = aLabel;
        
        // sameProductButton
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setImage:[UIImage imageNamed:@"btnSameProductNor"] forState:UIControlStateNormal];
        [aButton addTarget:self action:@selector(sameProductButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        CGSize aButtonSize = CGSizeMake(32*self.app.widthRatio, 32*self.app.heightRatio);
        aButton.frame = CGRectMake(0, 0, aButtonSize.width, aButtonSize.height);
        self.sameProductButton = aButton;
        [self.contentView addSubview:self.sameProductButton];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect aRect = self.sameProductButton.frame;
    aRect.origin.x = self.imageView.frame.size.width - 10*self.app.widthRatio - aRect.size.width;
    aRect.origin.y = self.imageView.frame.size.height - 9*self.app.widthRatio - aRect.size.height;
    self.sameProductButton.frame = aRect;
}

-(void)setProductInfo:(ProductInfo *)aProductInfo {
    _productInfo = aProductInfo;
    
    self.titleLabel.text = _productInfo.titleLabel;
    self.priceLabel.text = _productInfo.priceLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 8.0;
        _imageView.backgroundColor = [UIColor lightGrayColor];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

-(void)sameProductButtonClicked {
    [self.homeViewController sameProductButtonClicked:self.productInfo];
}


@end
