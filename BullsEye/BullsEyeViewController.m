
#import "BullsEyeViewController.h"

@implementation BullsEyeViewController
{
  // This is the current value of the slider. Whenever the player drags the
  // slider, you update this variable with the new value.
  int _currentValue;

  // At the start of each round, you calculate a random value and store it
  // in this variable. This is the value that the player has to try to set
  // on the slider.
  int _targetValue;

  // This variable keeps track of the player's score.
  int _score;

  // This variable stores how many rounds the player has played so far.
  int _round;
}

// This method is called while the app is starting up. At some point the main 
// view controller will be created (that is us). The view controller will load
// its view from the storyboard and connect the properties to the view's user
// interface elements. When that is done, it sends the viewDidLoad message to
// give you a chance to do some initialization of our own before the app starts
// in earnest. You use this opportunity to set up the game and the labels and
// customize the graphics for the slider.
- (void)viewDidLoad
{
  [super viewDidLoad];

  [self startNewGame];
  [self updateLabels];

  UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
  [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];

  UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
  [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];

  UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
  [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];

  UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
  [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
}

// This is a full-screen app so you don't want to show the status bar on top.
- (BOOL)prefersStatusBarHidden
{
  return YES;
}

// This method starts a new round.
- (void)startNewRound
{
  // Increment the round number.
  _round += 1;

  // Calculate the new target value. You use the arc4random_uniform()
  // function to get a random number between 0 and 99 (inclusive), and then
  // add 1 to it to get a value between 1 and 100.
  _targetValue = 1 + arc4random_uniform(100);

  // Reset the slider to its center position.
  _currentValue = 50;
  self.slider.value = _currentValue;
}

// This method starts a new game. It resets the score and the round number to
// 0, and then calls the startNewRound method to begin the first round.
- (void)startNewGame
{
  _score = 0;
  _round = 0;
  [self startNewRound];
}

// This method puts the target value, the player's total score, and the current
// round number on the labels. You placed this into a method of its own, so you
// don't have to duplicate this code all the time.
- (void)updateLabels
{
  self.targetLabel.text = [NSString stringWithFormat:@"%d", _targetValue];
  self.scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
  self.roundLabel.text = [NSString stringWithFormat:@"%d", _round];
}

// This method is called when the player taps the "Hit Me!" button. It will
// show the results for this round in an alert view popup.
- (IBAction)showAlert
{
  // Calculate how far off the slider's value is from the target value.
  // You use the abs() function to always make this a positive number.
  int difference = abs(_targetValue - _currentValue);

  // Calculate how many points the player has scored. The player gets more
  // points the closer he is to the target. The maximum score is 100 points.
  int points = 100 - difference;

  // It's fun to change the title of the alert popup depending on how well
  // the player did. In addition, you give the player 100 bonus points if he
  // has a perfect score and 50 bonus points if he was very close.
  NSString *title;
  if (difference == 0) {
    title = @"Perfect!";
    points += 100;
  } else if (difference < 5) {
    title = @"You almost had it!";
    if (difference == 1) {
      points += 50;
    }
  } else if (difference < 10) {
    title = @"Pretty good!";
  } else {
    title = @"Not even close...";
  }

  // Add the points for this round to the total score.
  _score += points;

  // The message part of the alert view shows the number of points the player
  // has scored in this round. You use NSString's stringWithFormat method to
  // create this text string. The format specifier %d will be replaced by the
  // value of the points variable.
  NSString *message = [NSString stringWithFormat:@"You scored %d points", points];

  // Now that you have the title and the message, you can finally create the
  // UIAlertView object and show it. You set its delegate parameter to "self",
  // which means that the alertView:didDismissWithButtonIndex: method will be
  // called after the player pressed the OK button to close the alert.
  UIAlertView *alertView = [[UIAlertView alloc]
    initWithTitle:title
    message:message
    delegate:self
    cancelButtonTitle:@"OK"
    otherButtonTitles:nil];

  // This will show the alert view on the screen.
  [alertView show];
}

// This method is called when the player taps the OK button in the alert view.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  // Start a new round and show it on the screen.
  [self startNewRound];
  [self updateLabels];
}

// This method is called when the player moves the slider.
- (IBAction)sliderMoved:(UISlider *)slider
{
  // The position of the slider is a value between 1 and 100, and may contain
  // digits after the decimal point. You round the value to a whole number and
  // store it in the currentValue variable.
  _currentValue = lroundf(slider.value);
  
  // If you want to see the current value as you're moving the slider, then
  // uncomment the NSLog() line below (remove the //) and keep an eye on the
  // output console when you run the app.

  //NSLog(@"currentValue %d", _currentValue);
}

// This method is called when the player taps the "Start Over" button.
- (IBAction)startOver
{
  // Create a Core Animation transition. This will crossfade from what is
  // currently on the screen to the changes that you're making below.
  CATransition *transition = [CATransition animation];
  transition.type = kCATransitionFade;
  transition.duration = 1;
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

  // This is pretty simple. You do the same thing that you did in viewDidLoad,
  // which is: start a new game (which also starts the first round) and update
  // the labels to show these changes on the screen.
  [self startNewGame];
  [self updateLabels];

  // This makes the animation go.
  [self.view.layer addAnimation:transition forKey:nil];
}

@end
