//
//  Frais+DataModel.h
//  Phileas_Gestion
//
//  Created by Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Frais.h"
#import "Type+DataModel.h"

@interface Frais (DataModel)

- (void) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

- (void) updateFrais:(NSDate*)date localisation:(NSString*)loc type:(NSString *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

@end
