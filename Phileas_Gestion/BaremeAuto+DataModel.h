//
//  BaremeAuto+DataModel.h
//  Phileas_Gestion
//
//  Created by Romain on 29/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "BaremeAuto.h"

@interface BaremeAuto (DataModel)

- (void) initWithName:(NSString*)cylindre trancheBasse:(NSNumber*)basse trancheMoyenne:(NSNumber*)moyenne trancheHaute:(NSNumber*)haute fixe:(NSNumber*)fixe andContext:(NSManagedObjectContext*)context;

+ (BaremeAuto*) selectBaremeAuto:(NSString*)cylindre andContext:(NSManagedObjectContext*)context;

@end
