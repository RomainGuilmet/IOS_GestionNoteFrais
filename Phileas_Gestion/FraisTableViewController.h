//
//  FraisTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Type+DataModel.h"

@interface FraisTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (strong, nonatomic) NSArray* resultat;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *localisationLbl;
@property (weak, nonatomic) IBOutlet UILabel *JustificatifLbl;
@property (weak, nonatomic) IBOutlet UIButton *typeF;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;
@property (weak, nonatomic) IBOutlet UITextField *comTextField;

- (IBAction)ChangerType:(id)sender;
- (IBAction)Envoyer:(id)sender;
- (IBAction)Saisir:(id)sender;
@end