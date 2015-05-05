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
@synthesize utilisateur;

- (void) viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    [self chargerUtilisateur];
    
    [self.pseudoLbl setText:utilisateur.pseudo];
}

#pragma mark - actions

- (IBAction)Deconnexion:(id)sender {
    
    NSArray * tableauFrais = [utilisateur.fraisUser allObjects];
    for(int i =0; i<[tableauFrais count]; i++)
    {
        [context deleteObject:[tableauFrais objectAtIndex:i]];
        
    }
    
    [context deleteObject:utilisateur];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de se déconnecter ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

#pragma mark - methods

- (void) chargerUtilisateur
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
    }
}
@end
