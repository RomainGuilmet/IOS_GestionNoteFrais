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
    
    [self chargerUtilisateur];
}

#pragma mark - actions
- (IBAction)Connexion:(id)sender {    
    utilisateur = [[User alloc] initWithPseudo:self.pseudoTextField.text motDePasse:self.mdpTextField.text andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder l'utilisateur ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

#pragma mark - methods
- (void)chargerUtilisateur
{
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pseudo" ascending:NO]]];
    
    NSError *erreur = nil;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] > 0)
    {
        utilisateur = [resultat objectAtIndex:0];
        UITabBarController* controllerDestination = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBar"];
        [self.navigationController showDetailViewController:controllerDestination sender:self];
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
