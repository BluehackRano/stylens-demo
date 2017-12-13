//
//  EditorCell.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 28..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "EditorCell.h"

#import "AppDelegate.h"

@implementation EditorCell

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
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
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

@end
