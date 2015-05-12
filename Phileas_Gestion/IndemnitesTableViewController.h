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
#import "IndemniteK+DataModel.h"

@interface IndemnitesTableViewController : UITableViewController <MKMapViewDelegate>

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Variables =====
@property (strong, nonatomic) NSArray* resultat;

/**
 * @brief Une chaîne de caractère contenant le montant du frais.
 */
@property (strong, nonatomic) NSMutableString *montant;

/**
 * @brief L'indemnité kilomètrique du frais.
 */
@property (strong, nonatomic) IndemniteK* indemniteK;

/**
 * @brief Le barème automobile associé à ce frais.
 */
@property (strong, nonatomic) BaremeAuto* ba;

/**
 * @brief Un tableau contenant la liste des villes possibles répondant à la recherche pour celle de départ.
 */
@property (strong, nonatomic) NSMutableArray *depart;

/**
 * @brief Un tableau contenant la liste des villes possibles répondant à la recherche pour celle d'arrivée.
 */
@property (strong, nonatomic) NSMutableArray *arrivee;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UITableViewCell *departCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *arriveeCell;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextField;
@property (weak, nonatomic) IBOutlet UIButton *cvButton;
@property (weak, nonatomic) IBOutlet UISwitch *arSwitch;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;

// ===== Actions =====
- (IBAction)choisirPuissance:(id)sender;
- (IBAction)changementTypeTrajet:(id)sender;

@end
