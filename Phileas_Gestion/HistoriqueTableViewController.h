//
//  HistoriqueTableViewController.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Frais+DataModel.h"
#import "FraisTableViewController.h"
#import "User+DataModel.h"

@interface HistoriqueTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIActionSheetDelegate>

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Propriétés permettant de géré l'affichage dynamique du tableau =====
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selectedFactions;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editerBouton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *annulerBouton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *supprimerBouton;

// ===== Actions =====
- (IBAction)editer:(id)sender;
- (IBAction)annuler:(id)sender;
- (IBAction)supprimer:(id)sender;

// ===== Methods =====
/**
 * @brief Cette fonction permet de charger la liste des brouillons enregistrés dans le coreData.
 */
- (void) chargerListeFrais;

@end