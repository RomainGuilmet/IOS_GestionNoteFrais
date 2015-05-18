//
//  Sheet.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief Classe servant à la communication avec l'api Phileas via RestKit.
 * @brief Cette classe sert pour récupérer des données d'un frais via la commande sheet.
 */

@interface Sheet : NSObject

enum {
    validated = 2,
    rejected = 3,
    exportable = 4,
    draft = 5
};
typedef NSNumber* status;

@property (strong, nonatomic) NSString* creation_date;
@property (strong, nonatomic) NSNumber* latest_status_id;
@property (strong, nonatomic) NSString* object;

/**
 * @brief Cette fonction permet de convertir l'id relatif à l'état d'un frais en une chaîne de caractère correspondant à cette id.
 * @param idEtat l'identifiant relatif à l'état d'un frais
 * @return label le nom de cet état
 */
- (NSString*) getLabelFromStatusId:(NSNumber*) idEtat;
@end
