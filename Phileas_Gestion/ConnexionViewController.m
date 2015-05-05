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
@synthesize utilisateur;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
}

#pragma mark - actions
- (IBAction)Connexion:(id)sender {    
    utilisateur = [[User alloc] initWithPseudo:self.pseudoTextField.text motDePasse:self.mdpTextField.text andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder l'utilisateur ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

#pragma mark - TextFieldDelegates
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pseudoTextField resignFirstResponder];
    [self.mdpTextField resignFirstResponder];
    [self.view endEditing:YES];
}

@end
