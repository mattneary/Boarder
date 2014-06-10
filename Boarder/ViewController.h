#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    IBOutlet UITextView  *alertLabel;
    NSDate *time;
    UILocalNotification *oldNotification;
    CLLocation *previousLocation;
    float previousMph;
}
@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic, retain) IBOutlet UITextView  *alertLabel;
- (IBAction)startTracking:(id)sender;
@end
