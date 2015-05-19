//
//  ConnexionViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User+DataModel.h"

@interface ConnexionViewController : UIViewController

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Variables =====
/**
 * @brief L'utilisateur connecté.
 */ 
@property (strong, nonatomic) User* utilisateur;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UITextField *pseudoTextField;
@property (weak, nonatomic) IBOutlet UITextField *mdpTextField;

// ===== Actions =====
/**
 * @brief Cette fonction sert à se connecter à l'application.
 * @brief Pour cela, il faut être connecté à internet et au moyen de la fonction user de l'api nous allons vérifier que les identifiants fourni correspondent à ceux d'un utilisateur enregistré sur l'application web.
 */
- (IBAction)Connexion:(id)sender;

// ===== Methods =====
/**
 * @brief Cette fonction permet de sauvegarder l'utilisateur qui vient de se connecter dans le coreData afin qu'il reste connecté.
 */
- (void)SauverUtilisateur;

/**
 * @brief Cette fonction sert à afficher une alerte si les identifiants de l'utilisateur ne sont pas les bons.
 */
- (void)alerteIdentifiants;

@end
