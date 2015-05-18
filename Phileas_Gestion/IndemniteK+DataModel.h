//
//  IndemniteK+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "IndemniteK.h"
#import "BaremeAuto+DataModel.h"

@interface IndemniteK (DataModel)

/**
 * @brief Fonction permettant de modifier une indemnité kilomètrique.
 * @param villeD la ville de départ, paramètre requis
 * @param villeA la ville d'arrivée, paramètre requis
 * @param cylindree le nombre de CV,paramètre requis
 * @param distance la distance parcouru en km, paramètre requis
 */
- (void) updateIndemniteK:(NSString*)villeD villeArrivee:(NSString*)villeA allezR:(NSNumber*)AR baremeAuto:(BaremeAuto*)cylindree andDistance:(NSNumber *)distance;

@end
