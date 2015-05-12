//
//  Sheet.h
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sheet : NSObject

enum {
    validated = 2,
    rejected = 3,
    exportable = 4,
    draft = 5
};
typedef NSNumber* status;

@property (strong, nonatomic) NSString* creation_date;
@property (strong, nonatomic) NSNumber* latest_status_id;
@property (strong, nonatomic) NSString* object;

- (NSString*) getLabelFromStatusId:(NSNumber*) id;
@end
