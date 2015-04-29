//
//  IndemnitesTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 27/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapTableViewController.h"
#import "AppDelegate.h"
#import "BaremeAuto+DataModel.h"

@interface IndemnitesTableViewController : UITableViewController <MKMapViewDelegate>

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSArray* resultat;
@property (strong, nonatomic) NSMutableString *montant;

@property (weak, nonatomic) IBOutlet UITableViewCell *departCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *arriveeCell;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextField;
@property (weak, nonatomic) IBOutlet UIButton *cvButton;
@property (weak, nonatomic) IBOutlet UISwitch *arSwitch;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;
@property (weak, nonatomic) IBOutlet MKMapView *carte;

@property (strong, nonatomic) NSMutableArray *depart;
@property (strong, nonatomic) NSMutableArray *arrivee;
@property (strong, nonatomic) MKPolyline *line;

- (IBAction)choisirPuissance:(id)sender;
- (IBAction)changementTypeTrajet:(id)sender;

@end


//Enregistrer les indemnités dans un autre type de frais du coreData ???