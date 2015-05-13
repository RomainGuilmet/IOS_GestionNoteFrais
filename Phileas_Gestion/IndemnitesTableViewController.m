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
@synthesize ba;
@synthesize indemniteK;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // On initialise l'appDelegate et le context de l'application pour le coreData.
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    context = self.appDelegate.managedObjectContext;
    
    // Nous chargeons la liste des barèmes automobiles.
    [self chargementListeBaremes];
    
    // Nous allouons les variables strong qui seront passé par pointeur avec le prepareForSegue.
    depart = [[NSMutableArray alloc]init];
    arrivee = [[NSMutableArray alloc]init];
    
    [self.cvButton setTitle:@"Choisir un nombre de CV" forState:UIControlStateNormal];
    
    // Si l'indemnité à une ville de départ existante alors nous partons du principe qu'elle existe et nous remplissons les champs avec les valeurs de l'indemnité.
    if(indemniteK.villeDepart){
        if([indemniteK.allezRetour isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [self.arSwitch setOn:TRUE];
        }
        [self.cvButton setTitle:indemniteK.cylindree.cylindre forState:UIControlStateNormal];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        NSString *villeD = indemniteK.villeDepart;
        
        [geocoder
         geocodeAddressString:villeD
         completionHandler:^(NSArray *placemarks,
                             NSError *error) {
             
             if (error) {
                 NSLog(@"Geocode failed with error: %@", error);
                 return;
             }
             
             if (placemarks && placemarks.count > 0)
             {
                 MKPlacemark *placemark = placemarks[0];
                 
                 MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                 if([depart count]>0)
                 {
                     [depart removeObjectAtIndex:0];
                 }
                 [depart addObject:mapItem];
             }
         }];
        
        CLGeocoder *geocoder2 = [[CLGeocoder alloc] init];
        NSString *villeA = indemniteK.villeArrivee;
        [geocoder2
         geocodeAddressString:villeA
         completionHandler:^(NSArray *placemarks,
                             NSError *error) {
             
             if (error) {
                 NSLog(@"Geocode failed with error: %@", error);
                 return;
             }
             
             if (placemarks && placemarks.count > 0)
             {
                 MKPlacemark *placemark = placemarks[0];
                 
                 MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                 if([arrivee count]>0)
                 {
                     [arrivee removeObjectAtIndex:0];
                 }
                 [arrivee addObject:mapItem];
             }
         }];
    }
}

/**
 * @brief Cette fonction est appelée quand la vue apparaît.
 */
- (void)viewDidAppear:(BOOL)animated {
    // Si une ville de départ a été choisie nous l'affichons.
    if([depart count] == 1)
    {
        if(![((MKMapItem *)[depart objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.departCell.textLabel setText:((MKMapItem *)[depart objectAtIndex:0]).name];
        }
    }
    
    // Si une ville d'arrivée a été choisie nous l'affichons.
    if([arrivee count] == 1)
    {
        if(![((MKMapItem *)[arrivee objectAtIndex:0]).name isEqual:@"Unknown Location"])
        {
            [self.arriveeCell.textLabel setText:((MKMapItem *)[arrivee objectAtIndex:0]).name];
        }
    }
    
    // Si les villes de départ et d'arrivée ont été choisis nous calculons la distance.
    if([self.depart count] > 0 && [self.arrivee count] > 0)
    {
        [self calculDistance];
    }    
}

/**
 * @brief Cette fonction est appelée quand la vue va disparaître.
 */
-(void) viewWillDisappear:(BOOL)animated{
    if (ba) {
        NSNumber *ar = [NSNumber numberWithInt:0];
        if([self.arSwitch isOn])
        {
            ar= [NSNumber numberWithInt:1];
        }
        
        [indemniteK updateIndemniteK:((MKMapItem *)[depart objectAtIndex:0]).name villeArrivee:((MKMapItem *)[arrivee objectAtIndex:0]).name allezR:ar baremeAuto:ba andDistance:[NSNumber numberWithDouble:[self.distanceTextField.text doubleValue]]];
        
        NSError *erreur = nil;
        if(![context save:&erreur]){
            NSLog(@"Impossible de sauvegarder l'indemnite ! %@ %@", erreur, [erreur localizedDescription]);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
/**
 * @brief Cette fonction permet de changer la page active vers la page mapTableView au clic sur la ligne départ ou arrivée.
 * @brief Nous passons par pointeur au controller tableView la ville de départ si la ligne sélectionné est celle de départ pour qu'il la modifie.
 * @brief Nous passons par pointeur au controller tableView la ville d'arrivée si la ligne sélectionné est celle d'arrivée pour qu'il la modifie.
 */
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

#pragma mark - methods
/**
 * @brief Cette fonction permet de charger la liste des barèmes automobiles enregistrés dans le coreData.
 */
- (void)chargementListeBaremes
{
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"BaremeAuto"];
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"cylindre" ascending:YES]]];
    
    NSError *erreur = nil;
    self.resultat = [context executeFetchRequest:requete error:&erreur];
}

/**
 * @brief Cette fonction permet de calculer la distance entre deux emplacements géographiques.
 */
- (void) calculDistance
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = ((MKMapItem *)[self.depart objectAtIndex:0]);
    request.destination = ((MKMapItem *)[self.arrivee objectAtIndex:0]);
    request.transportType = MKDirectionsTransportTypeAutomobile;
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
            
            if(![self.cvButton.titleLabel.text isEqual:@"Choisir un nombre de CV"])
            {
                [self calculMontant];
            }
        }
    }];
}

/**
 * @brief Cette fonction permet de calculer le coût d'une indemnité kilométrique en fonction de la cylindrée et de la distance.
 */
- (void) calculMontant
{
    NSString* cylindre = self.cvButton.titleLabel.text;
    ba = [BaremeAuto selectBaremeAuto:cylindre andContext:context];
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
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.montant setString:[numberFormatter stringFromNumber:[NSNumber numberWithDouble:montant]]];
}

#pragma mark - actions
/**
 * @brief Cette fonction permet de lancer une alerte au clic sur le bouton choisirCylindree pour choisir le nombre de CV du véhicule.
 */
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

/**
 * @brief Cette fonction permet de recharger la vue au changement d'état du switch pour recalculer directement la disance et le coût de l'indemnité.
 */
- (IBAction)changementTypeTrajet:(id)sender {
    [self viewDidAppear:true];
}

#pragma mark - alertView delegates
/**
 * @brief Cette fonction sert à gérer les alertView.
 * @brief Cela permet de recharger la vue après avoir sélectionné une cylindrée.
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if(![[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Annuler"]){
            [self.cvButton setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            [self viewDidAppear:true];
        }
    }
}

#pragma mark - TextFieldDelegates
/**
 * @brief Cette fonction sert à cacher le clavier lorsque l'on clique en dehors d'un textField.
 */
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.montantTextField resignFirstResponder];
    [self.distanceTextField resignFirstResponder];
    [self.view endEditing:YES];
}

@end
