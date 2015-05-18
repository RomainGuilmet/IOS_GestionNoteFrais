//
//  Frais+DataModel.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Frais+DataModel.h"

@implementation Frais (DataModel)

/**
 * @brief Fonction permettant de créer un frais.
 * @param date la date du frais
 * @param loc la localisation de l'utilisateur
 * @param type le type de frais, ce paramètre est obligatoire
 * @param img le justificatif
 * @param montant le montant du frais
 * @param com le commentaire associé à ce frais
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return le frais créé
 */
- (Frais*) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"Frais" inManagedObjectContext:context];
    Frais *nouveauFrais = [[Frais alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
    [nouveauFrais setValue:date forKey:@"date"];
    [nouveauFrais setValue:loc forKey:@"localisation"];
    Type* typeFrais = [Type selectTypeFrais:type andContext:context];
    [nouveauFrais setValue:typeFrais forKey:@"typeFrais"];
    [nouveauFrais setValue:img forKey:@"image"];
    if(montant != nil)
    {
        [nouveauFrais setValue:montant forKey:@"montant"];
    }
    else
    {
        [nouveauFrais setValue:0 forKey:@"montant"];
    }
    
    [nouveauFrais setValue:com forKey:@"commentaire"];
    
    return nouveauFrais;
}

/**
 * @brief Fonction permettant de modifier un frais.
 * @param date la date du frais
 * @param loc la localisation de l'utilisateur
 * @param type le type de frais, ce paramètre est obligatoire
 * @param img le justificatif
 * @param montant le montant du frais
 * @param com le commentaire associé à ce frais
 * @param context le contexte de l'application (pour sauvegarder en local)
 */
- (void) updateFrais:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context
{
    [self setValue:date forKey:@"date"];
    [self setValue:loc forKey:@"localisation"];
    Type* typeFrais = [Type selectTypeFrais:type andContext:context];
    [self setValue:typeFrais forKey:@"typeFrais"];
    [self setValue:img forKey:@"image"];
    if(montant != nil)
    {
        [self setValue:montant forKey:@"montant"];
    }
    else
    {
        [self setValue:0 forKey:@"montant"];
    }
    
    [self setValue:com forKey:@"commentaire"];
}

/**
 * @brief Fonction permettant d'ajouter une indemnité kilomètrique à un frais (Utilisé si le frais et de type indemnité kilomètrique).
 * @param indemnite une indemnité kilomètrique à ajouter au frais
 */
- (void) addIndemniteK:(IndemniteK*)indemnite
{
    [self setValue:indemnite forKey:@"indemniteKFrais"];
}

@end
