#import "ViewController.h"

@implementation ViewController
@synthesize locationManager;
@synthesize alertLabel;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Delay calculation until we have two data points.
    if( time == nil || previousLocation == nil ) {
        time = [NSDate date];
        [alertLabel setText:@"Loading..."];
        [alertLabel setHidden:NO];
        previousLocation = newLocation;
        previousMph = 0;
        return;
    }
    if( [[NSDate date] timeIntervalSinceDate:time] <= 5 ) {
        return;
    }
    
    // Calculate deltas and speed.
    float secondsPassed = [[NSDate date] timeIntervalSinceDate:time];
    float metersTraveled = [newLocation distanceFromLocation:previousLocation];
    float speedMph = (metersTraveled/1624) / (secondsPassed/60/60);
    time = [NSDate date];
    previousLocation = newLocation;
    
    // Display a message within the app.
    NSString *status = [NSString stringWithFormat:
                        @"You've gone %0.0f meters in %0.0f seconds.\n"
                        "You're going %0.0f mph.", metersTraveled, secondsPassed, speedMph];
    [alertLabel setText:status];
    [alertLabel setHidden:NO];
    
    // Send an update as a local notification if speed changed.
    if( speedMph != previousMph ) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = [NSString stringWithFormat:@"%0.0f mph", speedMph];
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        if( oldNotification != nil ) {
            [[UIApplication sharedApplication] cancelLocalNotification:oldNotification];
        }
        oldNotification = notification;
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Unable to start location manager. Error:%@", [error description]);
    [alertLabel setHidden:NO];
}
- (IBAction)startTracking:(id)sender {
    [locationManager startUpdatingLocation];
}
- (IBAction)stopTracking:(id)sender {
    [locationManager stopUpdatingLocation];
    [alertLabel setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
