//
//  ViewController.m
//  MyRouting
//
//  Created by Financialbrain on 2016/7/13.
//  Copyright © 2016年 DarisCode. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goButtonPressed:(id)sender
{
    
    CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
    
    NSString *addressString = _targetAddressTextField.text; // Address Here
    //住址查經緯度
    [geocoder1 geocodeAddressString:addressString
    completionHandler:^(NSArray *placemarks, NSError *error)
    {
                     
        if (error)
        {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
                     
                     
        CLPlacemark *targetPlacemark = placemarks[0];
                         
        NSLog(
              @"Lat/Lon: %f, %f",
              targetPlacemark.location.coordinate.latitude,
              targetPlacemark.location.coordinate.longitude
              );
        
        //決定地標
        MKPlacemark * targetPlace = [[MKPlacemark alloc]initWithPlacemark:targetPlacemark];
        MKMapItem * targetMapItem = [[MKMapItem alloc]initWithPlacemark:targetPlace];
        
        //選項
        NSDictionary * options =@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
        
        [targetMapItem openInMapsWithLaunchOptions:options];
        
        
        
                     
                     
    }];
    
    //用經緯度反查地址
    //限制:短時間只能查50個
     CLGeocoder *geocoder2 = [CLGeocoder new];
    
    CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:24.243003 longitude:120.723436];
    
    [geocoder2 reverseGeocodeLocation:targetLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        
        if (error)
        {
            NSLog(@"ReverseGeocoder error: %@", error);
            return;
        }
        
        CLPlacemark * placemark = placemarks.firstObject;
        NSDictionary * address = placemark.addressDictionary;
        NSLog(@"Address: %@",address[@"FormattedAddressLines"][0]);
        NSLog(@"%@,%@,%@,%@,%@,%@",
              placemark.country,
              placemark.locality,
              placemark.administrativeArea,
              placemark.thoroughfare,
              placemark.subThoroughfare,
              placemark.postalCode
              );
       
    }];
    
    
        

    
}
     

- (void) launchMapsWithPlacemark:(CLPlacemark*)targetPlacemark {
    
    // Decide Source MapItem
    CLLocationCoordinate2D sourceCoordinate = CLLocationCoordinate2DMake(24.686525, 121.815312);
    MKPlacemark *sourcePlace = [[MKPlacemark alloc] initWithCoordinate:sourceCoordinate
                                                     addressDictionary:nil];
    
    MKMapItem *sourceMapItem = [[MKMapItem alloc]initWithPlacemark:sourcePlace];
    
    // Decide Target MapItem
    MKPlacemark *targetPlace = [[MKPlacemark alloc]
                                initWithPlacemark:targetPlacemark];
    
    MKMapItem *targetMapItem = [[MKMapItem alloc]initWithPlacemark:targetPlace];
    
    
    // Directions Options
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving
                              };
    
    [MKMapItem openMapsWithItems:@[sourceMapItem,targetMapItem]
                   launchOptions:options];
}


@end
