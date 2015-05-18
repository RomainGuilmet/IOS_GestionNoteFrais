//
//  BaremeAuto+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 29/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "BaremeAuto.h"

@interface BaremeAuto (DataModel)

/**
 * @brief Fonction permettant de créer un barème automobile servant pour calculer les indemnitès kilométriques.
 * @param cylindre le nombre de CV du véhicule
 * @param basse la tranche basse du barème pour ce nombre de CV, i.e le nombre de km parcouru < 5000
 * @param moyenne la tranche moyenne du barème pour ce nombre de CV, i.e le nombre de km parcouru compris entre 5000 et 20000
 * @param haute la tranche haute du barème pour ce nombre de CV, i.e le nombre de km parcouru > 20000
 * @param fixe la part fixe de l'indemnitè pour ce nombre de CV pour la tranche moyenne
 * @param context le contexte de l'application (pour sauvegarder en local)
 */
- (void) initWithName:(NSString*)cylindre trancheBasse:(NSNumber*)basse trancheMoyenne:(NSNumber*)moyenne trancheHaute:(NSNumber*)haute fixe:(NSNumber*)fixe andContext:(NSManagedObjectContext*)context;

/**
 * @brief Fonction permettant de sélectionner un barème automobile.
 * @param cylindre le nombre de CV du véhicule
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return le barème automobile correspondant à cette cylindrée
 */
+ (BaremeAuto*) selectBaremeAuto:(NSString*)cylindre andContext:(NSManagedObjectContext*)context;

@end
