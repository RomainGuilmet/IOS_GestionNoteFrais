//
//  IndemniteK+DataModel.h
//  Phileas_Gestion
//
//  Created by Florent on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "IndemniteK.h"
#import "BaremeAuto+DataModel.h"

@interface IndemniteK (DataModel)

- (void) updateIndemniteK:(NSString*)villeD villeArrivee:(NSString*)villeA allezR:(NSNumber*)AR baremeAuto:(BaremeAuto*)cylindree andDistance:(NSNumber *)distance;

@end
