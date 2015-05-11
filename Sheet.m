//
//  Sheet.m
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "Sheet.h"

@implementation Sheet

- (NSString*) getLabelFromStatusId:(NSNumber*) id
{
    NSString* label = @"";
    
    if([id isEqualToNumber:@(validated)]){
        label = @"Validée";
    }
    else if ([id isEqualToNumber:@(rejected)])
    {
        label = @"Rejetée";
    }
    else if ([id isEqualToNumber:@(exportable)])
    {
        label = @"Exportable";
    }
    else if ([id isEqualToNumber:@(draft)])
    {
        label = @"Ebauche";
    }
    
    return label;
}

@end
