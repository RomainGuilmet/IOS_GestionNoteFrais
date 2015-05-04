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

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) User* utilisateur;

@property (weak, nonatomic) IBOutlet UILabel *pseudoLbl;

- (IBAction)Deconnexion:(id)sender;

@end
