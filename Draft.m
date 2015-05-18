//
//  Draft.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 11/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Draft.h"

@implementation Draft

/**
 * @brief Cette fonction sert à effectuer rapidement une map RestKit pour la fonction draft.
 * @brief Cela permet de connecter la class draft de l'application à la fonction draft de l'api.
 * @return mapping le RKObjectMapping pour la fonction draft.
 */
+(RKObjectMapping*)mapping   {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Draft class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"def_id": @"def_id",
                                                  @"amount": @"amount",
                                                  @"date": @"date",
                                                  @"km": @"km",
                                                  @"receipt1": @"receipt",
                                                  @"details.comment": @"com",
                                                  @"details.from": @"from",
                                                  @"details.to": @"to"
                                                  }];
    
    
    return mapping;
    
}

@end
