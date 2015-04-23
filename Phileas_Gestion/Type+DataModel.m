//
//  Type+DataModel.m
//  Phileas_Gestion
//
//  Created by Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Type+DataModel.h"

@implementation Type (DataModel)

- (void) initWithName:(NSString*)lib andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"Type" inManagedObjectContext:context];
    NSFetchRequest *requete = [[NSFetchRequest alloc] init];
    [requete setEntity:entiteDesc];
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"(lib LIKE[c] %@)", lib];
    [requete setPredicate:predicat];
    NSError *erreur;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] == 0){
        Type *nouveauType = [[Type alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
        [nouveauType setValue:lib forKey:@"lib"];
    }

}

+ (Type*) selectTypeFrais:(NSString*)lib andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"Type" inManagedObjectContext:context];
    NSFetchRequest *requete = [[NSFetchRequest alloc] init];
    [requete setEntity:entiteDesc];
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"(lib LIKE[c] %@)", lib];
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
