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
#import "Message.h"
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

/**
 * @brief Un tableau contenant la liste des messages de l'utilisateur récupérée depuis l'application Web.
 */
@property (strong, nonatomic) NSArray* listeMessages;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

// ===== Methods =====
/**
 * @brief Cette fonction sert à charger tous les frais disponible sur l'application web.
 * @brief Elle utilise la class sheet et la fonction sheet de l'api.
 */
- (void) loadFrais;

/**
 * @brief Cette fonction sert à charger tous les messages récents récupérée depuis l'application web.
 * @brief Elle utilise la class message et la fonction message de l'api.
 */
- (void) loadMessages;

@end
