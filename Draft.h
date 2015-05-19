//
//  Draft.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 11/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

/**
 * @brief Classe servant à la communication avec l'api Phileas via RestKit.
 * @brief Cette classe sert à envoyer des données relatives à un frais via la commande draft.
 */

@interface Draft : NSObject

@property (strong, nonatomic) NSNumber* def_id;
@property (strong, nonatomic) NSString* amount;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* km;
@property (strong, nonatomic) NSData* receipt;
@property (strong, nonatomic) NSString* com;
@property (strong, nonatomic) NSString* from;
@property (strong, nonatomic) NSString* to;
@property (strong, nonatomic) NSString* localisation;

/**
 * @brief Cette fonction sert à effectuer rapidement une map RestKit pour la fonction draft.
 * @brief Cela permet de connecter la class draft de l'application à la fonction draft de l'api.
 * @return mapping le RKObjectMapping pour la fonction draft.
 */
+(RKObjectMapping*)mapping;

@end
