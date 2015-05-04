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

User* utilisateur;

@interface ConnexionViewController : UIViewController

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UITextField *pseudoTextField;
@property (weak, nonatomic) IBOutlet UITextField *mdpTextField;

- (IBAction)Connexion:(id)sender;

@end
