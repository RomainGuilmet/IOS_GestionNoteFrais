//
//  User+DataModel.m
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "User+DataModel.h"

@implementation User (DataModel)

- (User*) initWithPseudo:(NSString*)pseudo motDePasse:(NSString*)mdp andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *requete = [[NSFetchRequest alloc] init];
    [requete setEntity:entiteDesc];
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"(pseudo LIKE[c] %@)", pseudo];
    [requete setPredicate:predicat];
    NSError *erreur;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] == 0){
        User *nouvelUtilisateur = [[User alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
        [nouvelUtilisateur setValue:pseudo forKey:@"pseudo"];
        [nouvelUtilisateur setValue:mdp forKey:@"mdp"];
        return nouvelUtilisateur;
    }
    return [resultat objectAtIndex:0];
}

@end
