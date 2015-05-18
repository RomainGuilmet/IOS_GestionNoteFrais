//
//  Sheet.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Sheet.h"

@implementation Sheet

/**
 * @brief Cette fonction permet de convertir l'id relatif à l'état d'un frais en une chaîne de caractère correspondant à cette id.
 * @param idEtat l'identifiant relatif à l'état d'un frais
 * @return label le nom de cet état
 */
- (NSString*) getLabelFromStatusId:(NSNumber*) idEtat
{
    NSString* label = @"";
    
    if([idEtat isEqualToNumber:@(validated)]){
        label = @"Validée";
    }
    else if ([idEtat isEqualToNumber:@(rejected)])
    {
        label = @"Rejetée";
    }
    else if ([idEtat isEqualToNumber:@(exportable)])
    {
        label = @"Exportable";
    }
    else if ([idEtat isEqualToNumber:@(draft)])
    {
        label = @"Ebauche";
    }
    
    return label;
}

@end
