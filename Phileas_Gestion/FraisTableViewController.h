//
//  FraisTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IndemnitesTableViewController.h"
#import "Type+DataModel.h"
#import "Frais+DataModel.h"
#import "IndemniteK+DataModel.h"
#import "BaremeAuto+DataModel.h"
#import "User+DataModel.h"
#import "Draft.h"
#import "Expense-def.h"

@interface FraisTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

// ===== AppDelegate et context pour le CoreData =====
@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

// ===== Variables =====

@property (strong, nonatomic) CLLocationManager* locationManager;

/**
 * @brief Un tableau qui va contenir la liste des type de frais.
 */
@property (strong, nonatomic) NSArray* listeType;

/**
 * @brief Une chaîne de caractère contenant le montant du frais.
 */
@property (strong, nonatomic) NSMutableString* montant;

/**
 * @brief L'indemnité kilomètrique du frais si elle existe.
 */
@property (strong, nonatomic) IndemniteK* indemniteK;

/**
 * @brief Le frais qui va être créé ou modifié.
 */
@property (strong, nonatomic) Frais* fraisChoisi;

/**
 * @brief L'utilisateur connecté.
 */
@property (strong, nonatomic) User* utilisateur;

/**
 * @brief Un tableau qui va contenir la liste des expense-def récupérée depuis la BD.
 */
@property (strong, nonatomic) NSArray* listeExpenseDef;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UITextField *dateTexte;
@property (weak, nonatomic) IBOutlet UILabel *localisationLbl;
@property (weak, nonatomic) IBOutlet UIButton *typeF;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;
@property (strong, nonatomic) IBOutlet UIButton *modifierIndemnite;
@property (weak, nonatomic) IBOutlet UITextView *comTextArea;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *saisirButton;

@property (strong, nonatomic) UIDatePicker *pickerViewDate;
@property (strong, nonatomic) NSDate *dateToChoose;

// ===== Actions =====
- (IBAction)changerType:(id)sender;
- (IBAction)choisirImage:(id)sender;
- (IBAction)saisir:(id)sender;
- (IBAction)envoyer:(id)sender;

@end


//Microphone à ajouter