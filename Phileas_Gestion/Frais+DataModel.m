//
//  Frais+DataModel.m
//  Phileas_Gestion
//
//  Created by Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Frais+DataModel.h"

@implementation Frais (DataModel)

/*
 Penser à vérifier les champs et à rechercher le type grâce à la string
*/

- (Frais *) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"Frais" inManagedObjectContext:context];
    Frais *nouveauFrais = [[Frais alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
    /*[nouveauFrais setValue:date forKey:@"date"];
    [nouveauFrais setValue:loc forKey:@"localisation"];
    [nouveauFrais setValue:type forKey:@"typeFrais"];*/
    return nouveauFrais;

}

- (void) updateFrais:(NSDate*)date localisation:(NSString*)loc type:(Type *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context
{
    /*
    [self setValue:cat forKey:@"categorie"];
    [self setValue:theme forKey:@"theme"];
    */
}

@end
