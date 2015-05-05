//
//  OptionsViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "OptionsViewController.h"

@implementation OptionsViewController

@synthesize context;

- (void) viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    //[self chargerUtilisateur];
    
    [self.pseudoLbl setText:utilisateur.pseudo];
}

- (IBAction)Deconnexion:(id)sender {
    [context deleteObject:utilisateur];
}
@end
