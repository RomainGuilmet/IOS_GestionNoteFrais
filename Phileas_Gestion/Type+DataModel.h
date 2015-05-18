//
//  Type+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Type.h"

@interface Type (DataModel)

/**
 * @brief Fonction permettant de créer un type de frais.
 * @param lib le libelé du type de frais, paramètre obligatoire
 * @param idType l'id du type de frais, paramètre obligatoire
 * @param context le contexte de l'application (pour sauvegarder en local)
 */
- (void) initWithName:(NSString*)lib andID:(NSNumber*)idType andContext:(NSManagedObjectContext*)context;

/**
 * @brief Fonction permettant de sélectionner un tyoe de frais.
 * @param lib le libelé du type de frais, ce paramètre est obligatoire
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return le type de frais associé au libelé
 */
+ (Type*) selectTypeFrais:(NSString*)lib andContext:(NSManagedObjectContext*)context;

@end
