//
//  Sheet.h
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sheet : NSObject

@property (strong, nonatomic) NSString* creation_date;
@property (strong, nonatomic) NSNumber* latest_status_id;
@property (strong, nonatomic) NSNumber* number;

@end
