//
//  Type+DataModel.h
//  Phileas_Gestion
//
//  Created by Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Type.h"

@interface Type (DataModel)

- (void) initWithName:(NSString*)lib andID:(NSNumber*)idType andContext:(NSManagedObjectContext*)context;

+ (Type*) selectTypeFrais:(NSString*)lib andContext:(NSManagedObjectContext*)context;

@end
