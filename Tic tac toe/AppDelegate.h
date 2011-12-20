//
//  AppDelegate.h
//  Tic tac toe
//
//  Created by Stefan Mortensen on 2011-12-19.
//  Creative Commons Share Alike 2.5 Generic
//  http://creativecommons.org/licenses/by-sa/2.5/
//


#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
