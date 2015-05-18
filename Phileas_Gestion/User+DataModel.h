//
//  User+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "User.h"

@interface User (DataModel)

/**
 * @brief Fonction permettant de créer un utilisateur.
 * @param pseudo le pseudo de l'utilisateur
 * @param mdp le mot de passe de l'utilisateur
 * @param context le contexte de l'application (pour sauvegarder en local)
 * @return l'utilisateur créé
 */
- (User*) initWithPseudo:(NSString*)pseudo motDePasse:(NSString*)mdp andContext:(NSManagedObjectContext*)context;

@end
