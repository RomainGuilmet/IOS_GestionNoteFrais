//
//  OptionsViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User+DataModel.h"

@interface OptionsViewController : UIViewController

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Variables =====
/**
 * @brief L'utilisateur connecté.
 */
@property (strong, nonatomic) User* utilisateur;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UILabel *pseudoLbl;

// ===== Actions =====
- (IBAction)Deconnexion:(id)sender;

@end
