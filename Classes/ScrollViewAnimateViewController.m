//
//  ScrollViewAnimateViewController.m
//  ScrollViewAnimate
//


#import "ScrollViewAnimateViewController.h"

#define kSequenceSize 169.0
#define kAnimationSpeed 5.0
#define kImageWidth 159.0
#define kImageHeight 135
#define kImageSpacing 10.0
#define kPanelTotal 3


@implementation ScrollViewAnimateViewController

@synthesize currentOffset, imageIndex, animationView, frameLabel;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (NSArray *)getImages {
	NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
	
	NSString *imageFileName;
	
	for (int i=0; i < kSequenceSize; i++) {
		
		imageFileName = [NSString stringWithFormat:@"im-%i.png",i];
		[arr addObject:[UIImage imageNamed:imageFileName]];
	}
	return (NSArray *)arr;
}


- (void)viewDidLoad {  
	
	// Initialize Image Index
	self.imageIndex = 0;
	
	// Scroll View
	// Set up 3 panels, each the same width of the entire animation sequence.
	// If it scroll off the center panel, move it back to using the scrollview decel delegate method
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 140, 320, 480)];
	scrollView.contentSize = CGSizeMake(kPanelTotal * kImageSpacing * kSequenceSize , 135);
	scrollView.delegate = self;
	scrollView.scrollEnabled = YES;
	scrollView.bounces = NO;
	scrollView.pagingEnabled = NO;
	scrollView.contentOffset = CGPointMake(kImageSpacing * kSequenceSize , 0);
	scrollView.showsHorizontalScrollIndicator = YES;
	currentOffset = scrollView.contentOffset.x;
	
	// Display imaged in Scroll View 
	//	NSArray *contentArray = [[NSArray alloc] initWithArray:[self getImages]];
	//	
	//    int i = 0;  
	//    for (UIImage *img in contentArray) {  
	//        UIImageView *imageView = [[UIImageView alloc] init];  
	//        imageView.image = img;  
	//        imageView.backgroundColor = [UIColor blackColor];  
	//        CGRect imageFrame = CGRectMake(i, 0, kImageWidth, 135);  
	//        imageView.frame = imageFrame;  
	//        [scrollView addSubview:(UIView *)imageView];  
	//        i += kImageWidth;  
	//        [imageView release];  
	//    }  
	
	[self.view addSubview:scrollView];
	[scrollView release];
	
	// Animated Image
	
	UIImageView *animView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"im-%i.png",imageIndex]]];
	animView.frame = CGRectMake(80, 140, kImageWidth, 135);
	[self.view addSubview:animView];
	self.animationView = animView;
	[animView release];
	
	// Frame Label
	
	UILabel *fLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 140+kImageHeight, kImageWidth, 30)];
	[self.view addSubview:fLabel];
	self.frameLabel = fLabel;
	[fLabel release];
	
} 

- (void)updateAnimationView {
	
	// Keep the image index wthin the bounds of the array
	if (imageIndex <= 0) imageIndex = kSequenceSize-1;
	if (imageIndex >= kSequenceSize) imageIndex = 0;
	
	// Change image in imageview
	NSString *imageFileName = [NSString stringWithFormat:@"im-%i.png",imageIndex];
	animationView.image = [UIImage imageNamed:imageFileName];
	
	// Update Frame Number label
	frameLabel.text = [NSString stringWithFormat:@"Frame[%i]",imageIndex ];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	// Increment imageindex based if the the scrollview scrolls more than a set distance
	
	if (scrollView.contentOffset.x < currentOffset - kAnimationSpeed ) {
		imageIndex++;
		currentOffset = scrollView.contentOffset.x;
		[self updateAnimationView];
	} else if (scrollView.contentOffset.x > currentOffset + kAnimationSpeed) {
		imageIndex--;
		currentOffset = scrollView.contentOffset.x;
		[self updateAnimationView];
	}
	
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	int panelIndex = scrollView.contentOffset.x/(kImageSpacing * kSequenceSize);
	
	// Move ScrollView content to make it continuos
	
	
	if (panelIndex == 0) {
		scrollView.contentOffset = CGPointMake(currentOffset + kImageSpacing * kSequenceSize, 0);
		currentOffset = scrollView.contentOffset.x;
		NSLog(@"Content Moved - Panel Index = %i",scrollView.contentOffset.x/(kImageSpacing * kSequenceSize));
		
	} else if (panelIndex == 2){
		scrollView.contentOffset = CGPointMake(currentOffset - kImageSpacing * kSequenceSize, 0);
		currentOffset = scrollView.contentOffset.x;
		NSLog(@"Content Moved - Panel Index = %i",scrollView.contentOffset.x/(kImageSpacing * kSequenceSize));
		
	}
	
}





/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[frameLabel release];
	[animationView release];
    [super dealloc];
}

@end
