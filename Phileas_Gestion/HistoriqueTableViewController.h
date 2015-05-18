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

@interface HistoriqueTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Propriétés permettant de géré l'affichage dynamique du tableau =====
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selectedFactions;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end