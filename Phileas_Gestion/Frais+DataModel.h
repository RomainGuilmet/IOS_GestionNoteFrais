//
//  Frais+DataModel.h
//  Phileas_Gestion
//
//  Created by Romain on 22/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Frais.h"

@interface Frais (DataModel)

- (Frais *) initWithDate:(NSDate*)date localisation:(NSString*)loc type:(Type *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

- (void) updateFrais:(NSDate*)date localisation:(NSString*)loc type:(Type *)type image:(NSData*)img montant:(NSNumber*)montant commentaire:(NSString*)com andContext:(NSManagedObjectContext*)context;

@end
