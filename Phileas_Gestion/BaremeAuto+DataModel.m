//
//  BaremeAuto+DataModel.m
//  Phileas_Gestion
//
//  Created by Romain on 29/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "BaremeAuto+DataModel.h"

@implementation BaremeAuto (DataModel)

- (void) initWithName:(NSString*)cylindre trancheBasse:(NSNumber*)basse trancheMoyenne:(NSNumber*)moyenne trancheHaute:(NSNumber*)haute fixe:(NSNumber*)fixe andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"BaremeAuto" inManagedObjectContext:context];
    NSFetchRequest *requete = [[NSFetchRequest alloc] init];
    [requete setEntity:entiteDesc];
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"(cylindre LIKE[c] %@)", cylindre];
    [requete setPredicate:predicat];
    NSError *erreur;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] == 0){
        BaremeAuto *nouveauBareme = [[BaremeAuto alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
        [nouveauBareme setValue:cylindre forKey:@"cylindre"];
        [nouveauBareme setValue:basse forKey:@"basse"];
        [nouveauBareme setValue:moyenne forKey:@"moyenne"];
        [nouveauBareme setValue:haute forKey:@"haute"];
        [nouveauBareme setValue:fixe forKey:@"fixe"];
    }
    
}

+ (BaremeAuto*) selectBaremeAuto:(NSString*)cylindre andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"BaremeAuto" inManagedObjectContext:context];
    NSFetchRequest *requete = [[NSFetchRequest alloc] init];
    [requete setEntity:entiteDesc];
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"(cylindre LIKE[c] %@)", cylindre];
    [requete setPredicate:predicat];
    NSError *erreur;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    
    if([resultat count] > 0){
        return [resultat objectAtIndex:0];
    }
    else{
        return nil;
    }
}

@end
