
#import <UIKit/UIKit.h>

// This is the "application delegate". Every app has one. It is notified of
// events that concern the entire application.
//
// Examples of such events:
//   - the application has been loaded and is ready for use
//   - the user pressed the Home button and the app will now be suspended in
//     the background.
//
// For the Bull's Eye game you don't need to do anything here. When you created
// the project, Xcode made a default application delegate for you.
//
@interface BullsEyeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
