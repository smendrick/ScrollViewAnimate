//
//  ScrollViewAnimateViewController.h
//  ScrollViewAnimate
//
//  Created by Richard Hall on 7/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewAnimateViewController : UIViewController <UIScrollViewDelegate> {
	
	UIImageView *animationView;
	UILabel		*frameLabel;
	
	int			imageIndex;
	int			currentOffset;

}
@property (nonatomic, retain) UIImageView *animationView;
@property (nonatomic, retain) UILabel		*frameLabel;
@property (assign, readwrite) int			imageIndex;
@property (assign, readwrite) int			currentOffset;

@end

