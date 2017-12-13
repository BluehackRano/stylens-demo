//
//  BaseViewController.m
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 21..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "BaseViewController.h"

#import "AppDelegate.h"
#import "DataManager.h"
#import "NaviBaseViewController.h"

#import "BHTabbar.h"
#import "HomeViewController.h"
#import "CameraViewController.h"

static const int STATUS_BAR_HEIGHT = 20;

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)loadView {
    
    [super loadView];
    
    self.app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.toolbar.backgroundColor = [UIColor clearColor];
    
    self.dataManager = [[DataManager alloc] init];
    
    // tabbar
    CGFloat tabbarHeight = [BHTabbar height];
    _tabbar = [[BHTabbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - tabbarHeight, self.view.frame.size.width, tabbarHeight)];
    [self.view addSubview:self.tabbar];
    
    // homeViewController
    _homeViewController = [[HomeViewController alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT*self.app.heightRatio, self.view.frame.size.width, self.view.frame.size.height - self.tabbar.frame.size.height - STATUS_BAR_HEIGHT*self.app.heightRatio)];
    [self.view addSubview:self.homeViewController.view];
    [self.homeViewController processFeedApi];
    self.curViewController = self.homeViewController;
}

#pragma mark View Management
-(void)showHomeView {
    if (self.curViewController == self.homeViewController) {
        return;
    }
    
    if (self.homeViewController == nil) {
        self.homeViewController = [[HomeViewController alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT*self.app.heightRatio, self.view.frame.size.width, self.view.frame.size.height - self.tabbar.frame.size.height - STATUS_BAR_HEIGHT*self.app.heightRatio)];
        [self.view addSubview:self.homeViewController.view];
    }
    
    self.curViewController.view.hidden  = YES;
    self.homeViewController.view.hidden = NO;
    [self.homeViewController processFeedApi];
    self.curViewController = self.homeViewController;
}

-(void)showCameraView {
    if (self.curViewController == self.cameraViewController) {
        return;
    }
    
    if (self.cameraViewController == nil) {
        self.cameraViewController = [[CameraViewController alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT*self.app.heightRatio, self.view.frame.size.width, self.view.frame.size.height - self.tabbar.frame.size.height - STATUS_BAR_HEIGHT*self.app.heightRatio)];
        [self.view addSubview:self.cameraViewController.view];
    }
    
    self.curViewController.view.hidden  = YES;
    self.cameraViewController.view.hidden = NO;
    //    [self.homeViewController processItemCheckData];
    self.curViewController = self.cameraViewController;
}

#pragma mark - Indicator
-(void)startIndicator {
    [self.naviBaseViewController startIndicator];
}

-(void)stopIndicator {
    [self.naviBaseViewController stopIndicator];
}

@end
