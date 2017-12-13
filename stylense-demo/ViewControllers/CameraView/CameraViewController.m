//
//  CameraViewController.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 24..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "CameraViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "NaviBaseViewController.h"

#import <SwaggerClient/SWGApiClient.h>
#import <SwaggerClient/SWGDefaultConfiguration.h>
#import <SwaggerClient/SWGObjectApi.h>
#import <SwaggerClient/SWGProductApi.h>

#import "Global.h"

#import "EditorViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

NSMutableArray<ProductInfo*>* editorResultInfos;
AVCaptureSession* session;
AVCaptureStillImageOutput* stillImageOutput;

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
}

-(void)loadView {
    UIView* aView = [[UIView alloc] initWithFrame:self.frame];
    self.view = aView;
    self.view.backgroundColor = [UIColor whiteColor];
    
    aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    aView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:aView];
    self.cameraCaptureArea = aView;
    
    UIImageView *anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    anImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:anImageView];
    self.previewImageView = anImageView;
    self.previewImageView.hidden = YES;
    
    aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width, self.view.frame.size.width, self.view.frame.size.height - self.view.frame.size.width)];
    [self.view addSubview:aView];
    
    UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize aButtonSize = CGSizeMake(84*self.app.widthRatio, 84*self.app.heightRatio);
    aButton.frame = CGRectMake(aView.frame.size.width/2 - aButtonSize.width/2, aView.frame.size.height/2 - aButtonSize.height/2, aButtonSize.width, aButtonSize.height);
    [aButton setImage:[UIImage imageNamed:@"btnCameraShotNor"] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:aButton];
    
    editorResultInfos = [[NSMutableArray alloc] init];
    
    aView = nil;
    aButton = nil;
    anImageView = nil;
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [self.view layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.cameraCaptureArea.frame;
    [previewLayer setFrame:frame];
    [rootLayer addSublayer:previewLayer];
//    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
    
    [session startRunning];
}

-(void)takePhoto:(UIButton *)sender {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            //UIImage *anImage = [self fixOrientationOfImage:[UIImage imageWithData:imageData]];
            //UIImageWriteToSavedPhotosAlbum(anImage, nil, nil, nil);
            //imageData = UIImageJPEGRepresentation(anImage, 1.0);
            
//            UIImage *anImage = [UIImage imageNamed:@"sample01.jpg"];
            
//            self.previewImageView.hidden = NO;
//            [self.view bringSubviewToFront:self.previewImageView];
//            self.previewImageView.image = [Global resizeAndAdjustCropImage:[UIImage imageWithData:imageData] ToRect:CGRectMake(0, 0, 1000*self.app.widthRatio, 1000*self.app.heightRatio)];
            
            [session stopRunning];
            
            UIImage *anImage = [Global resizeAndAdjustCropImage:[UIImage imageWithData:imageData] ToRect:CGRectMake(0, 0, 300, 300)];
            imageData = UIImageJPEGRepresentation(anImage, 1.0);
            
            NSString *filePath = [self documentsPathForFileName:@"captured.jpg"];
            [imageData writeToFile:filePath atomically:YES];
            
            NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
            
            [self.app.baseViewController startIndicator];
            SWGObjectApi *apiInstance = [[SWGObjectApi alloc] init];
            [apiInstance getObjectsByImageFileWithFile:url
                                     completionHandler:^(SWGGetObjectsResponse* output, NSError* error) {
//                                         self.previewImageView.hidden = YES;
//                                         [self.view bringSubviewToFront:self.cameraCaptureArea];
                                         
                                         
                                         [editorResultInfos removeAllObjects];
                                         
                                         if (output) {
                                             NSLog(@"%@", output);
                                             NSLog(@"");
                                             
                                             SWGBoxObject *highestScoredObject = output.data.boxes[0];
                                             CGRect aBoxRect = [self getBoxRectWithBoxObject:highestScoredObject.box];
                                             
                                             ProductInfo *aProductInfo = nil;
                                             for(SWGProduct *aSWGProduct in highestScoredObject.products) {
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
                                                 
                                                 [editorResultInfos addObject:aProductInfo];
                                             }

                                             [session startRunning];
                                             [self pushViewController:[Global resizeAndAdjustCropImage:[UIImage imageWithData:imageData] ToRect:CGRectMake(0, 0, 1000, 1000)] boxRect:aBoxRect];
                                         }
                                         if (error) {
                                             [self.app.baseViewController stopIndicator];
                                             [session startRunning];
                                             NSLog(@"Error: %@", error);
                                             NSLog(@"");
                                         }
                                     }];
            
            
//            [self pushViewController:[Global resizeAndAdjustCropImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]] ToRect:CGRectMake(0, 0, 1000*self.app.widthRatio, 1000*self.app.heightRatio)]];
            
//            [self pushViewController:[Global resizeAndAdjustCropImage:[UIImage imageWithData:imageData] ToRect:CGRectMake(0, 0, 1000*self.app.widthRatio, 1000*self.app.heightRatio)]
//                             boxRect:CGRectMake(100, 100, 100, 100)];
        }
    }];
}

#pragma mark - Methods
-(void)pushViewController:(UIImage *)anImage boxRect:(CGRect)aBoxRect {
    EditorViewController *aNewViewPush = [[EditorViewController alloc] initWithSize:self.app.screenRect.size];
    aNewViewPush.bShowToolbar = NO;
    [self.app.baseViewController.aloNavi pushViewController:aNewViewPush animated:YES];
    aNewViewPush.productImage = anImage;
    aNewViewPush.boxRect = aBoxRect;
    aNewViewPush.editorResultInfos = editorResultInfos;
}

-(CGRect)getBoxRectWithBoxObject:(SWGBox*)aBox {
    CGFloat imageRatio = self.app.screenRect.size.width / 300;
    
    CGFloat originX = [aBox.left floatValue] * imageRatio;
    CGFloat originY = [aBox.top floatValue] * imageRatio;
    CGFloat width = ([aBox.right floatValue] - originX) * imageRatio;
    CGFloat height = ([aBox.bottom floatValue] - originY) * imageRatio;
    
    return CGRectMake(originX, originY, width, height);
}

- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

- (UIImage *)fixOrientationOfImage:(UIImage *)image {
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
