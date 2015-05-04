//
//  User+DataModel.h
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "User.h"

@interface User (DataModel)

- (User*) initWithPseudo:(NSString*)pseudo motDePasse:(NSString*)mdp andContext:(NSManagedObjectContext*)context;

@end
