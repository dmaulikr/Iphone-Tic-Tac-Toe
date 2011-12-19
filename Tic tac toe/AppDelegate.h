//
//  AppDelegate.h
//  Tic tac toe
//
//  Created by Stefan Mortensen on 2011-12-19.
//  Copyright Dynamic Jester 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
