//
//  ScrollViewAnimateAppDelegate.h
//  ScrollViewAnimate
//


#import <UIKit/UIKit.h>

@class ScrollViewAnimateViewController;

@interface ScrollViewAnimateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScrollViewAnimateViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScrollViewAnimateViewController *viewController;

@end

