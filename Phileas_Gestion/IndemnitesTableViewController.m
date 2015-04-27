//
//  IndemniteTableViewController.m
//  Phileas_Gestion
//
//  Created by Florent on 24/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "IndemnitesTableViewController.h"

@implementation IndemnitesTableViewController

@synthesize depart;
@synthesize arrivee;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    depart = [[NSMutableArray alloc]init];
    arrivee = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    if([depart count] > 0)
    {
        if(![((MKMapItem *)[depart objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.departCell.textLabel setText:((MKMapItem *)[depart objectAtIndex:0]).name];
        }
    }
    
    if([arrivee count] > 0)
    {
        if(![((MKMapItem *)[arrivee objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.arriveeCell.textLabel setText:((MKMapItem *)[arrivee objectAtIndex:0]).name];
        }
    }
    
    if([self.depart count] > 0 && [self.arrivee count] > 0)
    {
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        
        // source and destination are the relevant MKMapItem's
        request.source = ((MKMapItem *)[self.depart objectAtIndex:0]);
        request.destination = ((MKMapItem *)[self.arrivee objectAtIndex:0]);
        
        // Specify the transportation type
        request.transportType = MKDirectionsTransportTypeAutomobile;
        
        // If you're open to getting more than one route, requestsAlternateRoutes = YES; else requestsAlternateRoutes = NO;
        request.requestsAlternateRoutes = YES;
        
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            
            if (!error) {
                MKDirectionsResponse *directionsResponse = response;
                MKRoute *route = directionsResponse.routes[0];
                CLLocationDistance distance = route.distance;
                distance = distance/1000;
                NSString *distanceString = [NSString stringWithFormat:@"%f", distance];
                [self.distanceTextField setText:distanceString];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([[segue identifier] isEqualToString:@"depart"]){
         MapTableViewController *controllerDestination = segue.destinationViewController;
         [controllerDestination setLieu:depart];
     }
     else if([[segue identifier] isEqualToString:@"arrivee"]){
         MapTableViewController *controllerDestination = segue.destinationViewController;
         [controllerDestination setLieu:arrivee];
     }
 }
 

@end
