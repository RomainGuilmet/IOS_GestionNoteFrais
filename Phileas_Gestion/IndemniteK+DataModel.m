//
//  IndemniteK+DataModel.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "IndemniteK+DataModel.h"

@implementation IndemniteK (DataModel)

/**
 * @brief Fonction permettant de modifier une indemnité kilomètrique.
 * @param villeD la ville de départ, paramètre requis
 * @param villeA la ville d'arrivée, paramètre requis
 * @param cylindree le nombre de CV,paramètre requis
 * @param distance la distance parcouru en km, paramètre requis
 */
- (void) updateIndemniteK:(NSString*)villeD villeArrivee:(NSString*)villeA allezR:(NSNumber*)AR baremeAuto:(BaremeAuto*)cylindree andDistance:(NSNumber *)distance
{
    [self setValue:villeA forKey:@"villeArrivee"];
    [self setValue:villeD forKey:@"villeDepart"];
    [self setValue:AR forKey:@"allezRetour"];
    [self setValue:cylindree forKey:@"cylindree"];
    [self setValue:distance forKey:@"distance"];
}

@end
