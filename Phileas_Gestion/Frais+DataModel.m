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

- (void) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"Frais" inManagedObjectContext:context];
    Frais *nouveauFrais = [[Frais alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
    [nouveauFrais setValue:date forKey:@"date"];
    [nouveauFrais setValue:loc forKey:@"localisation"];
    Type* typeFrais = [Type selectTypeFrais:type andContext:context];
    [nouveauFrais setValue:typeFrais forKey:@"typeFrais"];
    [nouveauFrais setValue:img forKey:@"image"];
    if(montant != NULL)
    {
        [nouveauFrais setValue:montant forKey:@"montant"];
    }
    else
    {
        [nouveauFrais setValue:0 forKey:@"montant"];
    }
    
    [nouveauFrais setValue:com forKey:@"commentaire"];
}

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

@end
