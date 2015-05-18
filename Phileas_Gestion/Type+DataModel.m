//
//  Type+DataModel.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Type+DataModel.h"

@implementation Type (DataModel)

/**
 * @brief Fonction permettant de créer un type de frais.
 * @param lib le libelé du type de frais, paramètre obligatoire
 * @param idType l'id du type de frais, paramètre obligatoire
 * @param context le contexte de l'application (pour sauvegarder en local)
 */
- (void) initWithName:(NSString*)lib andID:(NSNumber*)idType andContext:(NSManagedObjectContext*)context
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
        [nouveauType setValue:idType forKey:@"idType"];
    }
}

/**
 * @brief Fonction permettant de sélectionner un tyoe de frais.
 * @param lib le libelé du type de frais, ce paramètre est obligatoire
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return le type de frais associé au libelé
 */
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
