//
//  ViewController.h
//  BlurtScroll
//
//  Created by Mike Place on 3/13/13.
//  Copyright (c) 2013 Super Top Secret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

typedef enum {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@end
