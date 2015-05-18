//
//  Frais+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Frais.h"
#import "Type+DataModel.h"

@interface Frais (DataModel)

/**
 * @brief Fonction permettant de créer un frais.
 * @param date la date du frais
 * @param loc la localisation de l'utilisateur
 * @param type le type de frais, ce paramètre est obligatoire
 * @param img le justificatif
 * @param montant le montant du frais
 * @param com le commentaire associé à ce frais
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return le frais créé
 */
- (Frais*) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

/**
 * @brief Fonction permettant de modifier un frais.
 * @param date la date du frais
 * @param loc la localisation de l'utilisateur
 * @param type le type de frais, ce paramètre est obligatoire
 * @param img le justificatif
 * @param montant le montant du frais
 * @param com le commentaire associé à ce frais
 * @param context le contexte de l'application (pour sauvegarder en local)
 */
- (void) updateFrais:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

/**
 * @brief Fonction permettant d'ajouter une indemnité kilomètrique à un frais (Utilisé si le frais et de type indemnité kilomètrique).
 * @param indemnite une indemnité kilomètrique à ajouter au frais
 */
- (void) addIndemniteK:(IndemniteK*)indemnite;
@end
