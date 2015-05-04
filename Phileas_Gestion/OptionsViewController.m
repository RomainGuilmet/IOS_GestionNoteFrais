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

- (void)chargerUtilisateur
{
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pseudo" ascending:NO]]];
    
    NSError *erreur = nil;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    utilisateur = [resultat objectAtIndex:0];
    
}

- (IBAction)Deconnexion:(id)sender {
    [context deleteObject:utilisateur];
}
@end
