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
@interface FraisTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSArray* resultat;
@property (strong, nonatomic) NSMutableString* montant;
@property (strong, nonatomic) IndemniteK* indemniteK;

@property (strong, nonatomic) Frais* fraisChoisi;
@property (strong, nonatomic) User* utilisateur;

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (weak, nonatomic) IBOutlet UITextField *dateTexte;
@property (weak, nonatomic) IBOutlet UILabel *localisationLbl;
@property (weak, nonatomic) IBOutlet UIButton *typeF;
@property (weak, nonatomic) IBOutlet UIButton *justificatif;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;
@property (strong, nonatomic) IBOutlet UIButton *modifierIndemnite;

@property (weak, nonatomic) IBOutlet UITextView *comTextArea;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *saisirButton;

@property (strong, nonatomic) UIDatePicker *pickerViewDate;
@property (strong, nonatomic) NSDate *dateToChoose;

- (IBAction)changerType:(id)sender;
- (IBAction)choisirImage:(id)sender;
- (IBAction)saisir:(id)sender;
- (IBAction)envoyer:(id)sender;

@end


//Microphone à ajouter