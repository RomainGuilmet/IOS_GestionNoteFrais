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

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void) viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    utilisateur = [self.appDelegate chargerUtilisateur];
    
    [self.pseudoLbl setText:utilisateur.pseudo];
}

#pragma mark - actions
/**
 * @brief Cette fonction permet de se déconnecter.
 * @brief Pour cela, elle supprime totalement l'utilisateur enregistré en local ainsi que ses brouillons locaux.
 */
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

@end
