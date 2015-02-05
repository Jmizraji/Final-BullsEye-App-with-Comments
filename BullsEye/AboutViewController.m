
#import "AboutViewController.h"

@implementation AboutViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  // Load the BullsEye.html file into the web view.
  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
  NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
  NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
  [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}

// This removes the status bar from the screen.
- (BOOL)prefersStatusBarHidden
{
  return YES;
}

// This action is called when the user taps the Close button. In response, we
// dismiss the About screen and automatically return to the main game screen
// (BullsEyeViewController).
- (IBAction)close
{
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
