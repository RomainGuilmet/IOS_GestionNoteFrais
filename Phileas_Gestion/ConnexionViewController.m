//
//  ConnexionViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "ConnexionViewController.h"

@implementation ConnexionViewController

@synthesize context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
}


- (IBAction)Connexion:(id)sender {    
    [[User alloc] initWithPseudo:self.pseudoTextField.text motDePasse:self.mdpTextField.text andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder l'utilisateur ! %@ %@", erreur, [erreur localizedDescription]);
    }
}


@end
