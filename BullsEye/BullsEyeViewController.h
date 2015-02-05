
#import <UIKit/UIKit.h>

// This is the main screen for the game. It has a view that shows a slider,
// several buttons and labels. It also handles all the game logic.
//
// This controller conforms to the UIAlertViewDelegate protocol so it can
// be notified when the player taps the OK button in the alert view that you
// show at the end of a round.
//
@interface BullsEyeViewController : UIViewController <UIAlertViewDelegate>

// These outlet properties are connected to the user interface elements (the 
// slider, labels and buttons) that you are interested in. By making outlets
// for them you can refer to these controls from the code.
@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *targetLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

// These action methods let you know when the player is interacting with the
// slider or the buttons.
- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)startOver;

@end
