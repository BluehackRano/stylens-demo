//
//  ViewController.h
//  stylense-demo
//
//  Created by 김대섭 on 2017. 11. 21..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NaviBaseViewController.h"

@class AppDelegate;

@interface ViewController : UIViewController

@property (nonatomic, strong) AppDelegate* app;

@property (nonatomic, strong) NaviBaseViewController* naviBaseViewController;

//@property (nonatomic, strong) AloNavi* naviController;
//@property (nonatomic, strong) DataManager* dataManager;

@end

