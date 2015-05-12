//
//  NotificationTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Sheet.h"
#import "NotificationCellule.h"

@interface NotificationTableViewController : UITableViewController

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Variables =====
/**
 * @brief L'utilisateur connecté.
 */
@property (strong, nonatomic) User* utilisateur;

/**
 * @brief Un tableau contenant la liste des frais de l'utilisateur récupérée depuis l'application Web.
 */
@property (strong, nonatomic) NSArray* listeFrais;

// ===== Actions =====
- (void) loadFrais;
@end
