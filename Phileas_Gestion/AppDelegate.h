//
//  AppDelegate.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 21/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import "User+DataModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/**
 * @brief Cette fonction permet de savoir si un utilisateur est déjà connecté.
 * @brief Si un utilisateur est sauvé en local alors nous considérons qu'il est connecté et l'application passera la page de connexion.
 * @return true si un utilisateur existe, false sinon.
 */
- (BOOL) estConnecte;

/**
 * @brief Cette fonction permet de charger les informations concernant l'utilisateur connecté.
 */
- (User *) chargerUtilisateur;

@end

