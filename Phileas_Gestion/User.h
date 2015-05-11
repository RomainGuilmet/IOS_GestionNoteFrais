//
//  User.h
//  Phileas_Gestion
//
//  Created by Romain on 11/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Frais;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * mdp;
@property (nonatomic, retain) NSString * pseudo;
@property (nonatomic, retain) NSSet *fraisUser;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFraisUserObject:(Frais *)value;
- (void)removeFraisUserObject:(Frais *)value;
- (void)addFraisUser:(NSSet *)values;
- (void)removeFraisUser:(NSSet *)values;

@end
