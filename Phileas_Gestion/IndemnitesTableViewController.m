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
@synthesize context;

- (void)viewDidLoad {
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    [self chargementListeBaremes];
    
    depart = [[NSMutableArray alloc]init];
    arrivee = [[NSMutableArray alloc]init];
    [self.cvButton setTitle:@"Choisir un nombre de CV" forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    if([depart count] == 1)
    {
        if(![((MKMapItem *)[depart objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.departCell.textLabel setText:((MKMapItem *)[depart objectAtIndex:0]).name];
        }
    }
    
    if([arrivee count] == 1)
    {
        if(![((MKMapItem *)[arrivee objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.arriveeCell.textLabel setText:((MKMapItem *)[arrivee objectAtIndex:0]).name];
        }
    }
    
    if([self.depart count] > 0 && [self.arrivee count] > 0)
    {
        [self calculDistance];
        
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

/*
#pragma mark - Utility Methods
- (void)plotRouteOnMap:(MKRoute *)route
{
    if(self.line) {
        [self.carte removeOverlay:self.line];
    }
    self.line = route.polyline;
    [self.carte addOverlay:self.line];
    
}

#pragma mark - MKMapViewDelegate methods
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 4.0;
    return  renderer;
}
 */

#pragma mark - methods
- (void)chargementListeBaremes
{
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"BaremeAuto"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"cylindre" ascending:YES]]];
    
    NSError *erreur = nil;
    self.resultat = [context executeFetchRequest:requete error:&erreur];
    if([self.resultat count] == 0)
        NSLog(@"vide");
}

- (void) calculDistance
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
            if([self.arSwitch isOn])
            {
                distance = distance * 2;
            }
            NSString *distanceString = [NSString stringWithFormat:@"%.0f km", distance];
            [self.distanceTextField setText:distanceString];
            /*
             [self.carte setDelegate:self];
             [self plotRouteOnMap:route];*/
            
            if(![self.cvButton.titleLabel.text isEqual:@"Choisir un nombre de CV"])
            {
                [self calculMontant];
            }
        }
    }];
}

- (void) calculMontant
{
    NSString* cylindre = self.cvButton.titleLabel.text;
    BaremeAuto* ba = [BaremeAuto selectBaremeAuto:cylindre andContext:context];
    double distance = [self.distanceTextField.text doubleValue];
    double montant;
    if(distance <=5000)
    {
        montant = distance*[ba.basse doubleValue];
    }
    else if (distance>5000 && distance<=20000)
    {
        montant = distance*[ba.moyenne doubleValue]+[ba.fixe doubleValue];;
    }
    else{
        montant = distance*[ba.haute doubleValue];
    }
    
    NSString *montantTexte = [NSString stringWithFormat:@"%.2f euros", montant];
    [self.montantTextField setText:montantTexte];
    [self.montant setString:[NSString stringWithFormat:@"%.2f", montant]];
}

#pragma mark - actions
- (IBAction)choisirPuissance:(id)sender {
    UIAlertView *alerteType = [[UIAlertView alloc] initWithTitle:@"Sélectionner une puissance administrative" message:@"" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:nil];
    
    
    for(int i=0; i<[self.resultat count]; i++)
    {
        BaremeAuto *baremeTemp = [self.resultat objectAtIndex:i];
        [alerteType addButtonWithTitle:[NSString stringWithFormat:@"%@", baremeTemp.cylindre]];
    }
    
    [alerteType setTag:1];
    
    [alerteType show];
}

- (IBAction)changementTypeTrajet:(id)sender {
    [self viewWillAppear:true];
}

#pragma mark - alertView delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if(![[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Annuler"]){
            [self.cvButton setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            [self viewWillAppear:true];
        }
    }
}

@end
