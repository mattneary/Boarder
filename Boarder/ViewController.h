//
//  ViewController.h
//  Boarder
//
//  Created by Matt Neary on 6/9/14.
//  Copyright (c) 2014 lambdalabs. All rights reserved.
//

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
