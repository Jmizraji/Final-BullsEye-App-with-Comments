
#import <UIKit/UIKit.h>

// This is the About screen. It shows the gameplay instructions in a web view
// and has a Close button that closes the screen and returns the player to the
// main game screen.
@interface AboutViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;

- (IBAction)close;

@end
