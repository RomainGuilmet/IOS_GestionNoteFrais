//
//  IndemniteK+DataModel.m
//  Phileas_Gestion
//
//  Created by Florent on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "IndemniteK+DataModel.h"

@implementation IndemniteK (DataModel)

- (void) updateIndemniteK:(NSString*)villeD villeArrivee:(NSString*)villeA allezR:(NSNumber*)AR baremeAuto:(BaremeAuto*)cylindree andDistance:(NSNumber *)distance
{
    [self setValue:villeA forKey:@"villeArrivee"];
    [self setValue:villeD forKey:@"villeDepart"];
    [self setValue:AR forKey:@"allezRetour"];
    [self setValue:cylindree forKey:@"cylindree"];
    [self setValue:distance forKey:@"distance"];
}

@end
